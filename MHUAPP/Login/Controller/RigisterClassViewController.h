//
//  RigisterClassViewController.h
//  meijiaPrinter
//
//  Created by 今日电器 on 15/7/10.
//  Copyright (c) 2015年 wenchengjun. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface RigisterClassViewController : UIViewController<UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *text_moblieNumber;
@property (weak, nonatomic) IBOutlet UILabel *lab_countryNum;
- (IBAction)theNextStep:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *lab_protocol;

@end
