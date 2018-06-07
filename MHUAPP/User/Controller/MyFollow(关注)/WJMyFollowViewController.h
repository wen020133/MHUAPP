//
//  WJMyFollowViewController.h
//  MHUAPP
//
//  Created by jinri on 2018/4/12.
//  Copyright © 2018年 wenchengjun. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import "MunuView.h"
#import "BaseNetworkViewController.h"

@interface WJMyFollowViewController : BaseNetworkViewController<UITableViewDelegate,UITableViewDataSource>

//@property (strong, nonatomic) MunuView *menu_ScrollView; //分类ScrollView

@property (strong, nonatomic)  UITableView *mainTableView;

//@property (strong, nonatomic) NSArray *arr_Type;


@end
