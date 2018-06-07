//
//  WJBackOrderReasonView.h
//  MHUAPP
//
//  Created by jinri on 2018/6/4.
//  Copyright © 2018年 wenchengjun. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol BackOrderReasonSelectDelegate <NSObject>
- (void)didSelectedReasonBUttonWithString:(NSString *)reasonString;
@end

@interface WJBackOrderReasonView : UIView

@property (assign, nonatomic) id<BackOrderReasonSelectDelegate> delegate;

- (id)initWithFrame:(CGRect)frame withTitles:(NSArray *)arr;

@property  NSInteger selectIndexPathRow;

@end
