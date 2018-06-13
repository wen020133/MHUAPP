//
//  WJFeatureSelectionViewController.h
//  MHUAPP
//
//  Created by jinri on 2018/1/8.
//  Copyright © 2018年 wenchengjun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WJFeatureSelectionViewController : UIViewController

/* 商品图片 */
@property (strong , nonatomic)NSString *goodImageView;
/* 商品价格 */
@property (strong , nonatomic)NSString *goodPrice;

/* 上一次选择的属性 */
@property (strong , nonatomic)NSMutableArray *lastSeleArray;
/* 上一次选择的数量 */
@property (assign , nonatomic)NSString *lastNum;

/* 属性 */
@property (copy , nonatomic) NSArray  *arr_fuckData;

/* 图片数组 */
@property (copy , nonatomic) NSArray  *arr_goodImage;
/* 商品库存 */
@property NSInteger goods_number;

@property (assign, nonatomic) NSString *str_IsmiaoshaPT;
@end
