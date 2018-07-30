//
//  WJUserInfoListCel.m
//  MHUAPP
//
//  Created by jinri on 2017/12/13.
//  Copyright © 2017年 wenchengjun. All rights reserved.
//

#import "WJUserInfoListCel.h"
#import "UIView+UIViewFrame.h"

@implementation WJUserInfoListCel

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {

        self.contentView.backgroundColor =kMSCellBackColor;

        _nameLabel = [[UILabel alloc] init];
        _nameLabel.textColor = [UIColor blackColor];
        _nameLabel.textAlignment = NSTextAlignmentLeft;
        [self.contentView addSubview:_nameLabel];

        _contentLabel = [[UILabel alloc] init];
        _contentLabel.font = PFR14Font;
        _contentLabel.textColor = [RegularExpressionsMethod ColorWithHexString:BASEBLACKCOLOR];
        _contentLabel.textAlignment = NSTextAlignmentRight;
        [self.contentView addSubview:_contentLabel];
        
        _actionImageView = [[UIImageView alloc] init];
        _actionImageView.image = [UIImage imageNamed:@"home_more"];
        _actionImageView.contentMode = UIViewContentModeScaleAspectFit;
        [self.contentView addSubview:_actionImageView];

        _lineImageView = [[UIImageView alloc] init];
        _lineImageView.backgroundColor = [[UIColor lightGrayColor]colorWithAlphaComponent:0.15];
        [self.contentView addSubview:_lineImageView];

    }
    return self;
}

#pragma mark - 布局
- (void)layoutSubviews
{
    [super layoutSubviews];
    [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        [make.left.mas_equalTo(self.contentView.mas_left)setOffset:10];
        make.centerY.mas_equalTo(self.contentView.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(200, 28));

    }];

    [_contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        if (_actionImageView.hidden) {
            [make.right.mas_equalTo(self.contentView.mas_right)setOffset:-20];
        }
        else
        {
         [make.right.mas_equalTo(self.contentView.mas_right)setOffset:-35];
        }
        make.centerY.mas_equalTo(self.contentView.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(150, 28));
    }];

    [_actionImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        [make.left.mas_equalTo(self.contentView.mas_right)setOffset:-20];
        make.centerY.mas_equalTo(self.contentView.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(6, 10));
    }];
    [_lineImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        [make.bottom.mas_equalTo(self.contentView.mas_bottom)setOffset:-1];
        make.centerX.mas_equalTo(self.contentView.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(self.contentView.width-20, 2));
    }];
}


@end
