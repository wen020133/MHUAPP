//
//  WJSSPTAllClassHeadView.h
//  MHUAPP
//
//  Created by jinri on 2018/3/27.
//  Copyright © 2018年 wenchengjun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HXSearchBar.h"


@interface WJSSPTAllClassHeadView : UICollectionReusableView<UISearchBarDelegate>

@property (strong, nonatomic) HXSearchBar *searchBar;

/* 图片 */
@property (strong , nonatomic) UIImageView *img_content;


/** 点击搜索 */
@property (nonatomic , copy) void(^userChickSearch)(NSString *searchText);
///* 今日必拼 */
//@property (strong , nonatomic)UILabel *titleLabel;
//
//
///* 剩余时间 */
//@property (strong , nonatomic)UILabel *timeLabel;
//
//@property (nonatomic, strong) UILabel *hourLabel;
//@property (nonatomic, strong) UILabel *minuteLabel;
//@property (nonatomic, strong) UILabel *secondLabel;
////创建定时器(因为下面两个方法都使用,所以定时器拿出来设置为一个属性)
//@property (nonatomic,strong) NSTimer *countDownTimer;
//
//@property NSInteger  secondsCountDown;

@end
