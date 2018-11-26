//
//  MyMenuViewController.m
//  MFOS-iOS
//
//  Created by Alvin.Feng on 2018/1/3.
//  Copyright © 2018年 Alvin.Feng. All rights reserved.
//

#import "MyMenuViewController.h"
#import "MyMenuDetailTableViewCell.h"

@interface MyMenuViewController ()<UITabBarDelegate,UITableViewDataSource>
@property (nonatomic,strong) NSMutableArray* topMenuArray;
@property (nonatomic,strong) NSMutableArray* bottomMenuArray;
@property (nonatomic,strong) NSMutableArray* hiddenMenuArray;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic,strong) NSMutableArray* touchPoints;
@property (nonatomic,strong) NSMutableArray* dataArray;
@property (nonatomic,strong) NSMutableArray* topMenuShowArray;
@property (nonatomic,strong) NSMutableArray* bottomMenuShowArray;
//@property (nonatomic,strong) NSMutableArray* _topNewMenuArray;
@end

@implementation MyMenuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _topMenuArray=[NSMutableArray array];
    _bottomMenuArray=[NSMutableArray array];
    _hiddenMenuArray=[NSMutableArray array];
    _topMenuShowArray=[NSMutableArray array];
    _bottomMenuShowArray=[NSMutableArray array];
    [self setLongPressDrag];
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    [self getMenuDetailData];
}

//
////区域块
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}
//
////设置cell
- ( UITableViewCell *)tableView:( UITableView *)tableView cellForRowAtIndexPath:( NSIndexPath *)indexPath {
    static NSString* identifier  = @"MyMenuCellID";
   
    MyMenuDetailTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[MyMenuDetailTableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identifier];
    }
    if(indexPath.section==0){
        
        cell.menuDetailName.text = [NSString stringWithFormat:@"%@",[_topMenuShowArray[indexPath.row] objectForKey:@"Name"]];
        //设定switch的按钮Tag
//        cell.switchDetailBtn.tag=1000+indexPath.row;
//        cell.switchDetailMsg.tag=1500+indexPath.row;
    }else if(indexPath.section ==1){
        cell.menuDetailName.text = [NSString stringWithFormat:@"%@",[_bottomMenuShowArray[indexPath.row] objectForKey:@"Name"]];
        
    }
    else{
         cell.menuDetailName.text = [NSString stringWithFormat:@"%@",[_hiddenMenuArray[indexPath.row] objectForKey:@"Name"]];
    }
    
    return cell;
}
//
////设置区域有多少个
- (NSInteger)tableView:( UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if(section == 0){
//        NSLog(@"%ld-----------%@",_topMenuArray.count,_topMenuArray);
//        NSLog(@"%ld-----------%@ show",_topMenuShowArray.count,_topMenuShowArray);
        return _topMenuShowArray.count;
    }else if(section == 1){
        return _bottomMenuShowArray.count;
    }else {
        return _hiddenMenuArray.count;
    }
}

-(CGFloat)tableView:(UITableView *) tableView heightForHeaderInSection:(NSInteger)section{
    if(section == 0 ){        
        return 40;
    }else{
        return 40;
    }
}

//设置顶部样式
-(UIView *)tableView:(UITableView *) tableView viewForHeaderInSection:(NSInteger)section{
    UIView* view = [[UIView alloc]init];
    view.backgroundColor = [UIColor colorWithRed:239.0/255.0f green:239.0/255.0f blue:239.0/255.0f alpha:1.0f ];
    //创建label
    UILabel* label = [[UILabel alloc]init];
    //使label和当前的view一样大
    label.frame = CGRectMake(5.0f, 0, ScreenWidth-10.0f, 40);
    if (section == 0) {
        label.text= @"顶部菜单";
    }else if(section == 1){
        label.text = @"底部菜单";
    }else{
        label.text = @"隐藏菜单";
    }
    label.font = [UIFont systemFontOfSize:15.0f];
    label.textColor = [UIColor grayColor];
    //将label add进view里面
    [view addSubview:label];
    [view bringSubviewToFront:label];
    return view;
}


