//
//  MBProgressHUD+YL.h
//  BaseObject
//
//  Created by Eli on 16/7/7.
//  Copyright © 2016年 Eli. All rights reserved.
//

#import "MBProgressHUD.h"

//#import "MBProgressHUD.h"
@interface MBProgressHUD (YL)
+ (void)showSuccess:(NSString *)success toView:(UIView *)view;
+ (void)showError:(NSString *)error toView:(UIView *)view;

+ (MBProgressHUD *)showMessage:(NSString *)message toView:(UIView *)view;
+ (MBProgressHUD *)showLoadingMessage:(NSString *)message toView:(UIView *)view;

+ (void)showSuccess:(NSString *)success;
+ (void)showError:(NSString *)error;

+ (MBProgressHUD *)showMessage:(NSString *)message;

+ (void)hideHUDForView:(UIView *)view;
+ (void)hideHUD;

+(void)showAlert:(NSString* )text andView:(UIView*)view;

+ (void)showSuccess:(NSString *)success andView:(UIView*)view;
+ (void)showError:(NSString *)error andView:(UIView*)view;
///** 弹出文字提示 */
//- (void)showAlert:(NSString *)text;
///** 显示忙 */
//- (void)showBusy;
///** 隐藏提示 */
//- (void)hideProgress;
@end
