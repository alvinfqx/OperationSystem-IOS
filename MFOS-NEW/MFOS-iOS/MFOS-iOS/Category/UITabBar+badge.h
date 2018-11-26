//
//  UITabBar+badge.h
//  BaseObject
//
//  Created by Eli on 16/10/13.
//  Copyright © 2016年 Eli. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITabBar (badge)

- (void)showBadgeOnItemIndex:(int)index;   //显示小红点
- (void)hideBadgeOnItemIndex:(int)index; //隐藏小红点

@end