//用Tag设定switch按钮
//- (IBAction)switchButton:(UISwitch*)sender {
//    if (sender.tag>=1000&&sender.tag<2000) {
//        if (sender.on) {
//            UILabel* label = (UILabel*)[self.view viewWithTag:(1500+sender.tag-1000)];
//            label.text=@"显示";
//        }else{
//            UILabel* label = (UILabel*)[self.view viewWithTag:(1500+sender.tag-1000)];
//            label.text=@"隐藏";
//        }
//    }else{
//        if (sender.on) {
//            UILabel* label = (UILabel*)[self.view viewWithTag:(2500+sender.tag-2000)];
//            label.text=@"显示";
//        }else{
//            UILabel* label = (UILabel*)[self.view viewWithTag:(2500+sender.tag-2000)];
//            label.text=@"隐藏";
//        }
//    }
//}

//cell点击拥有阴影效果
//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//    [tableView deselectRowAtIndexPath:indexPath animated:YES];
//
//}

//侧滑允许编辑cell
-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
}

//侧滑按钮事件
-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
//    NSLog(@"cell点击按钮");
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 40;
}

//侧滑出现文字
//- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath{
//    if(indexPath.section == 0){
//        return @"置底";
//    }else{
//        return @"置顶";
//    }
//}




- (NSArray *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section==0){
        // 移动按钮
      UITableViewRowAction * moveRowAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDefault title:@"置底部菜单"handler:^(UITableViewRowAction *action, NSIndexPath *indexPath) {
          NSMutableDictionary* dicTop = [NSMutableDictionary dictionaryWithDictionary:_topMenuShowArray[indexPath.row]];
          [_topMenuShowArray removeObjectAtIndex:indexPath.row];
          [_bottomMenuShowArray addObject:dicTop];
          NSString* menuID = [NSString stringWithFormat:@"%@",[dicTop objectForKey:@"MenuID"]];
          for (int i = 0; i<_topMenuArray.count; i++) {
              NSString* newMenuID = [NSString stringWithFormat:@"%@",[_topMenuArray[i] objectForKey:@"MenuID"]];
              if ([menuID isEqualToString:newMenuID]) {
                  [_topMenuArray removeObjectAtIndex:i];
                  [_bottomMenuArray addObject:dicTop];
              }
          }
          [tableView reloadData];
        }];
        moveRowAction.backgroundColor = [UIColor redColor];

        
        //隐藏按钮
        UITableViewRowAction *hideRowAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleNormal title:@"隐藏"handler:^(UITableViewRowAction *action, NSIndexPath *indexPath) {
            
            NSMutableDictionary* dic = [NSMutableDictionary dictionaryWithDictionary:_topMenuShowArray[indexPath.row]];
            [dic removeObjectForKey:@"IsVisible"];
            [dic setValue:@"false" forKey:@"IsVisible"];
            //            [dic setValue:[NSNumber numberWithBool:NO] forKey:@"IsVisible"];
            [_hiddenMenuArray addObject:dic];
            [_topMenuShowArray removeObjectAtIndex:indexPath.row];
            NSString* menuID = [NSString stringWithFormat:@"%@",[dic objectForKey:@"MenuID"]];
            for (int i = 0; i<_topMenuArray.count; i++) {
                NSString* newMenuID = [NSString stringWithFormat:@"%@",[_topMenuArray[i] objectForKey:@"MenuID"]];
                if ([menuID isEqualToString:newMenuID]) {
                    [_topMenuArray removeObjectAtIndex:i];
                    [_topMenuArray insertObject:dic atIndex:i];
                }
            }
            NSLog(@"%@-------topmenu",_topMenuArray);
            [tableView reloadData];
            
            
            //[_bottomMenuShowArray addObject:dic];
//            [_topMenuArray removeObjectAtIndex:indexPath.row];
//            [_topMenuArray insertObject:dic atIndex:indexPath.row];
//            NSIndexSet* indexSet = [[NSIndexSet alloc]initWithIndexesInRange:NSMakeRange(0, 2)];
//            [_tableView reloadSections:indexSet withRowAnimation:UITableViewRowAnimationAutomatic];
        }];
        hideRowAction.backgroundEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
        // 将设置好的按钮放到数组中返回
        return @[moveRowAction, hideRowAction];
    }
    else  if(indexPath.section==1){
        // 移动按钮
      UITableViewRowAction * moveRowAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDefault title:@"置顶部菜单"handler:^(UITableViewRowAction *action, NSIndexPath *indexPath) {
          NSMutableDictionary* dicBot = [NSMutableDictionary dictionaryWithDictionary:_bottomMenuShowArray[indexPath.row]];
          [_bottomMenuShowArray removeObjectAtIndex:indexPath.row];
          [_topMenuShowArray addObject:dicBot];
          NSString* menuID = [NSString stringWithFormat:@"%@",[dicBot objectForKey:@"MenuID"]];
          for (int i = 0; i<_bottomMenuArray.count; i++) {
              NSString* newMenuID = [NSString stringWithFormat:@"%@",[_bottomMenuArray[i] objectForKey:@"MenuID"]];
              if ([menuID isEqualToString:newMenuID]) {
                  [_bottomMenuArray removeObjectAtIndex:i];
                  [_topMenuArray addObject:dicBot];
              }
          }
          [tableView reloadData];
        }];
        moveRowAction.backgroundColor = [UIColor redColor];
        
        //隐藏按钮
        UITableViewRowAction *hideRowAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleNormal title:@"隐藏"handler:^(UITableViewRowAction *action, NSIndexPath *indexPath) {
            
            NSMutableDictionary* dic = [NSMutableDictionary dictionaryWithDictionary:_bottomMenuShowArray[indexPath.row]];
            [dic removeObjectForKey:@"IsVisible"];
            [dic setValue:@"false" forKey:@"IsVisible"];
//            [dic setValue:[NSNumber numberWithBool:NO] forKey:@"IsVisible"];
            [_hiddenMenuArray addObject:dic];
            [_bottomMenuShowArray removeObjectAtIndex:indexPath.row];
            //[_bottomMenuShowArray addObject:dic];
            NSString* menuID = [NSString stringWithFormat:@"%@",[dic objectForKey:@"MenuID"]];
            for (int i = 0; i<_bottomMenuArray.count; i++) {
                NSString* newMenuID = [NSString stringWithFormat:@"%@",[_bottomMenuArray[i] objectForKey:@"MenuID"]];
                if ([menuID isEqualToString:newMenuID]) {
                    [_bottomMenuArray removeObjectAtIndex:i];
                    [_bottomMenuArray insertObject:dic atIndex:i];
                }
            }
//            NSLog(@"%@-------topmenu",_bottomMenuArray);
            [tableView reloadData];
            
//            NSIndexSet* indexSet = [[NSIndexSet alloc]initWithIndexesInRange:NSMakeRange(1, 2)];
//            [_tableView reloadSections:indexSet withRowAnimation:UITableViewRowAnimationAutomatic];
            NSLog(@"点击了隐藏");
            //NSLog(@"%@------bottom", _bottomMenuArray);
        }];
        hideRowAction.backgroundEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
        
        // 将设置好的按钮放到数组中返回
        return @[moveRowAction, hideRowAction];
    }
    else{
        UITableViewRowAction *showTopAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleNormal title:@"显示顶部菜单"handler:^(UITableViewRowAction *action, NSIndexPath *indexPath) {
            NSMutableDictionary* dic = [NSMutableDictionary dictionaryWithDictionary:_hiddenMenuArray[indexPath.row]];
            [dic removeObjectForKey:@"IsVisible"];
            [dic setValue:@"true" forKey:@"IsVisible"];
            [_topMenuShowArray addObject:dic];
            NSString* menuID = [NSString stringWithFormat:@"%@",[dic objectForKey:@"MenuID"]];
            [_hiddenMenuArray removeObjectAtIndex:indexPath.row];
            //[_bottomMenuShowArray addObject:dic];
            
            for (int i = 0; i<_topMenuArray.count; i++) {
                NSString* newMenuID = [NSString stringWithFormat:@"%@",[_topMenuArray[i] objectForKey:@"MenuID"]];
                if ([menuID isEqualToString:newMenuID]) {
                    [_topMenuArray removeObjectAtIndex:i];
                }
            }
            
            for (int i = 0; i<_bottomMenuArray.count; i++) {
                NSString* newMenuID = [NSString stringWithFormat:@"%@",[_bottomMenuArray[i] objectForKey:@"MenuID"]];
                if ([menuID isEqualToString:newMenuID]) {
                    [_bottomMenuArray removeObjectAtIndex:i];
                }
            }
            
            [_topMenuArray addObject:dic];
            [tableView reloadData];
        }];
        showTopAction.backgroundColor = [UIColor blueColor];
        
        UITableViewRowAction *showBottomAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleNormal title:@"显示底部菜单"handler:^(UITableViewRowAction *action, NSIndexPath *indexPath) {
            NSMutableDictionary* dic = [NSMutableDictionary dictionaryWithDictionary:_hiddenMenuArray[indexPath.row]];
            [dic removeObjectForKey:@"IsVisible"];
            [dic setValue:@"true" forKey:@"IsVisible"];
            [_bottomMenuShowArray addObject:dic];
            NSString* menuID = [NSString stringWithFormat:@"%@",[dic objectForKey:@"MenuID"]];
            [_hiddenMenuArray removeObjectAtIndex:indexPath.row];
            //[_bottomMenuShowArray addObject:dic];
            
            for (int i = 0; i<_topMenuArray.count; i++) {
                NSString* newMenuID = [NSString stringWithFormat:@"%@",[_topMenuArray[i] objectForKey:@"MenuID"]];
                if ([menuID isEqualToString:newMenuID]) {
                    [_topMenuArray removeObjectAtIndex:i];
                }
            }
            
            for (int i = 0; i<_bottomMenuArray.count; i++) {
                NSString* newMenuID = [NSString stringWithFormat:@"%@",[_bottomMenuArray[i] objectForKey:@"MenuID"]];
                if ([menuID isEqualToString:newMenuID]) {
                    [_bottomMenuArray removeObjectAtIndex:i];
                }
            }
            
            [_bottomMenuArray addObject:dic];
            [tableView reloadData];
        }];
        showBottomAction.backgroundColor = [UIColor redColor];
        return @[showTopAction, showBottomAction];
    }
    
}




