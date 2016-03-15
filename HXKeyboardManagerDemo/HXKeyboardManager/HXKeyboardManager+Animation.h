//
//  HXKeyboardManager+Animation.h
//  HXKeyboardManagerDemo
//
//  Created by HongXiangWen on 16/3/15.
//  Copyright © 2016年 WHX. All rights reserved.
//

#import "HXKeyboardManager.h"

@interface HXKeyboardManager (Animation)

/**
 *  躲开键盘的动画，使用默认目标view
 */
+ (void)dodgeKeyboardAnimation;

/**
 *  基于目标view躲开键盘的动画
 *
 *  @param targenView 目标view
 */
+ (void)dodgeKeyboardAnimationWithView:(UIView *)targetView;


@end
