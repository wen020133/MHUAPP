//
//  WJMyFollowViewController.h
//  MHUAPP
//
//  Created by jinri on 2018/4/12.
//  Copyright © 2018年 wenchengjun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MunuView.h"

@interface WJMyFollowViewController : UIViewController<MunuViewDelegate,UITableViewDelegate,UITableViewDataSource>

@property (strong, nonatomic) MunuView *menu_ScrollView; //分类ScrollView

@property (strong, nonatomic)  UITableView *mainTableView;

@property (strong, nonatomic) NSArray *arr_Type;

@property (assign, nonatomic) BOOL selectedState;

@property (strong,nonatomic)UIButton *allSellectedButton;
@end
