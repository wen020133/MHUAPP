//
//  WJZhuanTiHuoDongCell.m
//  MHUAPP
//
//  Created by jinri on 2018/2/25.
//  Copyright © 2018年 wenchengjun. All rights reserved.
//

#import "WJZhuanTiHuoDongCell.h"
#import <UIImageView+WebCache.h>
#import "UIView+UIViewFrame.h"



@implementation WJZhuanTiHuoDongCell

#pragma mark - Intial
- (instancetype)initWithFrame:(CGRect)frame {

    self = [super initWithFrame:frame];
    if (self) {
        self.arr_data = [NSArray arrayWithObjects:@"满赠臻礼", @"满赠臻礼",@"满赠臻礼",@"满赠臻礼",nil];
        [self setUpUIZhuanTi];
    }
    return self;
}

- (void)setUpUIZhuanTi
{
    self.backgroundColor = kMSCellBackColor;


  NSInteger countNumber = 0;
    
    for (NSInteger x = 0; x < 2; x ++) {
            // 几列
        for (NSInteger y = 0; y < 2; y ++) {

            if (countNumber == self.arr_data.count) {
                return;
            }
        UILabel *labmeiribiqiang = LabelInit(y*kMSScreenWith/2+10, 20+(x * self.height/2), kMSScreenWith/2-80, 21);
        labmeiribiqiang.text = [self.arr_data objectAtIndex:countNumber];
        labmeiribiqiang.font = Font(17);
        labmeiribiqiang.textColor = [RegularExpressionsMethod ColorWithHexString:BASEBLACKCOLOR];
        [self addSubview:labmeiribiqiang];

        UILabel *labmeiri_mess =LabelInit(y*kMSScreenWith/2+10 , labmeiribiqiang.Bottom+10, kMSScreenWith/2-80, 20);
        labmeiri_mess.text = @"活动不止，惊喜不断";
        labmeiri_mess.font = Font(12);
        labmeiri_mess.textColor = [RegularExpressionsMethod ColorWithHexString:@"707070"];
        [self addSubview:labmeiri_mess];

        UIImageView *imagcontent = ImageViewInit(labmeiribiqiang.Right+5, 5+(x * self.height/2), 60, 60);
        imagcontent.contentMode = UIViewContentModeScaleAspectFit;
        imagcontent.image = [UIImage imageNamed:@"home_snap_img"];
        [self addSubview:imagcontent];

            countNumber ++;
    }
    }
        UIImageView *line1 = ImageViewInit(0, 0, kMSScreenWith, 1);
        line1.backgroundColor = [RegularExpressionsMethod ColorWithHexString:@"E6E6E6"];
        [self addSubview:line1];

        UIImageView *line2 = ImageViewInit(0, self.height/2, kMSScreenWith, 1);
        line2.backgroundColor = [RegularExpressionsMethod ColorWithHexString:@"E6E6E6"];
        [self addSubview:line2];

        UIImageView *line3 = ImageViewInit(kMSScreenWith/2, 0, 1, self.height);
        line3.backgroundColor = [RegularExpressionsMethod ColorWithHexString:@"E6E6E6"];
        [self addSubview:line3];
}



@end
