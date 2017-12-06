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
@property (strong, nonatomic) NSString   *str_Hearurl;
@property (strong, nonatomic) NSArray   *arr_typeName;
@property (strong, nonatomic) NSArray   *arr_content;

@end
