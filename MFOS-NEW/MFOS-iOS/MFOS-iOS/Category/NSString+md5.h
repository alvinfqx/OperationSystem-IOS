//
//  NSString+md5.h
//  酷跑
//
//  Created by tarena36 on 15/12/4.
//  Copyright © 2015年 tarena36. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (md5)

-(NSString*)md5Str;
-(NSString*)md5StrXor;

+(NSString*)tokenStringAndusername:(BOOL)isToken;

@end



