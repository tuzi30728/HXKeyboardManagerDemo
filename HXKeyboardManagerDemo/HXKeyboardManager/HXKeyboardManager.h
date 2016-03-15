//
//  HXKeyboardManager.h
//  HXKeyboardManagerDemo
//
//  Created by HongXiangWen on 16/3/15.
//  Copyright © 2016年 WHX. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "HXKeyboardAccessObject.h"

@interface HXKeyboardManager : NSObject

/**
 *  注册需要避开键盘的view
 */
+ (void)registerDodgeKeyboardView:(UIView *)view;

/**
 *  移除
 */
+ (void)removeRegisterDodgeKeyboard;

/**
 *  是否显示toolbar
 */
+ (void)shouldShowToolbar:(BOOL)showToolbar;

/**
 *  切换第一响应者
 */
+ (void)changeFirstResponder:(UIView *)newFirstResponder;

@end


@interface HXKeyboardManager (AccessObject)

+ (HXKeyboardAccessObject *)accessObject;

@end