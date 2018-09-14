//
//  WJCartTableViewCell.h
//  MHUAPP
//
//  Created by jinri on 2018/1/25.
//  Copyright © 2018年 wenchengjun. All rights reserved.
//

#import <UIKit/UIKit.h>

@class WJCartGoodsModel;

typedef void(^LZNumberChangedBlock)(NSInteger number);
typedef void(^LZCellSelectedBlock)(BOOL select);

@interface WJCartTableViewCell : UITableViewCell

//选中按钮
@property (nonatomic,strong) UIButton *selectBtn;
//显示照片
@property (nonatomic,strong) UIImageView *lzImageView;
//商品名
@property (nonatomic,strong) UILabel *nameLabel;
//属性
@property (nonatomic,strong) UILabel *attributeLabel;
//优惠详情
@property (nonatomic,strong) UILabel *youhuiLabel;

//原价
@property (nonatomic,strong) UILabel *lab_market_price;

//现价
@property (nonatomic,strong) UILabel *priceLabel;
//数量
@property (nonatomic,strong)UILabel *numberLabel;

//Cell分割线
@property (nonatomic,strong)UIImageView *imageLine;

//商品数量
@property (assign,nonatomic)NSInteger lzNumber;
@property (assign,nonatomic)BOOL lzSelected;

- (void)reloadDataWithModel:(WJCartGoodsModel*)model;
- (void)numberAddWithBlock:(LZNumberChangedBlock)block;
- (void)numberCutWithBlock:(LZNumberChangedBlock)block;
- (void)cellSelectedWithBlock:(LZCellSelectedBlock)block;

@property (nonatomic, strong) UILabel *hongbaoLabel;


@end
