//
//  MBProgressHUD+YL.m
//  BaseObject
//
//  Created by Eli on 16/7/7.
//  Copyright © 2016年 Eli. All rights reserved.
//

#import "MBProgressHUD+YL.h"

@implementation MBProgressHUD (YL)

+ (void)show:(NSString *)text icon:(NSString *)icon view:(UIView *)view
{
    
    
    if (view == nil) view = [[UIApplication sharedApplication].windows firstObject];
    // 快速显示一个提示信息
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    
    hud.labelText = text;
//    NSLog(@"%@------text",text);
    // 设置图片
    hud.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@", icon]]];
    // 再设置模式
    hud.mode = MBProgressHUDModeCustomView;
    
    // 隐藏时候从父控件中移除
    hud.removeFromSuperViewOnHide = YES;
    
    // 1秒之后再消失
    [hud hide:YES afterDelay:1.2];
}

#pragma mark 显示错误信息
+ (void)showError:(NSString *)error toView:(UIView *)view{
    
    [self show:error icon:@"error" view:view];
}

+ (void)showSuccess:(NSString *)success toView:(UIView *)view
{
    [self show:success icon:@"success.png" view:view];
}

#pragma mark 显示一些信息
+ (MBProgressHUD *)showMessage:(NSString *)message toView:(UIView *)view {
    if (view == nil) view = [[UIApplication sharedApplication].windows lastObject];
//    NSLog(@"%f width %f height.........",view.frame.size.width,view.frame.size.height);
    // 快速显示一个提示信息
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.labelText = message;
    // 隐藏时候从父控件中移除
    hud.removeFromSuperViewOnHide = YES;
    // YES代表需要蒙版效果
    hud.dimBackground = YES;
//    [hud hide:YES afterDelay:2.5];
    return hud;
}

+ (MBProgressHUD *)showLoadingMessage:(NSString *)message toView:(UIView *)view {
    if (view == nil) view = [[UIApplication sharedApplication].windows lastObject];
    // 快速显示一个提示信息
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.labelText = message;
    // 隐藏时候从父控件中移除
    hud.removeFromSuperViewOnHide = YES;
    // YES代表需要蒙版效果
    hud.dimBackground = YES;
    return hud;
}

+ (void)showSuccess:(NSString *)success
{
    [self showSuccess:success toView:nil];
}

+ (void)showSuccess:(NSString *)success andView:(UIView*)view
{
    [self showSuccess:success toView:view];
}


+ (void)showError:(NSString *)error
{
    UIView* view=[[UIApplication sharedApplication].windows firstObject];
    [self showError:error toView:view];
}
+ (void)showError:(NSString *)error andView:(UIView*)view
{
    
    [self showError:error toView:view];
}

+ (MBProgressHUD *)showMessage:(NSString *)message
{
    return [self showMessage:message toView:nil];
}

+ (void)hideHUDForView:(UIView *)view
{
    [self hideHUDForView:view animated:YES];
}

+ (void)hideHUD
{
    [self hideHUDForView:nil];
}



- (UIView *)currentView{
    UIViewController *vc=[UIApplication sharedApplication].keyWindow.rootViewController;
    // vc: 导航控制器, 标签控制器, 普通控制器
    if ([vc isKindOfClass:[UITabBarController class]]) {
        vc = [(UITabBarController *)vc selectedViewController];
    }
    if ([vc isKindOfClass:[UINavigationController class]]) {
        vc = [(UINavigationController *)vc visibleViewController];
    }
    return vc.view;
}


+(void)showAlert:(NSString* )text andView:(UIView*)view
{
    dispatch_async(dispatch_get_main_queue(), ^{
                //    弹出新的提示之前,先把旧的隐藏掉
                //        [self hideProgress];
    [MBProgressHUD hideAllHUDsForView:view animated:YES];
    MBProgressHUD *progressHUD=[MBProgressHUD showHUDAddedTo:view animated:YES];
    progressHUD.mode = MBProgressHUDModeText;
    progressHUD.labelText = text;
    [progressHUD hide:YES afterDelay:2];
    });
}


///** 弹出文字提示 */
//- (void)showAlert:(NSString *)text{
//    //防止在非主线程中调用此方法,会报错
//    dispatch_async(dispatch_get_main_queue(), ^{
//        //    弹出新的提示之前,先把旧的隐藏掉
//        //        [self hideProgress];
//        [MBProgressHUD hideAllHUDsForView:[self currentView] animated:YES];
//        MBProgressHUD *progressHUD=[MBProgressHUD showHUDAddedTo:[self currentView] animated:YES];
//        progressHUD.mode = MBProgressHUDModeText;
//        progressHUD.labelText = text;
//        [progressHUD hide:YES afterDelay:1.5];
//    });
//}
///** 显示忙 */
//- (void)showBusy{
//    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
//        
//        //        [self hideProgress];
//        [MBProgressHUD hideAllHUDsForView:[self currentView] animated:YES];
//        MBProgressHUD *progressHUD=[MBProgressHUD showHUDAddedTo:[self currentView] animated:YES];
//        //最长显示30秒
//        [progressHUD hide:YES afterDelay:30];
//        
//    }];
//    
//}
///** 隐藏提示 */
//- (void)hideProgress{
//    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
//        [MBProgressHUD hideAllHUDsForView:[self currentView] animated:YES];
//    }];
//}



@end
