//
//  AppSettingViewController.m
//  MFOS-iOS
//
//  Created by Alvin.Feng on 2017/12/28.
//  Copyright © 2017年 Alvin.Feng. All rights reserved.
//

#import "AppSettingViewController.h"
#import "LoginViewController.h"
#import "MySettingTableViewCell.h"
#import "MyMenuViewController.h"

@interface AppSettingViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *appSetTabelView;

@property (weak, nonatomic) IBOutlet UIButton *loginOutCss;

@end

@implementation AppSettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _loginOutCss.layer.cornerRadius = 10.0f;
    
    //改变Navigation上返回键显示的中文名字
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStyleDone target:nil action:nil];
}

- (IBAction)loginOut:(id)sender {
    LoginViewController* LoginID = [self.storyboard instantiateViewControllerWithIdentifier:@"LoginViewID"];
    [self presentViewController:LoginID animated:YES completion:nil];
   
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView）{
    return 2;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section==0) {
        return 1;
    }else{
        return 8;
    }
}

//修改cell的尺寸
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==0) {
        return 100;
    }else{
        return 40; 
    }
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {

    if (indexPath.section==0) {
        static NSString* identifier = @"MyMessageID";
        MySettingTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (!cell) {
            cell = [[MySettingTableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identifier];
        }
        return cell;
    }else{
        static NSString* identifier = @"MyMenuID";
        MyMenuTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (!cell) {
            cell = [[MyMenuTableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identifier];
        }
        switch (indexPath.row) {
            case 0:
                cell.myMenu.text = @"我的菜单";
                break;
            case 1:
                cell.myMenu.text = @"收藏";
                break;
            case 2:
                cell.myMenu.text = @"相册";
                break;
            case 3:
                cell.myMenu.text = @"卡包";
                break;
            case 4:
                cell.myMenu.text = @"表情";
                break;
            case 5:
                cell.myMenu.text = @"购物";
                break;
            case 6:
                cell.myMenu.text = @"游戏";
                break;
            case 7:
                cell.myMenu.text = @"搜一搜";
                break;
            default:
                cell.myMenu.text = @"Monkeyfly";
                break;
        }
        return cell;
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if(indexPath.section == 1){
        
        if(indexPath.row == 0){
            MyMenuViewController* myMenuViewID = [self.storyboard instantiateViewControllerWithIdentifier:@"MyMenuViewID"];
            [self.navigationController pushViewController:myMenuViewID animated:YES];
        }
    }
    
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section==0) {
        return 10;
    }else{
        return 15;
    }
}

-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView* view = [[UIView alloc]init];
    view.backgroundColor = [UIColor colorWithRed:239.0/255.0f green:239.0/255.0f blue:239.0/255.0f alpha:1.0];
    return view;
}


@end
