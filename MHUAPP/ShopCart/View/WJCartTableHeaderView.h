//
//  WJCartTableHeaderView.h
//  MHUAPP
//
//  Created by jinri on 2018/1/25.
//  Copyright © 2018年 wenchengjun. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^buttonClickBlock)(BOOL select);

@interface WJCartTableHeaderView : UITableViewHeaderFooterView

@property (copy,nonatomic) NSString *title;
@property (copy,nonatomic) buttonClickBlock WJClickBlock;
@property (assign,nonatomic) BOOL select;

@end
