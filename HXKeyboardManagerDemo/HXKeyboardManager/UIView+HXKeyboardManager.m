//
//  UIView+HXKeyboardManager.m
//  HXKeyboardManagerDemo
//
//  Created by HongXiangWen on 16/3/15.
//  Copyright © 2016年 WHX. All rights reserved.
//

#import "UIView+HXKeyboardManager.h"
#import <objc/runtime.h>
#import "HXKeyboardManager.h"

@implementation UIView (HXKeyboardManager)

#pragma mark -- private method

+ (void)load
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Method originalMethod = class_getInstanceMethod([self class], @selector(becomeFirstResponder));
        Method swizzledMethod = class_getInstanceMethod([self class], @selector(swizzled_becomeFirstResponder));
        method_exchangeImplementations(originalMethod, swizzledMethod);
    });
}

- (BOOL)swizzled_becomeFirstResponder
{
    if ([HXKeyboardManager accessObject].observerView) {
        if ([self isViewInSuperView:[HXKeyboardManager accessObject].observerView]) {
            [HXKeyboardManager changeFirstResponder:self];
        }
    }
    return [self swizzled_becomeFirstResponder];
}

- (BOOL)isViewInSuperView:(UIView *)targetView
{
    if (self.superview) {
        if (self.superview == targetView) {
            return YES;
        } else {
            return [self.superview isViewInSuperView:targetView];
        }
    } else {
        return NO;
    }
}

#pragma mark -- public method

- (UIView *)findFirstResponder
{
    if (self.isFirstResponder) return self;
    for (UIView *subView in self.subviews) {
        UIView *firstResponder = [subView findFirstResponder];
        if (firstResponder != nil) return firstResponder;
    }
    return nil;
}

@end
