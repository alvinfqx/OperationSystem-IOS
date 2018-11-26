//
//  MainNewViewController.m
//  MFOS-iOS
//
//  Created by Alvin.Feng on 2017/12/26.
//  Copyright © 2017年 Alvin.Feng. All rights reserved.
//

#import "MainNewViewController.h"
#import "TopCollectionViewCell.h"
#import "BottomCollectionViewCell.h"
#import "UIColor+ChangeColor.h"
#import "LoginViewController.h"
#import "AppSettingViewController.h"
#import "MainModel.h"
#import "ImageNameColorM.h"

@interface MainNewViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>//“<UICollectionViewDelegate,UICollectionViewDataSource>配置此两类“
//主菜单的collectionView
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
//@property (nonatomic,strong)NSArray* imageTopArr;
//@property (nonatomic,strong)NSArray* imageBottomArr;
//@property (nonatomic,strong)NSArray* imgArray;
//@property (nonatomic,strong)NSArray* colorTopArr;
@property(nonatomic,strong)NSMutableArray* topMenuList;
@property(nonatomic,strong)NSMutableArray* buttomMenuList;
@property(nonatomic,strong)NSMutableArray* imageColorArr;
@end

@implementation MainNewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    _imageTopArr=@[@"待办事项",@"当前分数",@"当前任务",@"通知公告"];
//    _imageBottomArr=@[@"系统设置",@"用户管理",@"产品管理",@"销售管理",@"财务管理",@"报表系统",@"文件资料",@"知识库",@"固定资产"];
//    _imgArray = @[@"待办事项",@"当前分数",@"当前任务",@"通知公告",@"系统设置",@"用户管理",@"产品管理",@"财务管理",@"报表系统",@"文件资料",@"知识库",@"固定资产"];
//    _colorTopArr=@[[UIColor HexString:@"83b5f6"],[UIColor HexString:@"a0d367"],[UIColor HexString:@"f3cc55"],[UIColor HexString:@"cbd0d9"],[UIColor HexString:@"ffcc99"],[UIColor HexString:@"ff9999"],[UIColor HexString:@"6699ff"],[UIColor HexString:@"ffcccc"],[UIColor HexString:@"33cccc"],[UIColor HexString:@"99ffcc"],[UIColor HexString:@"cccc99"],[UIColor HexString:@"66cc99"],[UIColor HexString:@"cc9933"],[UIColor HexString:@"0099ff"],[UIColor HexString:@"33ccff"],[UIColor HexString:@"9999ff"]];
    [self setupRefresh];
//    [MBProgressHUD showMessage:@"加载中..." toView:self.view];
    //[MBProgressHUD hideHUDForView:self.view];
    _imageColorArr = [MainModel getModelImageArr];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    [self getMenuData];
}


//两组不同的cell
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 2;
}

//section==0为第一组，返回cell数
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (section==0) {
        //return 7;
        return _topMenuList.count;
        //return _imageColorArr.count;
    }else{//section==1为第er组，返回cell数
        return _buttomMenuList.count;
        //return 10;
    }
}

