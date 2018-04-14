//
//  WJZhuanTiHuoDongCell.h
//  MHUAPP
//
//  Created by jinri on 2018/2/25.
//  Copyright © 2018年 wenchengjun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WJMainZhuanTiHDItem.h"

@interface WJZhuanTiHuoDongCell : UICollectionViewCell

@property (nonatomic, strong) NSArray<WJMainZhuanTiHDItem *> *arr_data;

-(void)setUpUIZhuanTi;

@end
