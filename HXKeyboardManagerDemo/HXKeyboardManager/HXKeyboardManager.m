//
//  HXKeyboardManager.m
//  HXKeyboardManagerDemo
//
//  Created by HongXiangWen on 16/3/15.
//  Copyright © 2016年 WHX. All rights reserved.
//

#import "HXKeyboardManager.h"
#import <objc/runtime.h>
#import "HXKeyboardManager+Animation.h"
#import "UIView+HXKeyboardManager.h"

@interface HXKeyboardManager () <UIGestureRecognizerDelegate>

@end

@implementation HXKeyboardManager

#pragma mark -- public method

+ (void)registerDodgeKeyboardView:(UIView *)view
{
    [self accessObject].observerView = view;
    [self accessObject].originalViewFrame = view.frame;
    [self accessObject].isKeyboardShow = NO;
    [self accessObject].showToolbar = YES;
    [self addObservers];
    [self addToolbar];
}

+ (void)removeRegisterDodgeKeyboard
{
    objc_removeAssociatedObjects(self);
    [self removeObservers];
}

+ (void)changeFirstResponder:(UIView *)newFirstResponder
{
    if ([self accessObject].isKeyboardShow) {
        [self dodgeKeyboardAnimationWithView:newFirstResponder];
        [self accessObject].firstResponderView = newFirstResponder;
    } else {
        [self accessObject].firstResponderView = newFirstResponder;
    }
}

+ (void)shouldShowToolbar:(BOOL)showToolbar
{
    [self accessObject].showToolbar = showToolbar;
    [self addToolbar];
}

#pragma mark -- private method

+ (void)keyboardWillShow:(NSNotification *)notification
{
    // 当第一次显示键盘时
    if (![self accessObject].isKeyboardShow) {
        [self accessObject].isKeyboardShow = YES;
        //get UITextEffectsWindow
        for (UIWindow *eachWindow in [UIApplication sharedApplication].windows) {
            if ([eachWindow isKindOfClass:NSClassFromString(@"UITextEffectsWindow")]) {
                [self accessObject].textEffectsWindow = eachWindow;
            }
        }
    }
    NSDictionary *userInfo = [notification userInfo];
    [self accessObject].keyboardAnimationDutation = [[userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    [self accessObject].keyboardFrame = [[userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    [self dodgeKeyboardAnimation];
}

+ (void)keyboardWillHide:(NSNotification *)notification
{
    [self accessObject].isKeyboardShow = NO;
    [self dodgeKeyboardAnimation];
}

+ (void)addObservers
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
}

+ (void)removeObservers
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
}

+ (void)addToolbar
{
    UIToolbar *toolBar = [self createToolbar];
    for (UIView *v in [self accessObject].observerView.subviews) {
        if ([v respondsToSelector:@selector(setText:)]) {
            [v performSelector:@selector(setInputAccessoryView:) withObject:[self accessObject].showToolbar ? toolBar : nil];
        }
    }
}

+ (UIToolbar *)createToolbar
{
    UIToolbar *toolBar = [UIToolbar new];
    UIBarButtonItem *nextButton = [[UIBarButtonItem alloc] initWithTitle:@"Next" style:UIBarButtonItemStylePlain target:self action:@selector(nextResponder)];
    UIBarButtonItem *prevButton = [[UIBarButtonItem alloc] initWithTitle:@"Prev" style:UIBarButtonItemStylePlain target:self action:@selector(prevResponder)];
    UIBarButtonItem *space = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    UIBarButtonItem *done = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(responderDone)];
    toolBar.items = @[prevButton, nextButton, space, done];
    [toolBar sizeToFit];
    return toolBar;
}

+ (void)nextResponder
{
    NSUInteger currentIndex = [[self inputViews] indexOfObject:[[self accessObject].observerView findFirstResponder]];
    NSUInteger nextIndex = currentIndex + 1;
    nextIndex += [[self inputViews] count];
    nextIndex %= [[self inputViews] count];
    UIView *nextResponder = [[self inputViews] objectAtIndex:nextIndex];
    [nextResponder becomeFirstResponder];
}

+ (void)prevResponder
{
    NSUInteger currentIndex = [[self inputViews] indexOfObject:[[self accessObject].observerView findFirstResponder]];
    NSUInteger prevIndex = currentIndex - 1;
    prevIndex += [[self inputViews] count];
    prevIndex %= [[self inputViews] count];
    UIView *prevResponder = [[self inputViews] objectAtIndex:prevIndex];
    [prevResponder becomeFirstResponder];
}

+ (void)responderDone
{
    [[[self accessObject].observerView findFirstResponder] resignFirstResponder];
}

+ (NSArray *)inputViews
{
    NSMutableArray *returnArray = [NSMutableArray array];
    for (UIView *eachView in [self accessObject].observerView.subviews) {
        if ([eachView respondsToSelector:@selector(setText:)]) {
            [returnArray addObject:eachView];
        }
    }
    return returnArray;
}

@end

@implementation HXKeyboardManager (AccessObject)

+ (HXKeyboardAccessObject *)accessObject
{
    if (!objc_getAssociatedObject(self, _cmd)) {
        HXKeyboardAccessObject *accessObject = [[HXKeyboardAccessObject alloc] init];
        objc_setAssociatedObject(self, _cmd, accessObject, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return objc_getAssociatedObject(self, _cmd);
}

@end
