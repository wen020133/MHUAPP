//
//  WJStoreHeadCollectionView.h
//  MHUAPP
//
//  Created by wenchengjun on 2018/5/13.
//  Copyright © 2018年 wenchengjun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WJStoreHeadCollectionView : UICollectionReusableView

/** 点击广告 */
@property (nonatomic, copy) dispatch_block_t goToTuijianGoodBlock;

/* 店名 */
@property (strong , nonatomic)UILabel *titleLabel;

/* 图片 */
@property (strong , nonatomic)UIImageView *headImageView;

/* 全部宝贝Num */
@property (strong , nonatomic)UILabel *lab_allGood;
/* 商家描述 */
@property (strong , nonatomic)UILabel *lab_shangjiaMiaosuNum;
/* 服务态度 */
@property (strong , nonatomic)UILabel *lab_fuwuNum;
/* 物流速度 */
@property (strong , nonatomic)UILabel *lab_wlSuduNum;
@end
