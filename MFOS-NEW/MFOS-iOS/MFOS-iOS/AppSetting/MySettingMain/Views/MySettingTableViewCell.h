//
//  MySettingTableViewCell.h
//  MFOS-iOS
//
//  Created by Alvin.Feng on 2018/1/3.
//  Copyright © 2018年 Alvin.Feng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MySettingTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *myPhoto;
@property (weak, nonatomic) IBOutlet UILabel *myName;

@end

@interface MyMenuTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *menuIcon;
@property (weak, nonatomic) IBOutlet UILabel *myMenu;

@end