//设定拖动cell
- (void)setLongPressDrag
{
    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressGestureRecognized:)];
    [self.tableView addGestureRecognizer:longPress];
}

- (UIView *)customSnapshoFromView:(UIView *)inputView {
    // 用cell的图层生成UIImage，方便一会显示
    UIGraphicsBeginImageContextWithOptions(inputView.bounds.size, NO, 0);
    [inputView.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    // 自定义这个快照的样子（下面的一些参数可以自己随意设置）
    UIView *snapshot = [[UIImageView alloc] initWithImage:image];
    snapshot.layer.masksToBounds = NO;
    snapshot.layer.cornerRadius = 0.0;
    snapshot.layer.shadowOffset = CGSizeMake(-5.0, 0.0);
    snapshot.layer.shadowRadius = 5.0;
    snapshot.layer.shadowOpacity = 0.4;
    return snapshot;
}

- (void)longPressGestureRecognized:(id)sender {
    UILongPressGestureRecognizer *longPress = (UILongPressGestureRecognizer *)sender;
    UIGestureRecognizerState state = longPress.state;
    CGPoint location = [longPress locationInView:self.tableView];
    NSIndexPath *indexPath = [self.tableView indexPathForRowAtPoint:location];
    static UIView       *snapshot = nil;
    static NSIndexPath  *sourceIndexPath = nil;

    switch (state) {
            // 已经开始按下
        case UIGestureRecognizerStateBegan: {
            // 判断是不是按在了cell上面
            if (indexPath) {
                sourceIndexPath = indexPath;
                UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
                // 为拖动的cell添加一个快照
                snapshot = [self customSnapshoFromView:cell];
                // 添加快照至tableView中
                __block CGPoint center = cell.center;
                snapshot.center = center;
                snapshot.alpha = 0.0;
                [self.tableView addSubview:snapshot];
                // 按下的瞬间执行动画
                [UIView animateWithDuration:0.25 animations:^{
                    center.y = location.y;
                    snapshot.center = center;
                    snapshot.transform = CGAffineTransformMakeScale(1.05, 1.05);
                    snapshot.alpha = 0.98;
                    cell.alpha = 0.0;

                } completion:^(BOOL finished) {

                    cell.hidden = YES;

                }];
            }
            break;
        }
            // 移动过程中
        case UIGestureRecognizerStateChanged: {
            // 这里保持数组里面只有最新的两次触摸点的坐标
            [self.touchPoints addObject:[NSValue valueWithCGPoint:location]];
            if (self.touchPoints.count > 2) {
                [self.touchPoints removeObjectAtIndex:0];
            }
            CGPoint center = snapshot.center;
            // 快照随触摸点y值移动（当然也可以根据触摸点的y轴移动量来移动）
            center.y = location.y;
            // 快照随触摸点x值改变量移动
            CGPoint Ppoint = [[self.touchPoints firstObject] CGPointValue];
            CGPoint Npoint = [[self.touchPoints lastObject] CGPointValue];
            CGFloat moveX = Npoint.x - Ppoint.x;
            center.x += moveX;
            snapshot.center = center;
//            NSLog(@"%@---%f----%@", self.touchPoints, moveX, NSStringFromCGPoint(center));
//            NSLog(@"%@", NSStringFromCGRect(snapshot.frame));
            // 是否移动了
            if (indexPath && ![indexPath isEqual:sourceIndexPath]) {

                if (indexPath.section==sourceIndexPath.section) {
                    if (indexPath.section==0) {
                        // 更新数组中的内容
                        int startNum = 0;
                        int endNum = 0;
                        NSMutableDictionary* startdic = [NSMutableDictionary dictionaryWithDictionary:_topMenuShowArray[indexPath.row]];
                        NSString* menuID = [NSString stringWithFormat:@"%@",[startdic objectForKey:@"MenuID"]];
                        NSMutableDictionary* enddic = [NSMutableDictionary dictionaryWithDictionary:_topMenuShowArray[sourceIndexPath.row]];
                        NSString* menuIDEnd = [NSString stringWithFormat:@"%@",[enddic objectForKey:@"MenuID"]];
                        for (int i = 0; i<_topMenuArray.count; i++) {
                            NSString* newMenuID = [NSString stringWithFormat:@"%@",[_topMenuArray[i] objectForKey:@"MenuID"]];
                            if ([menuID isEqualToString:newMenuID]) {
                                startNum = i;
                                NSLog(@"%d-------",i);
                            }
                        }
                        for (int i = 0; i<_topMenuArray.count; i++) {
                            NSString* newMenuID = [NSString stringWithFormat:@"%@",[_topMenuArray[i] objectForKey:@"MenuID"]];
                            if ([menuIDEnd isEqualToString:newMenuID]) {
                                endNum = i;
                                NSLog(@"%d-------",i);
                            }
                        }
                        
                        [self.topMenuArray exchangeObjectAtIndex:
                         startNum withObjectAtIndex:endNum];
                        
                        
                       
                        [self.topMenuShowArray exchangeObjectAtIndex:
                         indexPath.row withObjectAtIndex:sourceIndexPath.row];
                        //                    NSLog(@"%@--------",_dataArray);
                       
                    }else if (indexPath.section==1){
                        // 更新数组中的内容
                        
                        int startNum = 0;
                        int endNum = 0;
                        NSMutableDictionary* startdic = [NSMutableDictionary dictionaryWithDictionary:_bottomMenuShowArray[indexPath.row]];
                        NSString* menuID = [NSString stringWithFormat:@"%@",[startdic objectForKey:@"MenuID"]];
                        NSMutableDictionary* enddic = [NSMutableDictionary dictionaryWithDictionary:_bottomMenuShowArray[sourceIndexPath.row]];
                        NSString* menuIDEnd = [NSString stringWithFormat:@"%@",[enddic objectForKey:@"MenuID"]];
                        
                        for (int i = 0; i<_bottomMenuArray.count; i++) {
                            NSString* newMenuID = [NSString stringWithFormat:@"%@",[_bottomMenuArray[i] objectForKey:@"MenuID"]];
                            if ([menuID isEqualToString:newMenuID]) {
                                startNum = i;
                                NSLog(@"%d-------",i);
                            }
                        }
                        for (int i = 0; i<_bottomMenuArray.count; i++) {
                            NSString* newMenuID = [NSString stringWithFormat:@"%@",[_bottomMenuArray[i] objectForKey:@"MenuID"]];
                            if ([menuIDEnd isEqualToString:newMenuID]) {
                                endNum = i;
                                NSLog(@"%d-------",i);
                            }
                        }
                        
                        [self.bottomMenuArray exchangeObjectAtIndex:
                         startNum withObjectAtIndex:endNum];
                        [self.bottomMenuShowArray exchangeObjectAtIndex:
                         indexPath.row withObjectAtIndex:sourceIndexPath.row];
                        //NSLog(@"%@------------%@",[NSString stringWithFormat:@"%@",[_bottomMenuShowArray[indexPath.row] objectForKey:@"Name"]],[NSString stringWithFormat:@"%@",[_bottomMenuShowArray[indexPath.row] objectForKey:@"Name"]]);
                    }else{
                        // 更新数组中的内容
                        return;
                    }
                    // 把cell移动至指定行
                    [self.tableView moveRowAtIndexPath:sourceIndexPath toIndexPath:indexPath];
                    
                    // 存储改变后indexPath的值，以便下次比较
                    sourceIndexPath = indexPath;
                }else{
                    return;
                }
            }
            break;
        }
            // 长按手势取消状态
        default: {
            // 清除操作
            // 清空数组，非常重要，不然会发生坐标突变！
            [self.touchPoints removeAllObjects];
            UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:sourceIndexPath];
            cell.hidden = NO;
            cell.alpha = 0.0;
            // 将快照恢复到初始状态
            [UIView animateWithDuration:0.25 animations:^{
                snapshot.center = cell.center;
                snapshot.transform = CGAffineTransformIdentity;
                snapshot.alpha = 0.0;
                cell.alpha = 1.0;

            } completion:^(BOOL finished) {

                sourceIndexPath = nil;
                [snapshot removeFromSuperview];
                snapshot = nil;

            }];

            break;
        }
    }

}

