//
//  WJUnLoginStateTypeView.h
//  MHUAPP
//
//  Created by jinri on 2018/6/25.
//  Copyright © 2018年 wenchengjun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WJUnLoginStateTypeView : UIView

- (id)initWithFrame:(CGRect)frame withContent:(NSString *)str withImage:(NSString *)imageName;

- (void)hide;
@property (nonatomic, copy) dispatch_block_t jumpToLoginPage;
@end
