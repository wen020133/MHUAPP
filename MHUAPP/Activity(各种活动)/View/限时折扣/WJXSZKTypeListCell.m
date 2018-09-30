//
//  WJXSZKTypeListCell.m
//  MHUAPP
//
//  Created by jinri on 2018/9/30.
//  Copyright © 2018年 wenchengjun. All rights reserved.
//

#import "WJXSZKTypeListCell.h"
#import "UIView+UIViewFrame.h"
#import <UIImageView+WebCache.h>

@interface WJXSZKTypeListCell ()

@property (nonatomic, strong)NSTimer *timer;
@property (strong, nonatomic) NSString *end_time;
@end


@implementation WJXSZKTypeListCell

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {

        _grayView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kMSScreenWith, 105)];
        _grayView.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:_grayView];

        _img_content = [[UIImageView alloc]initWithFrame:CGRectMake(14, 8, 95, 95)];
        _img_content.backgroundColor = kMSCellBackColor;
        _img_content.contentMode = UIViewContentModeScaleAspectFit;
        [_grayView addSubview:_img_content];

        _lab_title= [[UILabel alloc]init];
        _lab_title.font = PFR15Font;
        _lab_title.textColor = [RegularExpressionsMethod ColorWithHexString:BASEBLACKCOLOR];
        _lab_title.textAlignment = NSTextAlignmentLeft;
        _lab_title.numberOfLines = 2;
        [_grayView addSubview:_lab_title];

        _priceLabel = [[UILabel alloc] init];
        _priceLabel.font = Font(17);
        _priceLabel.textColor = [UIColor redColor];
        [self addSubview:_priceLabel];

        _oldPriceLabel = [[UILabel alloc] init];
        _oldPriceLabel.font = PFR12Font;
        _oldPriceLabel.contentMode = NSTextAlignmentLeft;
        _oldPriceLabel.textColor = [RegularExpressionsMethod ColorWithHexString:kGrayBgColor];
        [self addSubview:_oldPriceLabel];

        _lab_zhekou = [[UILabel alloc]initWithFrame:CGRectMake(kMSScreenWith-70, self.height-58, 40, 17)];
        _lab_zhekou.font = PFR12Font;
        _lab_zhekou.backgroundColor = [RegularExpressionsMethod ColorWithHexString:BASEPINK];
        _lab_zhekou.textColor = kMSCellBackColor;
        _lab_zhekou.layer.cornerRadius = 4;
        _lab_zhekou.layer.masksToBounds = YES;//设置圆角
        _lab_zhekou.textAlignment = NSTextAlignmentCenter;
        [_grayView addSubview:_lab_zhekou];

        _lab_count = [[UILabel alloc]init];
        _lab_count.font = PFR13Font;
        _lab_count.textColor = [RegularExpressionsMethod ColorWithHexString:BASELITTLEBLACKCOLOR];
        _lab_count.frame = CGRectMake(_img_content.Right+DCMargin, self.height-40, 100, 30);
        _lab_count.textAlignment = NSTextAlignmentLeft;
        [_grayView addSubview:_lab_count];

        _img_date = [[UIImageView alloc]initWithFrame:CGRectMake(200, self.height-33, 16, 16)];
        _img_date.contentMode = UIViewContentModeScaleAspectFit;
        _img_date.image = [UIImage imageNamed:@"search_history_icon"];
        [_grayView addSubview:_img_date];

        _lab_date = [[UILabel alloc]init];
        _lab_date.font = PFR12Font;
        _lab_date.textColor = [RegularExpressionsMethod ColorWithHexString:BASELITTLEBLACKCOLOR];
        _lab_date.frame = CGRectMake(220, self.height-35, kMSScreenWith-208, 20);
        _lab_date.textAlignment = NSTextAlignmentLeft;
        [_grayView addSubview:_lab_date];



    }
    return self;
}

- (void)timeHeadle{

    int secondsCountDown = [self getDateDifferenceWithNowDateStr:self.end_time];

    // 重新计算 天/时/分/秒
    int days = (int)(secondsCountDown/(3600*24));
    int hours = (int)((secondsCountDown-days*24*3600)/3600);
    int minute = (int)(secondsCountDown-days*24*3600-hours*3600)/60;
    int second = secondsCountDown-days*24*3600-hours*3600-minute*60;


    NSString *format_time = [NSString stringWithFormat:@"%d天%d时%d分%d秒", days,hours, minute, second];
    // 修改倒计时标签及显示内容
    _lab_date.text = [NSString stringWithFormat:@"%@", format_time];
    // 当倒计时结束时做需要的操作: 比如活动到期不能提交
    if(secondsCountDown <= 0) {
        _lab_date.text = @"活动已结束";
        [_timer invalidate];
        _timer = nil;
    }
}


-(void)setModel:(WJXSZKListItem *)model
{
    if (model!=_model) {
        _model = model;
    }
    NSString *urlStr = [NSString stringWithFormat:@"%@",_model.original_img] ;
    [_img_content sd_setImageWithURL:[NSURL URLWithString:urlStr] placeholderImage:[UIImage imageNamed:@"default_nomore.png"] completed:nil];

    _lab_title.frame =CGRectMake(_img_content.Right+DCMargin, 2, kMSScreenWith-DCMargin*2-100, [RegularExpressionsMethod dc_calculateTextSizeWithText:_model.goods_name WithTextFont:15 WithMaxW:kMSScreenWith - DCMargin * 2-100].height+2);
    _lab_title.text = _model.goods_name;
    //    _lab_describe.text = _model.goods_brief;

    _priceLabel.text = [NSString stringWithFormat:@"¥%@",_model.promote_price];
    _priceLabel.frame = CGRectMake(_img_content.Right+DCMargin, self.height-62, [RegularExpressionsMethod widthOfString:_priceLabel.text font:Font(17) height:21]+5, 21);

    if (_model.org_price.length>0) {
        NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:_model.org_price
                                                                                    attributes:@{NSStrikethroughStyleAttributeName : @(NSUnderlineStyleSingle)}];
        _oldPriceLabel.attributedText = attrStr;

        _oldPriceLabel.frame = CGRectMake(_priceLabel.Right, self.height-58, [RegularExpressionsMethod widthOfString:_model.org_price font:Font(12) height:17]+2, 17);
    }

    _lab_zhekou.text = [NSString stringWithFormat:@"%@折",_model.zhekou];


    _lab_count.text = [NSString stringWithFormat:@"已售%@件",_model.num];
    self.end_time = _model.promote_end_date;
    
    _timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timeHeadle) userInfo:nil repeats:YES];


}


- (int)getDateDifferenceWithNowDateStr:(NSString*)deadlineStr {
    int timeDifference = 0;
    NSDate* dat = [NSDate dateWithTimeIntervalSinceNow:0];
    NSTimeInterval nowDate=[dat timeIntervalSince1970];

    NSTimeInterval endTime = [deadlineStr doubleValue];
    timeDifference = endTime-nowDate;

    return timeDifference;
}
@end