#pragma mark-----------------加载数据
//获取菜单数据
-(void) getMenuDetailData{
    NSString* urlStrMenu=[NSString stringWithFormat:@"%@/App/GetAppMenu",PathStr];
    NSString *token = [NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"Token"]];
    NSDictionary* dicMenuParam =@{@"Token":token};
    [MBProgressHUD showLoadingMessage:@"加载中..." toView:self.view];
    [AFHTTPSessionManager GET:urlStrMenu parameters:dicMenuParam completionHandle:^(id model, NSError *error) {
        //NSLog(@"%@--------model",model);
        [MBProgressHUD hideHUDForView:self.view];
        if (error&&error!=nil) {
            
            [MBProgressHUD showError:error.domain];
            return ;
        }
        
        if(model&&model != nil){
            
            _topMenuArray=[NSMutableArray arrayWithArray:[model objectForKey:@"TopMenuList"]];
            _topMenuShowArray=[NSMutableArray arrayWithArray:[model objectForKey:@"TopMenuList"]];
            _bottomMenuArray=[NSMutableArray arrayWithArray:[model objectForKey:@"ButtomMenuList"]];
            _bottomMenuShowArray=[NSMutableArray arrayWithArray:[model objectForKey:@"ButtomMenuList"]];

            for(int i=0; (int)_topMenuShowArray.count > i;){//从数组后面开始删
                BOOL isVisbleTop = [[_topMenuShowArray[(int)_topMenuShowArray.count-i-1] objectForKey:@"IsVisible"] boolValue];
                if(!isVisbleTop){
                    NSDictionary * dicTop = _topMenuShowArray[(int)_topMenuShowArray.count-i-1];
                    [_hiddenMenuArray addObject:dicTop];
                    [_topMenuShowArray removeObjectAtIndex:((int)_topMenuShowArray.count-i-1)];
                    
                }
                else{
                    i++;//不删除的加起来
                }
            }
            
            for(int j = 0;(int)_bottomMenuShowArray.count>j;){
                BOOL isVisibleBot = [[_bottomMenuShowArray[(int)_bottomMenuShowArray.count-j-1] objectForKey:@"IsVisible"] boolValue];
                if(!isVisibleBot){
                    NSDictionary *dicBottom = _bottomMenuShowArray[(int)_bottomMenuShowArray.count-j-1];
                    [_hiddenMenuArray addObject:dicBottom];
                    [_bottomMenuShowArray removeObjectAtIndex:((int)_bottomMenuShowArray.count-j-1)];
                }else{
                    j++;//不删除的加起来
                }
            }
            //判断token过期时返回登录界面
            [self.tableView reloadData];
            
        }
        else{
            [MBProgressHUD showError:@"无数据返回"];
        }
        
    } ];
}