//返回的内容
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0) {//顶部的cell样式,自动循环逐个逐个创建cell
        static NSString* identifier = @"TopCell";//第一组cell的ID
        TopCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
        NSString* menuTopID = [NSString stringWithFormat:@"%@",[_topMenuList[indexPath.row] objectForKey:@"MenuID"]];
        
        //设定默认值
        BOOL isHasMenuID = NO;
        /*
         数据存储调用for循环
         循环所有本地数据MenuID
         字符串用length，数组用count
         */
        cell.bottomLabel.text = [NSString stringWithFormat:@"%@",[_topMenuList[indexPath.row] objectForKey:@"ID"]];
        cell.topLabel.text=(NSString*)[_topMenuList[indexPath.row] objectForKey:@"Name"];
        cell.contentView.layer.cornerRadius=5.0f;
        cell.backgroundColor=[UIColor clearColor];
        for (int i = 0; i < _imageColorArr.count; i++) {
            ImageNameColorM* model = _imageColorArr[i];
            //找到与返回数据MenuID相等索引i
            if ([model.MenuID isEqualToString:menuTopID]) {
                cell.imageView.image=[UIImage imageNamed:model.imageName];
                cell.contentView.backgroundColor = [UIColor HexString:model.hexColorStr];
                isHasMenuID = YES;
            }
            //else{}不可在此处判断无对应MenuID，它会一直循环，覆盖样式，无法实现功能
        }
        //如果找不到返回的数据MenuID与本地的MenuID相同时，默认图片
        if(isHasMenuID == NO){
            ImageNameColorM* model = _imageColorArr[indexPath.row];
            cell.imageView.image=[UIImage imageNamed:@"Monkeyfly"];
            cell.topLabel.text=(NSString*)[_topMenuList[indexPath.row] objectForKey:@"Name"];
            cell.bottomLabel.text = [NSString stringWithFormat:@"%@",[_topMenuList[indexPath.row] objectForKey:@"ID"]];
            cell.contentView.backgroundColor = [UIColor HexString:model.hexColorStr];
           NSLog(@"%@------color",model.hexColorStr);
        }
        
       //无返回数据的时候测试
//        if (indexPath.row==0) {//第一组的第一个cell
////            cell.imageView.image=[UIImage imageNamed:@"报表系统"];
////            cell.topLabel.text=@"123";
////            cell.bottomLabel.text =@"3";
//            ImageNameColorM* model = _imageColorArr[indexPath.row];
//            cell.imageView.image=[UIImage imageNamed:model.imageName];
//            cell.topLabel.text=model.imageName;
//            cell.bottomLabel.text =@"3";
//            cell.contentView.backgroundColor = [UIColor HexString:model.hexColorStr];
//        }else if (indexPath.row==1){//第一组的第二个cell
//            ImageNameColorM* model = _imageColorArr[1];
//            cell.imageView.image=[UIImage imageNamed:@"财务管理"];
//            cell.topLabel.text=@"456";
//            cell.bottomLabel.text =@"25";
//            cell.contentView.backgroundColor = [UIColor HexString:model.hexColorStr];
//        }
//        else{
//            ImageNameColorM* model = _imageColorArr[13];
//            cell.imageView.image = [UIImage imageNamed:model.imageName];
//            cell.topLabel.text = model.imageName;
//            cell.bottomLabel.text = @"56";
//            cell.contentView.backgroundColor = [UIColor HexString:model.hexColorStr];
//        }
//静态获取数组图片链接
//          cell.imageView.image=[UIImage imageNamed:_imageTopArr[indexPath.row]];
        
        
//动态加载图片链接
//        NSString* urlTopStr=[NSString stringWithFormat:@"%@%@",ImagePathStr,[_topMenuList[indexPath.row] objectForKey:@"IconURL"]];
//         [cell.imageView sd_setImageWithURL:[NSURL URLWithString:urlTopStr]];
        
//          cell.topLabel.text=(NSString*)[_topMenuList[indexPath.row] objectForKey:@"Name"];
//          cell.bottomLabel.text = [NSString stringWithFormat:@"%@",[_topMenuList[indexPath.row] objectForKey:@"ID"]];
//          cell.contentView.backgroundColor=_colorTopArr[indexPath.row];
//          cell.contentView.layer.cornerRadius=5.0f;
//          cell.backgroundColor=[UIColor clearColor];
        return cell;
        
        
    }else{//底部的Cell样式,自动循环逐个逐个创建cell
        static NSString* identifier = @"BottomCell";
        BottomCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
        //cell.bottomImageView.image = [UIImage imageNamed:_imageBottomArr[indexPath.row]];
        
        NSString* buttomMenuID = [NSString stringWithFormat:@"%@",[_buttomMenuList[indexPath.row] objectForKey:@"MenuID"]];
        BOOL isHasBottomMenuID = NO;
        cell.bottomLabelView.text = (NSString*)[_buttomMenuList[indexPath.row] objectForKey:@"Name"];
        
        for (int i = 0; i<_imageColorArr.count; i++) {
            ImageNameColorM* buttomModel = _imageColorArr[i];
            if([buttomModel.MenuID isEqualToString:buttomMenuID]){
                cell.bottomImageView.image = [UIImage imageNamed:buttomModel.imageName];
                isHasBottomMenuID = YES;
            }
        }
        if(isHasBottomMenuID == NO){
            cell.bottomImageView.image = [UIImage imageNamed:@"Monkeyfly"];
            cell.bottomLabelView.text = [NSString stringWithFormat:@"%@" ,[_buttomMenuList[indexPath.row] objectForKey:@"Name"]];
        }
        
      //无数据返回的时候测试
//        if (indexPath.row==0) {//第二组的第一个cell
//            ImageNameColorM* model = _imageColorArr[indexPath.row];
//            cell.bottomImageView.image=[UIImage imageNamed:model.imageName];
//            cell.bottomLabelView.text=model.imageName;
//
//        }
//        else{
//            ImageNameColorM* model = _imageColorArr[13];
//            cell.bottomImageView.image = [UIImage imageNamed:model.imageName];
//            cell.bottomLabelView.text = model.imageName;
//        }
        
        //动态加载图片链接
//            NSString* urlBottomStr = [NSString stringWithFormat:@"%@%@",ImagePathStr,[_buttomMenuList[indexPath.row] objectForKey:@"IconURL"]];
//            [cell.bottomImageView sd_setImageWithURL:[NSURL URLWithString:urlBottomStr]];
//            cell.bottomLabelView.text = (NSString*)[_buttomMenuList[indexPath.row] objectForKey:@"Name"];
        return cell;
    }
}

