//
//  WJManageUserInfoViewController.h
//  MHUAPP
//
//  Created by jinri on 2017/12/12.
//  Copyright © 2017年 wenchengjun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseNetworkViewController.h"

@interface WJManageUserInfoViewController : BaseNetworkViewController<UITableViewDelegate,UITableViewDataSource>

@property (strong, nonatomic) UITableView *infoTableView;
@property (strong, nonatomic) UIView *view_head;
@property (strong, nonatomic) NSArray   *arr_typeName;
@property (strong, nonatomic) NSArray   *arr_content;
/* 图片 */
@property (strong , nonatomic) UIImageView *headImageView;
@end
