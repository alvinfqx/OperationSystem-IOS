//
//  UIView+AddLoginLayer.m
//  MFOS-iOS
//
//  Created by Alvin.Feng on 2017/12/20.
//  Copyright © 2017年 Alvin.Feng. All rights reserved.
//

#import "UIView+AddLoginLayer.h"

@implementation UIView (AddLoginLayer)
+(void) AddLayer:(CALayer *)layer{
    layer.borderColor = [UIColor whiteColor].CGColor;
    layer.borderWidth = 1.0f;
    layer.cornerRadius = 10.0f;
}
-(void) AddLayerOther{
    self.layer.borderColor= [UIColor whiteColor].CGColor;
    self.layer.borderWidth = 1.0f;
    self.layer.cornerRadius = 10.0f;
}
@end
