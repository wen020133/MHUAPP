//
//  WJSecondsKillViewController.h
//  MHUAPP
//
//  Created by jinri on 2018/1/4.
//  Copyright © 2018年 wenchengjun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WJButtonNewlineScrollView.h"

@interface WJSecondsKillViewController : UIViewController<ButtonNewlineDelegate,UITableViewDelegate,UITableViewDataSource>


@property (strong, nonatomic) WJButtonNewlineScrollView *menuScrollView; //分类ScrollView
@property (strong, nonatomic) NSMutableArray *arr_dateTitle;
@property (strong, nonatomic)  UITableView *mainTableView;
@end
