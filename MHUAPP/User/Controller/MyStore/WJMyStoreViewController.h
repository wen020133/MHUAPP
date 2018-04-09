//
//  WJMyStoreViewController.h
//  MHUAPP
//
//  Created by jinri on 2018/4/8.
//  Copyright © 2018年 wenchengjun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MunuView.h"

@interface WJMyStoreViewController : UIViewController<MunuViewDelegate,UITableViewDelegate,UITableViewDataSource>
{
    NSInteger ph_currentIndex;

}
@property (strong, nonatomic) MunuView *menu_ScrollView; //分类ScrollView

@property (strong, nonatomic)  UITableView *mainTableView;

@property (strong, nonatomic) NSArray *arr_Type;

@property (strong, nonatomic) UIView *view_head;

@end
