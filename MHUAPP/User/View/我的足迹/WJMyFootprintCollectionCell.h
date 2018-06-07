//
//  WJMyFootprintCollectionCell.h
//  MHUAPP
//
//  Created by jinri on 2018/6/6.
//  Copyright © 2018年 wenchengjun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WJMyFootprintCollectionCell : UITableViewCell
@property (nonatomic, strong) UIImageView *contentImg;

@property (nonatomic, strong) UILabel *title;
@property (nonatomic, strong) UILabel *type;
@property (nonatomic, strong) UILabel *price;

//Cell分割线
@property (nonatomic,strong)UIImageView *imageLine;


@end
