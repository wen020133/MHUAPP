//
//  WJXSZKAllMainHeadView.m
//  MHUAPP
//
//  Created by jinri on 2018/9/30.
//  Copyright © 2018年 wenchengjun. All rights reserved.
//

#import "WJXSZKAllMainHeadView.h"
#import "UIView+UIViewFrame.h"

@implementation WJXSZKAllMainHeadView

#pragma mark - Intial
- (instancetype)initWithFrame:(CGRect)frame {

    self = [super initWithFrame:frame];
    if (self) {
        //        self.secondsCountDown = 3600;
        [self setUpUI];
    }
    return self;
}

- (void)setUpUI
{
    self.backgroundColor = [UIColor whiteColor];

    _img_content  = ImageViewInit(0, 0, kMSScreenWith, 120);
    _img_content.image = [UIImage imageNamed:@"main_sspt_haowuyiqipin.jpg"];
    [self addSubview:_img_content];


    UILabel *line = LabelInit(DCMargin, 134, 2, 14);
    line.backgroundColor = [UIColor blackColor];
    [self addSubview:line];

    UILabel *messLabel = LabelInit(15, 131, 120, 20);
    messLabel.font = PFR14Font;
    messLabel.textColor = [RegularExpressionsMethod ColorWithHexString:BASEBLACKCOLOR];
    messLabel.text = @"限时折扣,疯狂低价";
    messLabel.textAlignment = NSTextAlignmentLeft;
    [self addSubview:messLabel];

    //加上 搜索栏
    self.searchBar = [[HXSearchBar alloc] initWithFrame:CGRectMake(140, 127, kMSScreenWith -145, 30)];
    self.searchBar.backgroundColor = [UIColor whiteColor];
    //输入框提示
    self.searchBar.hideSearchBarBackgroundImage = YES;
    self.searchBar.searchBarTextField.placeholder = @"大家都在搜:";
    //光标颜色
    self.searchBar.cursorColor = [UIColor redColor];
    self.searchBar.delegate = self;
    //TextField
    self.searchBar.searchBarTextField.layer.cornerRadius = 20;
    self.searchBar.searchBarTextField.layer.masksToBounds = YES;
    self.searchBar.searchBarTextField.backgroundColor  = [RegularExpressionsMethod ColorWithHexString:@"faf5f5"];
    self.searchBar.searchBarTextField.font = Font(14);

    if (@available(iOS 11.0, *))
    {
        [self.searchBar.heightAnchor constraintLessThanOrEqualToConstant:kEVNScreenNavigationBarHeight].active = YES;
    }
    else
    {

    }
    [self addSubview: self.searchBar];

    UIImageView *line3 = ImageViewInit(0, 163, kMSScreenWith, 1);
    line3.backgroundColor = [RegularExpressionsMethod ColorWithHexString:@"E6E6E6"];
    [self addSubview:line3];
}

//编辑文字改变的回调
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    NSLog(@"searchText:%@",searchText);
    if (searchText.length==0) {
        !_userChickSearch ? : _userChickSearch(@"");
        [self.searchBar resignFirstResponder];
    }

}
//搜索按钮
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    NSLog(@"searchText开始了");
    !_userChickSearch ? : _userChickSearch(searchBar.text);
    [searchBar resignFirstResponder];
}


@end
