//
//  WJFiltrateViewController.h
//  MHUAPP
//
//  Created by jinri on 2017/12/2.
//  Copyright © 2017年 wenchengjun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WJFiltrateViewController : UIViewController

/** 点击已选回调 */
@property (nonatomic , copy) void(^sureClickBlock)(NSArray *selectArray);
@end