#pragma mark------------保存按钮
- (IBAction)saveNewMenuData:(id)sender {
    //NSLog(@"btn-------savesuccess");
    [self saveMenuData];
}

#pragma mark----------保存改变的菜单数据
-(void) saveMenuData{
    NSString *urlMenuStr = [NSString stringWithFormat:@"%@/App/SaveAppMenu",PathStr];
    //NSString *urlMenuStr = @"http://202.96.175.221:30701/MFOS/AppLogin/api/App/SaveAppMenu";
     //NSLog(@"%@---------",urlMenuStr);
    NSString *token = [NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"Token"]];
    //NSLog(@"%@---------",token);
    NSDictionary* dicMenueParam =@{
                                   @"Token":token,
                                   @"TopMenuList":_topMenuArray,
                                   @"ButtomMenuList":_bottomMenuArray,
                                  };
   NSLog(@"%@---------dicMenueParam",dicMenueParam);

    [AFHTTPSessionManager POST:urlMenuStr parameters:dicMenueParam completionHandle:^(id model, NSError *error) {
        //NSLog(@"%@----------postModel",model);
        if (error&&error!=nil) {
            [MBProgressHUD showError:error.domain];
            return ;
        }
        NSString *status = [NSString stringWithFormat:@"%@",model[@"status"]];
        NSString *msg = [NSString stringWithFormat:@"%@",model[@"msg"]];
        //NSLog(@"%@----------msg",msg);
        if([status isEqualToString:@"200"]){
            [MBProgressHUD showSuccess:msg];
        }else{
            [MBProgressHUD showError:msg];
        }
    }];
}



@end
