//
//  WJOrderFooter.h
//  MHUAPP
//
//  Created by jinri on 2017/12/21.
//  Copyright © 2017年 wenchengjun. All rights reserved.
//

#import <UIKit/UIKit.h>



@interface WJOrderFooter : UITableViewHeaderFooterView

@property (nonatomic, strong) UILabel *totalPayPrice;

@property  NSInteger orderType;

/** 筛选点击回调 */
@property (nonatomic , copy) void(^ClickStateForStrBlock)(NSString *stateStr);

@end
