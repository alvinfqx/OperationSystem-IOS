//
//  ViewController.m
//  MFOS-iOS
//
//  Created by Alvin.Feng on 2017/12/20.
//  Copyright © 2017年 Alvin.Feng. All rights reserved.
//

#import "LoginViewController.h"
//#import "MainViewController.h"
#import "LoginModel.h"
//#import "BottomTabBarController.h"
#import "MainNewViewController.h"
#import "MainNewNavigationController.h"
#import <adSupport/ASIdentifierManager.h>
#import "FDAlertView.h"
#import "CustomMessageView.h"

@interface LoginViewController ()<sendTheValueDelegate>//验证码获取的代理
//验证码
{
    CustomMessageView * contentView;
    FDAlertView *alert;
}
@property (weak, nonatomic) IBOutlet UIView *account;
@property (weak, nonatomic) IBOutlet UIView *password;
@property (weak, nonatomic) IBOutlet UIButton *rememberPassworkBtn;
@property (weak, nonatomic) IBOutlet UIButton *logonBtn;
@property (weak, nonatomic) IBOutlet UITextField *accountVal;
@property (weak, nonatomic) IBOutlet UITextField *passwordVal;

@end

@implementation LoginViewController

/*
 1.系统调用
 2.控制器的view加载完毕的时候调用
 3.控件的初始化，数据的初始化（懒加载）
 */
- (void)viewDidLoad {
    [super viewDidLoad];
    //自定义封装：账号view的样式
    [UIView AddLayer:_account.layer];
    //自定义封装：密码view的样式
    [_password AddLayerOther];
    //记住密码：默认状态图片
    [_rememberPassworkBtn setImage:[UIImage imageNamed:@"false"] forState:UIControlStateNormal];
    //记住密码：选中状态图片
    [_rememberPassworkBtn setImage:[UIImage imageNamed:@"true"] forState:UIControlStateSelected];
    //登录按钮：边框圆滑
    _logonBtn.layer.cornerRadius = 10.0f;
    /*
     在下面点击登录按钮事件中写了存储数据到本地的事件
     判断本地存储：是否是记住密码
     记住密码后：获取本地存储的数据---赋值账号密码
     */
    BOOL isSelectedPass = [[NSUserDefaults standardUserDefaults] boolForKey:@"IsRememberPassword"];
    if(isSelectedPass){
        _accountVal.text = [NSString stringWithFormat:@"%@" ,[[NSUserDefaults standardUserDefaults] objectForKey:@"username"]];
        _passwordVal.text = [NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"password"]];
        _rememberPassworkBtn.selected = YES;
    }
    
    /*绑定开窗*/
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow1:) name:UIKeyboardWillShowNotification object:nil];
    // 监听键盘即将消失的事件. UIKeyboardWillHideNotification
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHidden2:) name:UIKeyboardWillHideNotification object:nil];
    
}

//记住密码：切换是否选中状态
- (IBAction)clickRememPass:(UIButton *)sender {
    sender.selected = !sender.selected;
}

//点击背景屏幕，隐藏输入键盘
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
//    if (alert)
//    {
//        [alert hide];
//    }
}

//点击登录按钮
- (IBAction)clickLoginBtnNow:(id)sender {

    if(_accountVal.text.length<=0){
        [MBProgressHUD showAlert:@"账号不能为空!" andView:self.view];
        return;
    }
    if(_passwordVal.text.length<=0){
        [MBProgressHUD showAlert:@"密码不能为空!" andView:self.view];
        return;
    }
    LoginModel* model=[LoginModel new];
    model.username=[_accountVal.text stringByReplacingOccurrencesOfString:@" " withString:@""];
    model.password=[_passwordVal.text stringByReplacingOccurrencesOfString:@" " withString:@""];
    //字典形式获取账号密码和设备标示
    NSDictionary* dic=@{@"Name":model.username,@"Password":[model.password md5Str],@"IMEI":[[UIDevice currentDevice].identifierForVendor UUIDString]};
    
    //连接地址
    NSString* urlStr=[NSString stringWithFormat:@"%@/App/Login",PathStr];
    NSLog(@"xdataLoginParam-----------%@",dic);
    [MBProgressHUD showMessage:@"登录中..." toView:self.view];
    
    //请求方法
    [HttpsHelper postWithUrlString:urlStr parameters:dic success:^(NSDictionary *data) {
        
        //数据处理需要返回主线程：1 ，子线程：2，3...
        NSLog(@"dataLoginBack-----%@",data);
        //字典获取值转换成字符串
        NSString* statusStr=[NSString stringWithFormat:@"%@",data[@"status"]];
        NSString* msgStr=[NSString stringWithFormat:@"%@",data[@"msg"]];
        NSString* tokenStr = [NSString stringWithFormat:@"%@",data[@"Token"]];
        //登录成功
        if([statusStr isEqualToString:@"200"]){
            [[NSUserDefaults standardUserDefaults] setObject:_accountVal.text forKey:@"username"];
            [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"Token"];
            [[NSUserDefaults standardUserDefaults] setObject:tokenStr forKey:@"Token"];
            NSLog(@"%@-------Token",tokenStr);
            
            //记住密码选中时候
            if (_rememberPassworkBtn.selected) {
                [[NSUserDefaults standardUserDefaults] setBool:_rememberPassworkBtn.selected forKey:@"IsRememberPassword"];
                [[NSUserDefaults standardUserDefaults] setObject:_passwordVal.text forKey:@"password"];
            }else{//记住密码未选中时候
                [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"IsRememberPassword"];
                [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"password"];
            }
            //
            //                sleep(1.5);
            [MBProgressHUD hideHUDForView:self.view];
            //显示成功弹窗
            [MBProgressHUD showSuccess:msgStr];
            
            //跳转界面方法
            MainNewNavigationController* mainNew=[self.storyboard instantiateViewControllerWithIdentifier:@"MainNNVC"];
            [self presentViewController:mainNew animated:YES completion:nil];
            
            
        }
        else if([statusStr isEqualToString:@"480"]){
            [MBProgressHUD showAlert:msgStr andView:self.view];
            alert = [[FDAlertView alloc] init];
            contentView=[[CustomMessageView alloc]initWithFrame:CGRectMake(0, 0, 290, 170)];
            
            contentView.userName = model.username;
            contentView.password = model.password;
            contentView.delegate=self;
            alert.contentView = contentView;
            [alert show];
        }
        else{
            //登录失败弹窗
            [MBProgressHUD showError:msgStr];
        }
    } failure:^(NSError *error) {
        [MBProgressHUD hideHUDForView:self.view];
        NSString* errorStr = @"网络加载失败！";
        [MBProgressHUD showError:errorStr];
        NSLog(@"%@----------error",error);

        
    }];

}


