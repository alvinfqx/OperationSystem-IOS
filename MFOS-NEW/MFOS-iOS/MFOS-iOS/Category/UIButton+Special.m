//
//  UIButton+Special.m
//  BaseObject
//
//  Created by Eli on 16/6/16.
//  Copyright © 2016年 Eli. All rights reserved.
//

#import "UIButton+Special.h"

@implementation UIButton (Special)
+(void)addborder:(UIButton*)btn
{
    [btn.layer setBorderColor:[UIColor colorWithRed:250/255.0 green:182/255.0 blue:85/255.0 alpha:1].CGColor];
    [btn.layer setBorderWidth:1];
    [btn.layer setMasksToBounds:YES];
    btn.layer.cornerRadius=5;
}

+(void)addCornerRadius:(UIButton*)btn
{
    btn.layer.cornerRadius=5;
    
}

@end
