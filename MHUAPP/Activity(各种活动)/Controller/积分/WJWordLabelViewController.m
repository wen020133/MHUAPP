//
//  WJWordLabelViewController.m
//  MHUAPP
//
//  Created by wenchengjun on 2018/6/13.
//  Copyright © 2018年 wenchengjun. All rights reserved.
//

#import "WJWordLabelViewController.h"

@interface WJWordLabelViewController ()

@property (strong,nonatomic) UITextView *text_contentView;
@end

@implementation WJWordLabelViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [RegularExpressionsMethod ColorWithHexString:kMSVCBackgroundColor];
    [self initSendReplyWithTitle:self.str_title andLeftButtonName:@"ic_back.png" andRightButtonName:nil andTitleLeftOrRight:NO];
    _text_contentView = [[UITextView alloc]initWithFrame:CGRectMake(DCMargin, DCMargin, kMSScreenWith-DCMargin*2, kMSScreenHeight-kMSNaviHight-DCMargin*2)];
    _text_contentView.editable = NO;
    _text_contentView.textColor = [RegularExpressionsMethod ColorWithHexString:BASEBLACKCOLOR];
    _text_contentView.font = Font(15);
    if ([_str_title isEqualToString:@"会员协议"]) {
        NSString *hptxtStr = [[NSString alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"RigisterDelegate" ofType:@"txt"] encoding:NSUTF8StringEncoding error:nil];
        _text_contentView.text = hptxtStr;
    }
    else
    {
        _text_contentView.text = _str_content;
    }
    [self.view addSubview:_text_contentView];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