-(void)getTimeToValue:(NSString *)theTimeStr
{
    NSLog(@"文本框里的值是：%@",theTimeStr);
    NSString* Code = [theTimeStr stringByReplacingOccurrencesOfString:@" " withString:@""];
    if (theTimeStr.length<=0) {
        [MBProgressHUD showError:@"请输入验证码!"];
        return;
    }
    LoginModel* model=[LoginModel new];
    model.username=[_accountVal.text stringByReplacingOccurrencesOfString:@" " withString:@""];
    NSString *urlBindStr = [NSString stringWithFormat:@"%@/App/BindMobilePhone",PathStr];
    NSString *token = [NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"Token1"]];
    NSString *identifierForVendor = [[UIDevice currentDevice].identifierForVendor UUIDString];
    NSDictionary* dicAlertBindParam =@{
                                       @"Name":model.username,
                                       @"Type":@"100030201213000020",
                                       @"IMEI":identifierForVendor,
                                       @"Token":token,
                                       @"Code":Code
                                       };
//    NSLog(@"paramBind----%@",dicAlertBindParam);
//    NSLog(@"urlBindStr--%@",urlBindStr);
//    [HttpsHelper postWithUrlString:urlBindStr parameters:dicAlertBindParam success:^(NSDictionary *data) {
//        dispatch_sync(dispatch_get_main_queue(),^{
//            NSLog(@"backBindData-----%@",data);
//            NSLog(@"paramBind----%@",dicAlertBindParam);
//            NSString *statusBind = [NSString stringWithFormat:@"%@",data[@"status"]];
//            NSString *msgBind = [NSString stringWithFormat:@"%@",data[@"msg"]];
//            if([statusBind isEqualToString:@"200"]){
//             e   [MBProgressHUD showSuccess:msgBind];
//                [alert hide];
//            }else{
//                [MBProgressHUD showError:msgBind];
//            }
//        });
//    } failure:^(NSError *error) {
//        NSString* errorAlertStr = @"网络加载失败！";
//        [MBProgressHUD showError:errorAlertStr];
//    }];
//
        [AFHTTPSessionManager POST:urlBindStr parameters:dicAlertBindParam completionHandle:^(id model, NSError *error) {
                NSLog(@"%@-------modelBack",model);
                if (error&&error!=nil) {
                    NSLog(@"error----------%@",error.domain);
                    [MBProgressHUD showError:error.domain];
                    return ;
                }
                NSString *statusBind = [NSString stringWithFormat:@"%@",model[@"status"]];
                NSString *msgBind = [NSString stringWithFormat:@"%@",model[@"msg"]];
                if([statusBind isEqualToString:@"200"]){
                    [MBProgressHUD showSuccess:msgBind];
                    [alert hide];
                }else{
                    [MBProgressHUD showError:msgBind];
                }
               
            }];
}


