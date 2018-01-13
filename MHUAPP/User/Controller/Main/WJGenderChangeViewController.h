//
//  WJGenderChangeViewController.h
//  MHUAPP
//
//  Created by jinri on 2018/1/12.
//  Copyright © 2018年 wenchengjun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WJGenderChangeViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>

@property (strong, nonatomic) UITableView *tab_content;
@property (strong, nonatomic) NSArray *arr_type;
@end
