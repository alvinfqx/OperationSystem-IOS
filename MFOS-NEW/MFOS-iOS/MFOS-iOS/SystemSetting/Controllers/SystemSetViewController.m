//
//  SystemSetViewController.m
//  MFOS-iOS
//
//  Created by Alvin.Feng on 2017/12/22.
//  Copyright © 2017年 Alvin.Feng. All rights reserved.
//

#import "SystemSetViewController.h"

@interface SystemSetViewController ()

@end

@implementation SystemSetViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)loginOut:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}


@end