//控制第一组和第二组cell的长宽
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==0) {//ScreenWidth在PrefixHeader.pch文件配置了全局。获取屏幕宽
        return CGSizeMake(ScreenWidth/2-10.0f, (ScreenWidth/2-10.0f)*2/3);
    }else if (indexPath.section==1){
        return CGSizeMake(ScreenWidth/3-5.0f, ScreenWidth/3-5.0f);
    }else{
        return CGSizeMake(self.view.bounds.size.width/2-10.0f, self.view.bounds.size.width/2-10.0f);
    }
    
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    if (section == 0) {//上半部位的空白长宽
        return CGSizeMake(ScreenWidth, 10);
    }else{//中间部位的空白长宽
        return CGSizeMake(ScreenWidth, 20);
    }
}

//控制左右上下空隙的最小限制：设定全局的行间距，如果想要设定指定区内Cell的最小行距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    if (section==0) {
        return 5;
    }else{
        return 2;
    }
}

//设定全局的Cell间距，如果想要设定指定区内Cell的最小间距
//- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
//{
//    return 0;
//}

//重点牢记：collectionViewCell的点击事件---界面跳转(APP设置)
//-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
//{
//    if (indexPath.section==0) {
//
//    }else if (indexPath.section==1){
//        if (indexPath.row==0) {
//            AppSettingViewController* appSettingID=[self.storyboard instantiateViewControllerWithIdentifier:@"AppSettingID"];
//
//             //无顶部导航栏互相跳转/或有顶部导航栏跳转到无顶部导航栏：presentViewController
////            [self presentViewController:appSettingID animated:YES completion:nil];
//
//            //有顶部导航栏跳转到有顶部的导航栏用：navigationController
//            [self.navigationController pushViewController:appSettingID animated:YES];
//        }
//    }
//
//}

- (void)setupRefresh
{
    //不储存
    __unsafe_unretained UICollectionView *collection = self.collectionView;
    // 下拉刷新
    collection.mj_header= [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        // 模拟延迟加载数据，因此2秒后才调用（真实开发中，可以移除这段gcd代码）
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
//             [NSString getNoticeDataNow];
//            _page=1;
            [self getMenuData];
            
            // 结束刷新
            [collection.mj_header endRefreshing];
        });
    }];
    
    // 设置自动切换透明度(在导航栏下面自动隐藏)
    collection.mj_header.automaticallyChangeAlpha = YES;
    
    // 上拉刷新
//    collection.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
//        // 模拟延迟加载数据，因此2秒后才调用（真实开发中，可以移除这段gcd代码）
//        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
////            _page++;
////            _isLoadAudit=NO;
//            [self getMenuData];
//            // 结束刷新
//            [collection.mj_footer endRefreshing];
//        });
//    }];
}

