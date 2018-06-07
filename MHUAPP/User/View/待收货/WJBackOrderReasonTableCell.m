//
//  WJBackOrderReasonTableCell.m
//  MHUAPP
//
//  Created by jinri on 2018/6/5.
//  Copyright © 2018年 wenchengjun. All rights reserved.
//

#import "WJBackOrderReasonTableCell.h"

@implementation WJBackOrderReasonTableCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = kMSCellBackColor;
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self setupUI];
    }
    return self;
}

- (void)setupUI {

    UIImageView *line = ImageViewInit(0, 0, kMSScreenWith, 1);
    line.backgroundColor = [[UIColor lightGrayColor]colorWithAlphaComponent:0.4];
    [self.contentView addSubview:line];

     _button = ImageViewInit(10, 8, 24, 24) ;
    _button.image = [UIImage imageNamed:@"user_weigouxuan"];
    [self.contentView addSubview:_button];

    UILabel *label = [[UILabel alloc]init];
    label.frame = CGRectMake(40, 5, kMSScreenWith - 100, 30);
    label.font = [UIFont systemFontOfSize:14];
    [self.contentView addSubview:label];
    self.titleLabel = label;

}




- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
