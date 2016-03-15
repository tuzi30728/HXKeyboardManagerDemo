//
//  HXKeyboardManager+Animation.m
//  HXKeyboardManagerDemo
//
//  Created by HongXiangWen on 16/3/15.
//  Copyright © 2016年 WHX. All rights reserved.
//

#import "HXKeyboardManager+Animation.h"

static const CGFloat keyboardDistanceFromFirstResponder = 10.0f;

@implementation HXKeyboardManager (Animation)

#pragma mark - public method

+ (void)dodgeKeyboardAnimation
{
    CGFloat currentKeyboardHeight = MAX([self currentKeyboardFrame].origin.x, [self currentKeyboardFrame].origin.y);
    CGRect currentFirstResponderFrame = [self currentFirstResponderFrame:[self accessObject].firstResponderView];
    CGFloat viewFloor = currentFirstResponderFrame.origin.y + currentFirstResponderFrame.size.height;
    BOOL isCrossOnKeyboard = (viewFloor >= currentKeyboardHeight);
    
    if (isCrossOnKeyboard && [self accessObject].isKeyboardShow) {
        CGFloat currentShift = viewFloor - currentKeyboardHeight - [self accessObject].shiftHeight;
        [UIView animateWithDuration:[self accessObject].keyboardAnimationDutation animations: ^{
            CGRect newFrame = [self accessObject].observerView.frame;
            newFrame.origin.y = [self accessObject].observerView.frame.origin.y - currentShift - keyboardDistanceFromFirstResponder < 0 ? [self accessObject].observerView.frame.origin.y - currentShift - keyboardDistanceFromFirstResponder : 0;
            [self accessObject].observerView.frame = newFrame;
        } completion:^(BOOL finished) {
            [self accessObject].shiftHeight = -[self accessObject].observerView.frame.origin.y;
        }];
    } else if (![self accessObject].isKeyboardShow) {
        [UIView animateWithDuration:[self accessObject].keyboardAnimationDutation animations: ^{
            [self accessObject].observerView.frame = [self accessObject].originalViewFrame;
        } completion:^(BOOL finished) {
            [self accessObject].shiftHeight = 0;
        }];
    }
}

+ (void)dodgeKeyboardAnimationWithView:(UIView *)targetView
{
    CGFloat currentKeyboardHeight = MAX([self currentKeyboardFrame].origin.x, [self currentKeyboardFrame].origin.y);
    CGRect currentFirstResponderFrame = [self currentFirstResponderFrame:targetView];
    CGFloat viewFloor = currentFirstResponderFrame.origin.y + currentFirstResponderFrame.size.height;
    BOOL isCrossOnKeyboard = (viewFloor >= currentKeyboardHeight);
    
    if (isCrossOnKeyboard) {
        CGFloat currentShift = viewFloor - currentKeyboardHeight - [self accessObject].shiftHeight;

        [UIView animateWithDuration:[self accessObject].keyboardAnimationDutation animations: ^{
            CGRect newFrame = [self accessObject].observerView.frame;
            newFrame.origin.y = [self accessObject].observerView.frame.origin.y - currentShift;
            [self accessObject].observerView.frame = newFrame;
        } completion:^(BOOL finished) {
            [self accessObject].shiftHeight = -[self accessObject].observerView.frame.origin.y;
        }];
    } else {
        [UIView animateWithDuration:[self accessObject].keyboardAnimationDutation animations: ^{
            [self accessObject].observerView.frame = [self accessObject].originalViewFrame;
        } completion:^(BOOL finished) {
            [self accessObject].shiftHeight = 0;
        }];
    }
}

#pragma mark - private method

+ (CGRect)currentKeyboardFrame
{
    return [[self accessObject].textEffectsWindow convertRect:[self accessObject].keyboardFrame fromView:nil];
}

+ (CGRect)currentFirstResponderFrame:(UIView *)view
{
    CGRect currentFirstResponderFrame = [[self accessObject].textEffectsWindow convertRect:view.frame fromView:view.superview];
    currentFirstResponderFrame.origin.y += [self accessObject].shiftHeight;
    return currentFirstResponderFrame;
}


@end
