//
//  MainModel.h
//  MFOS-iOS
//
//  Created by Alvin.Feng on 2018/1/2.
//  Copyright © 2018年 Alvin.Feng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MainModel : NSObject
@property (nonatomic,strong)NSMutableArray* imageArr;
+(NSMutableArray*)getModelImageArr;
@end