- (void) keyboardWillShow1:(NSNotification *)notify {
    CGFloat kbHeight = [[notify.userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size.height;
    NSLog(@"键盘出来了");
    [UIView animateWithDuration:0.3 animations:^{
        alert.frame = CGRectMake(0, 0, ScreenWidth, ScreenHeight-kbHeight);
        alert.contentView.center=alert.center;
    }];
}


- (void) keyboardWillHidden2:(NSNotification *)notify {
    [UIView animateWithDuration:0.3 animations:^{
        alert.frame = CGRectMake(0, 0, ScreenWidth, ScreenHeight);
        alert.contentView.center=alert.center;
    }];
}


-(void)loginPath{
    LoginModel* model=[LoginModel new];
    model.username=_accountVal.text;
    model.password=_passwordVal.text;
    //字典形式获取账号密码
    NSDictionary* dic=@{@"username":model.username,@"password":[model.password md5Str]};
    //    NSDictionary* dic=@{@"username":@"adminy",@"password":[@"123465" md5Str]};
//    NSLog(@"%@------md5Str",[model.password md5Str]);
//    NSLog(@"%@------md5StrXor",[model.password md5StrXor]);
    
    //连接地址
    NSString* urlStr=[NSString stringWithFormat:@"%@/Auth/Post",PathStr];
    
    //调用httpHelper需要配置info 的App Transport Security Settings
    //    [AFHTTPSessionManager GET:urlStr parameters:dic completionHandle:^(id model, NSError *error) {
    //        NSLog(@"%@--------model",model);
    //    }];
    //    [AFHTTPSessionManager POST:urlStr parameters:dic completionHandle:^(id model, NSError *error) {
    //        NSLog(@"%@--------model",model);
    //    }];
    
    //加载中样式
    [MBProgressHUD showMessage:@"登录中..." toView:self.view];
    //请求方法
    [HttpsHelper postWithUrlString:urlStr parameters:dic success:^(NSDictionary *data) {
        
        //获取当前线程数
//        NSLog(@"%@---------success",[NSThread currentThread]);
        
        //数据处理需要返回主线程：1 ，子线程：2，3...
        dispatch_sync(dispatch_get_main_queue(), ^{
            //隐藏加载中样式(立即隐藏)
            [MBProgressHUD hideHUDForView:self.view];
            //查看当前线程
//            NSLog(@"%@---------success",[NSThread currentThread]);
            //data返回数据
            NSLog(@"%@---------success",data);
            //字典获取值转换成字符串
            NSString* statusStr=[NSString stringWithFormat:@"%@",data[@"status"]];
            NSString* msgStr=[NSString stringWithFormat:@"%@",data[@"msg"]];
            //登录成功
            if([statusStr isEqualToString:@"200"]){
                
//                NSString* tokenStr=[NSString stringWithFormat:@"%@",data[@"Token"]];
//                //将获取数据保存在本地，其他界面可使用
//                [[NSUserDefaults standardUserDefaults] setObject:tokenStr forKey:@"Token"];
                [[NSUserDefaults standardUserDefaults] setObject:_accountVal.text forKey:@"username"];
                
                //记住密码选中时候
                if (_rememberPassworkBtn.selected) {
                    [[NSUserDefaults standardUserDefaults] setBool:_rememberPassworkBtn.selected forKey:@"IsRememberPassword"];
                    [[NSUserDefaults standardUserDefaults] setObject:_passwordVal.text forKey:@"password"];
                }else{//记住密码未选中时候
                    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"IsRememberPassword"];
                    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"password"];
                }
                
                //显示成功弹窗
                [MBProgressHUD showSuccess:msgStr];
                
                //由下往上样式：登录界面弹转到主界面(适用viewController)
                //                 MainNewViewController* mainNew=[self.storyboard instantiateViewControllerWithIdentifier:@"MainNewViewController"];
                
                MainNewNavigationController* mainNew=[self.storyboard instantiateViewControllerWithIdentifier:@"MainNNVC"];
                
                
                //由下往上样式：界面跳转（适用TabBar）
                //BottomTabBarController* tabbar=[self.storyboard //instantiateViewControllerWithIdentifier:@"BottomTabBar"];
                [self presentViewController:mainNew animated:YES completion:nil];
                
                //获取手机设备唯一标示：方法一 引用了adSupport Framwork
                //                NSString *identifierForAdvertising = [[[ASIdentifierManager sharedManager] advertisingIdentifier] UUIDString];
                //                NSLog(@"identifierForAdvertising == %@",identifierForAdvertising);
                //获取手机设备唯一标示：方法二 不需要引用
                //                NSString *identifierForVendor = [[UIDevice currentDevice].identifierForVendor UUIDString];
                //                NSLog(@"identifierForVendor == %@",identifierForVendor);
                
                
                
            }
            else{
                //登录失败弹窗
                [MBProgressHUD showError:msgStr];
            }
        });
    } failure:^(NSError *error) {
        NSString* errorStr = @"网络加载失败！";
        [MBProgressHUD showError:errorStr];
        NSLog(@"%@----------error",error);
    }];
    
    //获取账号密码
    //    NSString* str=[NSString stringWithFormat:@"accountVal=%@,passwordVal=%@",_accountVal.text,_passwordVal.text];
    //    [MBProgressHUD showSuccess:str];
    //    sleep(2);
}

@end
