//
//  HXKeyboardAccessObject.h
//  HXKeyboardManagerDemo
//
//  Created by HongXiangWen on 16/3/15.
//  Copyright © 2016年 WHX. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface HXKeyboardAccessObject : NSObject

/**
 *  目标view
 */
@property (nonatomic, strong) UIView *observerView;

/**
 *  textEffectsWindow
 */
@property (nonatomic, strong) UIWindow *textEffectsWindow;

/**
 *  第一响应者view
 */
@property (nonatomic, strong) UIView *firstResponderView;

/**
 *  初始view的frame
 */
@property (nonatomic, assign) CGRect originalViewFrame;

/**
 *  键盘frame
 */
@property (nonatomic, assign) CGRect keyboardFrame;

/**
 *  改变的高度
 */
@property (nonatomic, assign) CGFloat shiftHeight;

/**
 *  动画时间
 */
@property (nonatomic, assign) double keyboardAnimationDutation;

/**
 *  键盘是否显示
 */
@property (nonatomic, assign) BOOL isKeyboardShow;

/**
 *  是否显示toolbar，默认YES
 */
@property (nonatomic, assign) BOOL showToolbar;

@end
