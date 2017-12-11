//
//  WJPushCodeViewController.h
//  MHUAPP
//
//  Created by jinri on 2017/12/11.
//  Copyright © 2017年 wenchengjun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIButton+CountDown.h"
#import "MJCountDownButton.h"
#import "BaseNetworkViewController.h"


@interface WJPushCodeViewController : BaseNetworkViewController

@property (weak, nonatomic) IBOutlet MJCountDownButton *cBtn;
@property (strong , nonatomic) NSString *str_phone;
- (IBAction)toPasswordWC:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *text_code;
@end
