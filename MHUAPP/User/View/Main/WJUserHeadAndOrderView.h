//
//  WJUserHeadAndOrderView.h
//  MHUAPP
//
//  Created by jinri on 2017/12/6.
//  Copyright © 2017年 wenchengjun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WJUserHeadAndOrderView : UICollectionReusableView
/** 点击头像 */
@property (nonatomic, copy) dispatch_block_t touchClickBlock;
- (IBAction)touchUserHeadImageView:(UIButton *)sender;


@end
