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

//商品数量
@property (assign,nonatomic)NSInteger lzNumber;
@property (assign,nonatomic)BOOL lzSelected;

- (void)reloadDataWithModel:(WJCartGoodsModel*)model;
- (void)numberAddWithBlock:(LZNumberChangedBlock)block;
- (void)numberCutWithBlock:(LZNumberChangedBlock)block;
- (void)cellSelectedWithBlock:(LZCellSelectedBlock)block;

@end
