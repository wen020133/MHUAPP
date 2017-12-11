//
//  WJPushPasswordViewController.h
//  MHUAPP
//
//  Created by jinri on 2017/12/11.
//  Copyright © 2017年 wenchengjun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseNetworkViewController.h"

@interface WJPushPasswordViewController : BaseNetworkViewController
@property (strong , nonatomic) NSString *str_phone;
@property (strong , nonatomic) NSString *str_code;
@property (weak, nonatomic) IBOutlet UITextField *text_password;
- (IBAction)rigister:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *text_secondF;
@end
