//
//  WJUserSettingMainViewController.h
//  MHUAPP
//
//  Created by jinri on 2017/12/6.
//  Copyright © 2017年 wenchengjun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WJUserSettingMainViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>

@property (strong, nonatomic) UITableView *infoTableView;
@property (strong, nonatomic) UIButton   *deleteBtn;

@property (strong, nonatomic) NSArray   *arr_typeName;

@property (strong, nonatomic) UIView *view_head;
@property (strong, nonatomic) UIView *view_foot;
/* 图片 */
@property (strong , nonatomic) UIImageView *headImageView;
/* 名字 */
@property (strong , nonatomic) UILabel *userNameLabel;
/* 签名 */
@property (strong , nonatomic) UILabel *profileLabel;


@end
