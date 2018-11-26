//
//  BottomTabBarController.m
//  MFOS-iOS
//
//  Created by Alvin.Feng on 2017/12/21.
//  Copyright © 2017年 Alvin.Feng. All rights reserved.
//

#import "BottomTabBarController.h"

@interface BottomTabBarController ()

@end

@implementation BottomTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

/*
 1.系统调用
 2.当控制器接收到内存警告调用
 3.去除一些不必要的内存，去除耗时的内存
 */
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
