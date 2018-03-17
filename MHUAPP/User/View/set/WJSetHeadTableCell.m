//
//  WJSetHeadTableCell.m
//  MHUAPP
//
//  Created by jinri on 2017/12/7.
//  Copyright © 2017年 wenchengjun. All rights reserved.
//

#import "WJSetHeadTableCell.h"
#import "UIView+UIViewFrame.h"

@implementation WJSetHeadTableCell

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
        _flowImageView = [[UIImageView alloc] init];
        _flowImageView.contentMode = UIViewContentModeScaleAspectFit;
        [self addSubview:_flowImageView];
        
        _nameLabel = [[UILabel alloc] init];
        _nameLabel.font = PFR16Font;
        _nameLabel.textColor = [RegularExpressionsMethod ColorWithHexString:BASEBLACKCOLOR];
        _nameLabel.textAlignment = NSTextAlignmentLeft;
        [self.contentView addSubview:_nameLabel];

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
    [_flowImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        [make.left.mas_equalTo(self)setOffset:18];
        make.centerY.mas_equalTo(self.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(22, 22));

    }];
    [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        [make.left.mas_equalTo(_flowImageView.mas_right)setOffset:15];
        make.centerY.mas_equalTo(self.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(200, 20));
    }];
    [_actionImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        [make.left.mas_equalTo(self.contentView.mas_right)setOffset:-20];
        make.centerY.mas_equalTo(self.contentView.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(6, 10));
    }];
    [_lineImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.contentView.mas_bottom);
        make.centerX.mas_equalTo(self.contentView.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(self.contentView.width-20, 1));
    }];
}

#pragma mark - Setter Getter Methods
- (void)setFlowItem:(WJFlowItem *)flowItem
{
    _flowItem = flowItem;

    _flowImageView.image = [UIImage imageNamed:_flowItem.flowImageView];
    _nameLabel.text = _flowItem.flow_title;
}


@end
