//
//  CustomBorderField.m
//  AlterMessageDemo
//
//  Created by dev on 2017/4/20.
//  Copyright © 2017年 nys. All rights reserved.
//

#import "CustomBorderField.h"

@implementation CustomBorderField


-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {

    }
    return self;
}

- (CGRect)textRectForBounds:(CGRect)bounds
{
    CGRect iconRect = [super textRectForBounds:bounds];
    iconRect.origin.x += 10;
    return iconRect;
}
- (CGRect)editingRectForBounds:(CGRect)bounds
{
    CGRect iconRect = [super editingRectForBounds:bounds];
    iconRect.origin.x += 10;
    return iconRect;
}


@end
