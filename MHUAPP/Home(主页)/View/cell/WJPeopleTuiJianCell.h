//
//  WJPeopleTuiJianCell.h
//  MHUAPP
//
//  Created by jinri on 2018/2/25.
//  Copyright © 2018年 wenchengjun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WJPeopleTuiJianCell : UICollectionViewCell

@property (nonatomic, strong) UIImageView *img_first;
@property (nonatomic, strong) UIImageView *img_second;
@property (nonatomic, strong) UIImageView *img_third;
@property (nonatomic, strong) UIImageView *img_fourth;

@property (nonatomic, strong) NSArray *arr_tuijiandata;

-(void)setUpUI;
@end
