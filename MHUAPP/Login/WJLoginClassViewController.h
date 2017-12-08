//
//  WJLoginClassViewController.h
//  MHUAPP
//
//  Created by jinri on 2017/12/7.
//  Copyright © 2017年 wenchengjun. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol LoginClassViewStateDelegate <NSObject>
- (void)didComeBackToClassWithTypeFrom;
@end

@interface WJLoginClassViewController : UIViewController<UITextFieldDelegate>

@property NSInteger regType; // 0普通登陆 ； 1 QQ ； 2微信； 3新浪微博
@property (strong, nonatomic)  UITextField *text_mobileNumber;
@property (strong, nonatomic)  UITextField *textF_password;
@property (retain, nonatomic)  NSString *outUserType;
@property (retain, nonatomic)  NSString *outUserId;
@property (retain, nonatomic)  NSString *outNickName;
@property (retain, nonatomic)  NSString *realName;
@property (assign, nonatomic) id<LoginClassViewStateDelegate> deleLogate;
@end
