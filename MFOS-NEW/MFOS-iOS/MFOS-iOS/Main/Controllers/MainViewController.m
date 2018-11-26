//
//  MainViewController.m
//  MFOS-iOS
//
//  Created by Alvin.Feng on 2017/12/20.
//  Copyright © 2017年 Alvin.Feng. All rights reserved.
//

#import "MainViewController.h"

@interface MainViewController ()
@property (weak, nonatomic) IBOutlet UILabel *tokenValue;
@property (weak, nonatomic) IBOutlet UILabel *nameValue;
@property (weak, nonatomic) IBOutlet UIView *waitTask;
@property (weak, nonatomic) IBOutlet UIView *currentScore;
@property (weak, nonatomic) IBOutlet UIView *currentTask;
@property (weak, nonatomic) IBOutlet UIView *information;

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   //获取本地存储的token和username(在Category文件夹的NSString+md5.m中封装了该获取方法，可全局调用)
    _tokenValue.text=[NSString tokenStringAndusername:YES];
    _nameValue.text = [NSString tokenStringAndusername:NO];
   //给该view前四个view设置圆滑的角
    _waitTask.layer.cornerRadius = 5.0f;
    _currentTask.layer.cornerRadius = 5.0f;
    _currentScore.layer.cornerRadius = 5.0f;
    _information.layer.cornerRadius = 5.0f;
    
    
}

//button方法返回上一个界面：此处为登录界面
//- (IBAction)back:(id)sender {
//    [self dismissViewControllerAnimated:YES completion:nil];
//}

//barButtonItem方法返回键
//- (IBAction)back:(id)sender {
//    [self dismissViewControllerAnimated:YES completion:nil];
//}

//代办事项
- (IBAction)waitTaskBtn:(id)sender {
    [MBProgressHUD showAlert:@"代办事项" andView:self.view];
}
- (IBAction)currentScore:(id)sender {
    [MBProgressHUD showAlert:@"当前分数" andView:self.view];
}
- (IBAction)currentTask:(id)sender {
    [MBProgressHUD showAlert:@"当前任务" andView:self.view];
}
- (IBAction)information:(id)sender {
    [MBProgressHUD showAlert:@"通知公告" andView:self.view];
}





@end
