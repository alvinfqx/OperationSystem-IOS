//
//  CustomMessageView.m
//  AlterMessageDemo
//
//  Created by dev on 2017/4/20.
//  Copyright © 2017年 nys. All rights reserved.
//

#import "CustomMessageView.h"
#import "FDAlertView.h"
#import "UIColor+ChangeColor.h"

#define SELFHEIGHT    7




@implementation CustomMessageView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self initView];
    }
    return self;
}


-(void)initView
{
    
    self.clipsToBounds=YES;
    self.layer.cornerRadius=6;
    self.backgroundColor=[UIColor HexString:@"ffffff"];
    
    self.titleLab=[[UILabel alloc]initWithFrame:CGRectMake(0, 5+SELFHEIGHT, self.frame.size.width, 20)];
    
    
//    NSLog(@"frame===%@",NSStringFromCGRect(self.frame));
    
//    NSLog(@"self.titileLab.frame===%@",NSStringFromCGRect(self.titleLab.frame));
    
    
    
    self.titleLab.text=@"绑定设备";
    self.titleLab.textColor=[UIColor HexString:@"262626"];
    self.titleLab.font=[UIFont systemFontOfSize:14];
    self.titleLab.textAlignment=NSTextAlignmentCenter;
    [self addSubview:self.titleLab];
    
    
    UILabel * lineLab=[[UILabel alloc]initWithFrame:CGRectMake(0, 30+SELFHEIGHT, self.frame.size.width, 1)];
    lineLab.backgroundColor=[UIColor HexString:@"eeeeee"];
    [self addSubview:lineLab];
    
    
//    self.contentLab=[[UILabel alloc]initWithFrame:CGRectMake(15, 35+SELFHEIGHT, self.frame.size.width-25, 40)];
//    self.contentLab.textColor=[UIColor HexString:@"666666"];
//    self.contentLab.font=[UIFont systemFontOfSize:12];
//    self.contentLab.textAlignment=NSTextAlignmentLeft;
//    self.contentLab.numberOfLines=0;
//    [self addSubview:self.contentLab];
    
    
    self.messageField=[[CustomBorderField alloc]initWithFrame:CGRectMake(15, 65+SELFHEIGHT, self.frame.size.width-105, 35)];
    self.messageField.borderStyle=UITextBorderStyleNone;
    self.messageField.layer.borderWidth=0.5;
    self.messageField.layer.borderColor=[UIColor HexString:@"eeeeee"].CGColor;
    self.messageField.placeholder=@"请输入短信验证码";
    self.messageField.font=[UIFont systemFontOfSize:13];
    self.messageField.textColor=[UIColor HexString:@"666666"];
    self.messageField.delegate=self;
    [self addSubview:self.messageField];
    
    self.authCodeBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    self.authCodeBtn.frame=CGRectMake(14.5+self.frame.size.width-105, 65+SELFHEIGHT, 90, 35);
    [self.authCodeBtn setTitle:@"获取验证码" forState:normal];
    [self.authCodeBtn setTitleColor:[UIColor colorWithRed:62/255.0 green:162/255.0 blue:238/255.0 alpha:1.0] forState:normal];
    [self.authCodeBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
    [self.authCodeBtn setBackgroundImage:[UIImage imageNamed:@"one"] forState:normal];
    [self.authCodeBtn setBackgroundImage:[UIImage imageNamed:@"two"] forState:UIControlStateSelected];
    self.authCodeBtn.titleLabel.font=[UIFont systemFontOfSize:12];
    
    [self.authCodeBtn addTarget:self action:@selector(getTheCodeFromSER:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.authCodeBtn];

    
    UILabel * line1Lab=[[UILabel alloc]initWithFrame:CGRectMake(0, 120+SELFHEIGHT+3, self.frame.size.width, 1)];
    line1Lab.backgroundColor=[UIColor HexString:@"eeeeee"];
    [self addSubview:line1Lab];
    
    
    self.cancelBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    self.cancelBtn.frame=CGRectMake(0, 130, (self.frame.size.width-1)/2.0, 40);
    [self.cancelBtn setTitle:@"取消" forState:normal];
    self.cancelBtn.backgroundColor=[UIColor clearColor];
    [self.cancelBtn setTitleColor:[UIColor colorWithRed:62/255.0 green:162/255.0 blue:238/255.0 alpha:1.0] forState:normal];
    self.cancelBtn.titleLabel.font=[UIFont systemFontOfSize:13];
    [self.cancelBtn addTarget:self action:@selector(cancelBtnEvent) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.cancelBtn];
    
    
    UILabel * line2Lab=[[UILabel alloc]initWithFrame:CGRectMake((self.frame.size.width-1)/2.0, 120+SELFHEIGHT+3.5, 1, 40)];
    line2Lab.backgroundColor=[UIColor HexString:@"eeeeee"];
    [self addSubview:line2Lab];
    
    
    self.submitBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    self.submitBtn.frame=CGRectMake((self.frame.size.width-1)/2.0+1, 130, (self.frame.size.width-1)/2.0, 40);
    [self.submitBtn setTitle:@"绑定" forState:normal];
    self.submitBtn.backgroundColor=[UIColor clearColor];
    [self.submitBtn setTitleColor:[UIColor colorWithRed:62/255.0 green:162/255.0 blue:238/255.0 alpha:1.0] forState:normal];
    self.submitBtn.titleLabel.font=[UIFont systemFontOfSize:13];
    [self.submitBtn addTarget:self action:@selector(submitBtnEvent) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.submitBtn];
    
    
    
}



#pragma mark- 取消事件
-(void)cancelBtnEvent
{
    FDAlertView *alert = (FDAlertView *)self.superview;
    [alert hide];
}
#pragma mark-确认事件
-(void)submitBtnEvent
{
    
    if ( [self.delegate respondsToSelector:@selector(getTimeToValue:)])
    {
        [self.delegate getTimeToValue:self.messageField.text];
        
    }
    
    //FDAlertView *alert = (FDAlertView *)self.superview;
    //[alert hide];
    
}
#pragma mark-获取验证码
-(void)getTheCodeFromSER:(UIButton*)btn
{
    btn.selected=YES;
    [self openCountdown];
    
    NSDictionary* dicAlert = @{@"Name":_userName,@"Password":[_password md5Str]};
    NSString* urlStrAlert=[NSString stringWithFormat:@"%@/App/GetSmsCode",PathStr];
    
    NSLog(@"code————————%@",dicAlert);
    //请求方式
    [HttpsHelper getWithUrlString:urlStrAlert parameters:dicAlert success:^(NSDictionary *data) {
        NSLog(@"%@",data);
        NSString* statusAlertStr=[NSString stringWithFormat:@"%@",data[@"status"]];
        NSString* msgAlertStr=[NSString stringWithFormat:@"%@",data[@"msg"]];
        if([statusAlertStr isEqualToString:@"200"]){
            [MBProgressHUD showSuccess:msgAlertStr];
            NSString* tokenAlertStr=[NSString stringWithFormat:@"%@",data[@"Token"]];
            //将获取数据保存在本地，其他界面可使用
            [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"Token1"];
            [[NSUserDefaults standardUserDefaults] setObject:tokenAlertStr forKey:@"Token1"];
            NSLog(@"%@------TOKEN",tokenAlertStr);
        }else{
            [MBProgressHUD showError:msgAlertStr];
        }
    } failure:^(NSError *error) {
        NSString* errorAlertStr = @"网络加载失败！";
        [MBProgressHUD showError:errorAlertStr];
        
    }];
}

-(void)openCountdown{
    
    __block NSInteger time = 59; //倒计时时间
    
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    
    dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
    
    dispatch_source_set_event_handler(_timer, ^{
        
        if(time <= 0){ //倒计时结束，关闭
            
            dispatch_source_cancel(_timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                
                //设置按钮的样式
                [self.authCodeBtn setTitle:@"重新发送" forState:UIControlStateNormal];
                //[self.authCodeBtn setTitleColor:[UIColor HexString:@"FB8557"] forState:UIControlStateNormal];
                self.authCodeBtn.userInteractionEnabled = YES;
            });
            
        }else{
            
            int seconds = time % 60;
            dispatch_async(dispatch_get_main_queue(), ^{
                
                //设置按钮显示读秒效果
                [self.authCodeBtn setTitle:[NSString stringWithFormat:@"%.2ds后重试", seconds] forState:UIControlStateNormal];
                //[self.authCodeBtn setTitleColor:[UIColor HexString:@"979797"] forState:UIControlStateNormal];
                self.authCodeBtn.userInteractionEnabled = NO;
            });
            time--;
        }
    });
    dispatch_resume(_timer);
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    
    [textField resignFirstResponder];
    
    return YES;
}


-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
