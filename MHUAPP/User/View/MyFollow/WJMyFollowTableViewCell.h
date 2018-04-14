//
//  WJMyFollowTableViewCell.h
//  MHUAPP
//
//  Created by jinri on 2018/4/12.
//  Copyright © 2018年 wenchengjun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WJFollowClassItem.h"

@interface WJMyFollowTableViewCell : UITableViewCell

//选中按钮
@property (nonatomic,strong) UIButton *selectBtn;
//显示照片
@property (nonatomic,strong) UIImageView *lzImageView;
//店铺名
@property (nonatomic,strong) UILabel *lab_name;
//上新
@property (nonatomic,strong) UILabel *lab_New;
//综合评分
@property (nonatomic,strong) UILabel *lab_store;
//关注人数
@property (nonatomic,strong) UILabel *lab_followNum;

/** 筛选点击回调 */
@property (nonatomic , copy) void(^WJCellSelectedBlock)(BOOL select);

- (void)reloadDataWithModel:(WJFollowClassItem*)item;

//选中按钮是否含有
@property  BOOL *selectHidden;

@end
