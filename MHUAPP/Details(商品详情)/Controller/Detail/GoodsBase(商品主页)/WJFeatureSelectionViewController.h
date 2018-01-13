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
/* 上一次选择的属性 */
@property (strong , nonatomic)NSMutableArray *lastSeleArray;
/* 上一次选择的数量 */
@property (assign , nonatomic)NSString *lastNum;

@end
