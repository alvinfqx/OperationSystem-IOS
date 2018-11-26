//
//  ImageModel.m
//  MFOS-iOS
//
//  Created by Alvin.Feng on 2018/1/2.
//  Copyright © 2018年 Alvin.Feng. All rights reserved.
//

#import "MainModel.h"
#import "ImageNameColorM.h"

@implementation MainModel

//imageArr属性的get方法。imageArr属性还有一个set方法：-(void)setImageArr:(NSMutableArray *)imageArr{return str;};
-(NSMutableArray *)imageArr{
    if (!_imageArr) { //懒加载
        _imageArr = [NSMutableArray array];
        ImageNameColorM* AModel = [ImageNameColorM new];
        AModel.imageName = @"待办事项";
        AModel.hexColorStr = @"83b5f6";
        AModel.MenuID = @"10003007171200005A";
        [_imageArr addObject:AModel];
        
        ImageNameColorM* BModel = [ImageNameColorM new];
        BModel.imageName = @"当前分数";
        BModel.hexColorStr = @"a0d367";
        BModel.MenuID = @"100030071801000063";
        [_imageArr addObject:BModel];
        
        ImageNameColorM* CModel = [ImageNameColorM new];
        CModel.imageName = @"当前分数";
        CModel.hexColorStr = @"f3cc55";
        CModel.MenuID = @"100030071213000005";
        [_imageArr addObject:CModel];
        
        ImageNameColorM* DModel = [ImageNameColorM new];
        DModel.imageName = @"通知公告";
        DModel.hexColorStr = @"cbd0d9";
        DModel.MenuID = @"100030071213000006";
        [_imageArr addObject:DModel];
        
        ImageNameColorM* EModel = [ImageNameColorM new];
        EModel.imageName = @"用户管理";
        EModel.hexColorStr = @"ffcc99";
        EModel.MenuID = @"100030071213000008";
        [_imageArr addObject:EModel];
        
        ImageNameColorM* FModel = [ImageNameColorM new];
        FModel.imageName = @"产品管理";
        FModel.hexColorStr = @"ff9999";
        FModel.MenuID = @"100030071213000003";
        [_imageArr addObject:FModel];
        
        ImageNameColorM* GModel = [ImageNameColorM new];
        GModel.imageName = @"财务管理";
        GModel.hexColorStr = @"6699ff";
        GModel.MenuID = @"100030071213000002";
        [_imageArr addObject:GModel];
        
        ImageNameColorM* HModel = [ImageNameColorM new];
        HModel.imageName = @"报表系统";
        HModel.hexColorStr = @"ffcccc";
        HModel.MenuID = @"100030071213000004";
        [_imageArr addObject:HModel];
        
        ImageNameColorM* IModel = [ImageNameColorM new];
        IModel.imageName = @"文件资料";
        IModel.hexColorStr = @"33cccc";
        IModel.MenuID = @"100030071213000009";
        [_imageArr addObject:IModel];
        
        ImageNameColorM* JModel = [ImageNameColorM new];
        JModel.imageName = @"知识库";
        JModel.hexColorStr = @"4cafe9";
        JModel.MenuID = @"";
        [_imageArr addObject:JModel];
        
        ImageNameColorM* KModel = [ImageNameColorM new];
        KModel.imageName = @"固定资产";
        KModel.hexColorStr = @"cccc99";
        KModel.MenuID = @"100030071712000046";
        [_imageArr addObject:KModel];
        
        ImageNameColorM* LModel = [ImageNameColorM new];
        LModel.imageName = @"Monkeyfly";
        LModel.hexColorStr = @"66cc99";
        LModel.MenuID = @"100030071712000045";
        [_imageArr addObject:LModel];
        
        ImageNameColorM* MModel = [ImageNameColorM new];
        MModel.imageName = @"Monkeyfly";
        MModel.hexColorStr = @"cc9933";
        MModel.MenuID = @"";
        [_imageArr addObject:MModel];
        
        ImageNameColorM* NModel = [ImageNameColorM new];
        NModel.imageName = @"Monkeyfly";
        NModel.hexColorStr = @"0099ff";
        NModel.MenuID = @"";
        [_imageArr addObject:NModel];
        
        ImageNameColorM* OModel = [ImageNameColorM new];
        OModel.imageName = @"Monkeyfly";
        OModel.hexColorStr = @"33ccff";
        OModel.MenuID = @"100030071712000047";
        [_imageArr addObject:OModel];
        
        ImageNameColorM* PModel = [ImageNameColorM new];
        PModel.imageName = @"Monkeyfly";
        PModel.hexColorStr = @"9999ff";
        PModel.MenuID = @"";
        [_imageArr addObject:PModel];
        
    }
    return _imageArr;
}

+(NSMutableArray*)getModelImageArr{
    MainModel* model = [MainModel new];//企业开发中，不建议使用该方法：类方法中间接调用对象方法
    return [model.imageArr mutableCopy];
}

@end
