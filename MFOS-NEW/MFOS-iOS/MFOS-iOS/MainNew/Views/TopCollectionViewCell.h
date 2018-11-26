//
//  TopCollectionViewCell.h
//  MFOS-iOS
//
//  Created by Alvin.Feng on 2017/12/26.
//  Copyright © 2017年 Alvin.Feng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TopCollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *topLabel;
@property (weak, nonatomic) IBOutlet UILabel *bottomLabel;

@end
