//
//  UIView+HXKeyboardManager.h
//  HXKeyboardManagerDemo
//
//  Created by HongXiangWen on 16/3/15.
//  Copyright © 2016年 WHX. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (HXKeyboardManager)

/**
 *  获取当前第一响应者
*/
- (UIView *)findFirstResponder;

@end
