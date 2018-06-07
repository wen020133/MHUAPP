//
//  WJMyFootprintCollectionCell.m
//  MHUAPP
//
//  Created by jinri on 2018/6/6.
//  Copyright © 2018年 wenchengjun. All rights reserved.
//

#import "WJMyFootprintCollectionCell.h"
#import "UIView+UIViewFrame.h"
#import <UIImageView+WebCache.h>


@implementation WJMyFootprintCollectionCell


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = kMSCellBackColor;
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self setUpUI];
    }
    return self;
}

#pragma mark - UI
- (void)setUpUI
{
    _contentImg = [[UIImageView alloc] initWithFrame:CGRectMake(DCMargin, 5, TAG_Height-10, TAG_Height-10)];
    [self.contentView addSubview:_contentImg];

    _title = [[UILabel alloc] initWithFrame: CGRectMake(TAG_Height+DCMargin, 5, kMSScreenWith- DCMargin * 4-TAG_Height, 40)];

    _title.textColor = [RegularExpressionsMethod ColorWithHexString:BASEBLACKCOLOR];
    _title.numberOfLines = 2;
    _title.textAlignment = NSTextAlignmentLeft;
    _title.font = Font(14);
    [self.contentView addSubview:_title];

    _price = [[UILabel alloc] initWithFrame:CGRectMake(TAG_Height+DCMargin, _title.Bottom+20, 120, 23)];
    _price.textColor = [RegularExpressionsMethod ColorWithHexString:BASEPINK];
    _price.font = Font(14);
    [self.contentView addSubview:_price];


    _type = [[UILabel alloc] initWithFrame:CGRectMake(TAG_Height+DCMargin, _title.Bottom+5, _title.width, 20)];
    _type.textColor = [RegularExpressionsMethod ColorWithHexString:BASELITTLEBLACKCOLOR];
    _type.font = Font(12);
    [self.contentView addSubview:_type];

    self.imageLine = ImageViewInit(self.contentImg.Right + 5, 99, kMSScreenWith-self.contentImg.Right -15, 1);
    self.imageLine.backgroundColor = [[UIColor lightGrayColor]colorWithAlphaComponent:0.4];
    [self.contentView addSubview:self.imageLine];
}

@end
