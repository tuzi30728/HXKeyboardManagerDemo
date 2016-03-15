//
//  ViewController.m
//  HXKeyboardManagerDemo
//
//  Created by HongXiangWen on 16/3/15.
//  Copyright © 2016年 WHX. All rights reserved.
//

#import "ViewController.h"
#import "HXKeyboardManager.h"

@interface ViewController ()

@end

@implementation ViewController
#pragma mark - UITextViewDelegate

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if ([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        return NO;
    } else {
        return YES;
    }
}

#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}
#pragma mark - life cycle

- (void)viewDidLoad
{
    [super viewDidLoad];

    [HXKeyboardManager registerDodgeKeyboardView:self.view];
//    [HXKeyboardManager shouldShowToolbar:NO];
}
@end