//获取菜单数据
-(void) getMenuData{
    NSString* urlStrMenu=[NSString stringWithFormat:@"%@/App/GetAppMenu",PathStr];
    NSString *token = [NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"Token"]];
    NSDictionary* dicMenuParam =@{@"Token":token};
    [MBProgressHUD showLoadingMessage:@"加载中..." toView:self.view];
    [AFHTTPSessionManager GET:urlStrMenu parameters:dicMenuParam completionHandle:^(id model, NSError *error) {
        NSLog(@"%@-------modelBack",model);
        [MBProgressHUD hideHUDForView:self.view];
        if (error&&error!=nil) {
            NSLog(@"errorMenu----------%@",error.domain);
            [MBProgressHUD showError:error.domain];
            return ;
        }
        
        if(model&&model != nil){
            _topMenuList=[NSMutableArray arrayWithArray:[model objectForKey:@"TopMenuList"]];
            _buttomMenuList=[NSMutableArray arrayWithArray:[model objectForKey:@"ButtomMenuList"]];
            
            /*此方法不可用，应为在循环过程中_topMenuList长度也会跟着变化*/
//            for (int i =0; i<_topMenuList.count; i++) {
//                BOOL isVisible = [[_topMenuList[i] objectForKey:@"IsVisible"] boolValue];
//                if (isVisible==NO) {
//                    [_topMenuList removeObjectAtIndex:i];
//                }
//            }
            for(int i=0; (int)_topMenuList.count > i;){//从数组后面开始删
                BOOL isVisbleTop = [[_topMenuList[(int)_topMenuList.count-i-1] objectForKey:@"IsVisible"] boolValue];
                if(!isVisbleTop){
                    [_topMenuList removeObjectAtIndex:((int)_topMenuList.count-i-1)];
                }
                else{
                    i++;//不删除的加起来
                }
            }
//            for (int i = 0; i<_buttomMenuList.count; i++) {
//                BOOL isBottomVisible = [[_buttomMenuList[i] objectForKey:@"IsVisible"] boolValue];
//                if(isBottomVisible==NO){
//                    [_buttomMenuList removeObjectAtIndex:i];
//                }
//            }
            for(int i=0; (int)_buttomMenuList.count > i;){//从数组后面开始删
                BOOL isVisbleBot = [[_buttomMenuList[(int)_buttomMenuList.count-i-1] objectForKey:@"IsVisible"] boolValue];
                if(!isVisbleBot){
                    [_buttomMenuList removeObjectAtIndex:((int)_buttomMenuList.count-i-1)];
                }
                else{
                    i++;//不删除的加起来,就循环
                }
            }
            
//            if ([_topMenuList isKindOfClass:[NSNull class]]) {//判断可变数组是否为空的方法1
//                [MBProgressHUD showError:@"无数据返回"];
////                return;
//            }
//            if (_buttomMenuList.count<=0) {//判断数组是否为空方法2
//                [MBProgressHUD showError:@"无数据返回"];
//                return;
//            }

            //判断token过期时返回登录界面
            NSString *statusMenuStr = [NSString stringWithFormat:@"%@",model[@"status"]];
            if(![statusMenuStr isEqualToString:@"<null>"]&&statusMenuStr.length>0){
                NSString *statusMenuStr = [NSString stringWithFormat:@"%@",model[@"status"]];
                NSString *msgMenuStr = [NSString stringWithFormat:@"%@",model[@"msg"]];
                if([statusMenuStr isEqualToString:@"403"]){
                    [MBProgressHUD showError:msgMenuStr];
                    LoginViewController* loginViewID=[self.storyboard instantiateViewControllerWithIdentifier:@"LoginViewID"];
                    [self presentViewController:loginViewID animated:YES completion:nil];
                }
            }
            
            [self.collectionView reloadData];
            
            }
        else{
                [MBProgressHUD showError:@"无数据返回"];
            }

    } ];
}

//主界面右上角的“我的设置”按钮
- (IBAction)mySettingBtn:(id)sender {
    AppSettingViewController* mySettingID = [self.storyboard instantiateViewControllerWithIdentifier:@"AppSettingID"];
    [self.navigationController pushViewController:mySettingID animated:YES];
}


@end
