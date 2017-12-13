//
//  WJUserInfoListCel.h
//  MHUAPP
//
//  Created by jinri on 2017/12/13.
//  Copyright © 2017年 wenchengjun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WJUserInfoListCel : UITableViewCell
/* 列表名称 */
@property (strong , nonatomic) UILabel *nameLabel;
/* 箭头图片 */
@property (strong , nonatomic) UIImageView *actionImageView;
/* line */
@property (strong , nonatomic) UIImageView *lineImageView;

/* 内容 */
@property (strong , nonatomic) UILabel *contentLabel;
@end
