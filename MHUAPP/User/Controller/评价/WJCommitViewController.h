//
//  WJCommitViewController.h
//  MHUAPP
//
//  Created by jinri on 2018/6/8.
//  Copyright © 2018年 wenchengjun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WJCommitBaseController.h"
#import "MunuView.h"

@interface WJCommitViewController : WJCommitBaseController<MunuViewDelegate>

@property (strong, nonatomic) MunuView *menu_ScrollView; //分类ScrollView
@property (assign, nonatomic) NSString *goods_id;
@property (assign, nonatomic) NSString *rec_id;
@end
