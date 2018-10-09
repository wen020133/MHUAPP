//
//  WJCGPFFeatureSelectionViewController.h
//  MHUAPP
//
//  Created by jinri on 2018/10/8.
//  Copyright © 2018年 wenchengjun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WJCGPFFeatureSelectionViewController : UIViewController


/* 商品图片 */
@property (strong , nonatomic)NSString *goodImageView;
/* goods_name */
@property (strong , nonatomic)NSString *goods_name;
/* 起始价格 */
@property (strong , nonatomic)NSString *offer_price_one;
/* 最高数量价格 */
@property (strong , nonatomic) NSString *offer_price_three;
/* 最低起批量 */
@property (strong , nonatomic) NSString *start_num;


/* 属性 */
@property (copy , nonatomic) NSArray  *arr_fuckData;

@end
