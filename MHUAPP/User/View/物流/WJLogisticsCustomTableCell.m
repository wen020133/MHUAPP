//
//  WJLogisticsCustomTableCell.m
//  MHUAPP
//
//  Created by jinri on 2018/5/8.
//  Copyright © 2018年 wenchengjun. All rights reserved.
//

#import "WJLogisticsCustomTableCell.h"
#import "WJLogisticsCustomCellContentView.h"


@interface WJLogisticsCustomTableCell ()

@property (nonatomic, strong) WJLogisticsCustomCellContentView *customView;

@end

@implementation WJLogisticsCustomTableCell


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self creatSubViewUI];
    }
    return self;
}
- (void)setHasUpLine:(BOOL)hasUpLine {

    self.customView.hasUpLine = hasUpLine;
}

- (void)setHasDownLine:(BOOL)hasDownLine {

    self.customView.hasDownLine = hasDownLine;
}

- (void)setCurrented:(BOOL)currented {

    self.customView.currented = currented;
}
-(void)reloadDataWithModel:(WJLogisticsModel *)model
{
    [self.customView reloadDataWithModel:model];
}

- (void)creatSubViewUI
{
    WJLogisticsCustomCellContentView *custom = [[WJLogisticsCustomCellContentView alloc]init];
    [self addSubview:custom];
    self.customView = custom;

    custom.currented = NO;
    custom.hasUpLine = YES;
    custom.hasDownLine = YES;
    [custom mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self);
    }];
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
