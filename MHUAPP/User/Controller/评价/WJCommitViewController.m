//
//  WJCommitViewController.m
//  MHUAPP
//
//  Created by jinri on 2018/6/8.
//  Copyright © 2018年 wenchengjun. All rights reserved.
//

#import "WJCommitViewController.h"
#define kMaxTextCount 300
#import "CWStarRateView.h"
#import "UIView+UIViewFrame.h"


@interface WJCommitViewController ()<UITextViewDelegate,UIScrollViewDelegate,CWStarRateViewDelegate>
{
    //备注文本View高度
    float noteTextHeight;
    float pickerViewHeight;
    float allViewHeight;
}
@property (strong, nonatomic) NSArray *arr_Type;
@property (strong, nonatomic)  UIScrollView *mianScrollView;
//备注
@property(nonatomic,strong) UITextView *noteTextView;
//文字个数提示label
@property(nonatomic,strong) UILabel *textNumberLabel;
//提交按钮
@property(nonatomic,strong) UIButton *submitBtn;

//五星好评
@property (nonatomic,strong) CWStarRateView *star_miaosu;
@property (nonatomic,strong) CWStarRateView *star_wuliu;
@property (nonatomic,strong) CWStarRateView *star_fuwu;
@property (nonatomic,strong) UILabel *lab_miaosu;
@property (nonatomic,strong) UILabel *lab_wuliu;
@property (nonatomic,strong) UILabel *lab_fuwu;
@property (nonatomic,strong) UIView *view_star;

//匿名
@property (nonatomic,strong) UIView *view_niming;


//商品评价
@property (nonatomic,strong) NSString *comment_rank;

//描述分数
@property (nonatomic,strong) NSString *str_miaosuNum;
//物流分数
@property (nonatomic,strong) NSString *str_wuliuNum;
//服务分数
@property (nonatomic,strong) NSString *str_fuwuNum;
@property (nonatomic,strong) NSString *hide_username;
@end

@implementation WJCommitViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [RegularExpressionsMethod ColorWithHexString:kMSVCBackgroundColor];
    [self initSendReplyWithTitle:@"评价" andLeftButtonName:@"ic_back.png" andRightButtonName:nil andTitleLeftOrRight:YES];

    self.arr_Type = [NSArray arrayWithObjects:@" 桑身",@" 一般",@" 灰常棒",nil];
    [self.view addSubview:self.mianScrollView];
    noteTextHeight = 100;
    self.showInView = _mianScrollView;
    [self initViews];

    _hide_username = @"0";
    // Do any additional setup after loading the view.
}
- (void)viewTapped{
    [self.view endEditing:YES];
}
- (UIScrollView *)mianScrollView {
    if (!_mianScrollView) {
        _mianScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, kMSScreenWith, kMSScreenHeight-kMSNaviHight)];
        _mianScrollView.backgroundColor =  self.view.backgroundColor;
        _mianScrollView.pagingEnabled = YES;
        _mianScrollView.showsVerticalScrollIndicator = NO;
        _mianScrollView.showsHorizontalScrollIndicator = NO;
        _mianScrollView.delegate = self;

    }
    return _mianScrollView;
}



- (void)initViews{

    _menu_ScrollView = [[MunuView alloc]initWithFrame:CGRectMake(0, 0, kMSScreenWith, 49) withTitles:self.arr_Type];
    _menu_ScrollView.delegate = self;
    [_mianScrollView addSubview:_menu_ScrollView];
    _menu_ScrollView.selectIndex = 3;



    UIImageView *backWh = ImageViewInit(0, 49, kMSScreenWith, 200);
    backWh.backgroundColor = kMSCellBackColor;
    [_mianScrollView addSubview:backWh];

    UIImageView *line = ImageViewInit(15, 49, kMSScreenWith-15, 1);
    line.backgroundColor = [RegularExpressionsMethod ColorWithHexString:@"E6E6E6"];
    [_mianScrollView addSubview:line];

    //文本输入框
    _noteTextView = [[UITextView alloc]init];
    _noteTextView.keyboardType = UIKeyboardTypeDefault;
    _noteTextView.font =Font(14);
    [_noteTextView setTextColor:[RegularExpressionsMethod ColorWithHexString:BASEBLACKCOLOR]];
    _noteTextView.text = @"商品符合您预期吗？说说您的感受呗……";
    _noteTextView.delegate = self;

    _textNumberLabel = [[UILabel alloc]init];
    _textNumberLabel.textAlignment = NSTextAlignmentRight;
    _textNumberLabel.font = [UIFont boldSystemFontOfSize:12];
    _textNumberLabel.textColor = [UIColor colorWithRed:153.0/255.0 green:153.0/255.0 blue:153.0/255.0 alpha:1.0];
    _textNumberLabel.backgroundColor = [UIColor whiteColor];
    _textNumberLabel.text = [NSString stringWithFormat:@"0/%d    ",kMaxTextCount];

    [self initPickerView];

    _view_niming = [[UIView alloc]init];
    _view_niming.tag = 1000;
    _view_niming.backgroundColor = kMSCellBackColor;

    UIImageView *line1 = ImageViewInit(15, 0, kMSScreenWith-15, 1);
    line1.backgroundColor = [RegularExpressionsMethod ColorWithHexString:@"E6E6E6"];
    [_view_niming addSubview:line1];

    //全选按钮
    UIButton *selectAll = [UIButton buttonWithType:UIButtonTypeCustom];
    selectAll.titleLabel.font = [UIFont systemFontOfSize:16];
    selectAll.frame = CGRectMake(15, 5, 120, 49 - 10);
    [selectAll setTitle:@" 匿名评论" forState:UIControlStateNormal];
    [selectAll setImage:[UIImage imageNamed:@"user_weigouxuan"] forState:UIControlStateNormal];
    [selectAll setImage:[UIImage imageNamed:@"shipcart_seleHigh"] forState:UIControlStateSelected];
    [selectAll setTitleColor:[RegularExpressionsMethod ColorWithHexString:BASELITTLEBLACKCOLOR] forState:UIControlStateNormal];
    [selectAll addTarget:self action:@selector(selectNimingBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [_view_niming addSubview:selectAll];


    _view_star = [[UIView alloc]init];
    _view_star.backgroundColor = self.view.backgroundColor;



    UILabel *labMiaos = LabelInit(15, 25, 60, 20);
    labMiaos.text = @"描述相符";
    labMiaos.textColor = [RegularExpressionsMethod ColorWithHexString:BASELITTLEBLACKCOLOR];
    labMiaos.font = Font(14);
    [_view_star addSubview:labMiaos];

     _star_miaosu=[[CWStarRateView alloc]initWithFrame:CGRectMake(labMiaos.Right+20, 20, kMSScreenWith-190, 30) numberOfStars:5];
    _star_miaosu.delegate = self;
    [_view_star addSubview:_star_miaosu];

    _lab_miaosu = LabelInit(_star_miaosu.Right+20, 25, 60, 20);
    _lab_miaosu.textColor = [RegularExpressionsMethod ColorWithHexString:BASEBLACKCOLOR];
     _lab_miaosu.text = @"5.0分";
    _lab_miaosu.font = Font(15);
    [_view_star addSubview:_lab_miaosu];
    _str_miaosuNum = @"5";
    UILabel *labwuliu = LabelInit(15, 80, 60, 20);
    labwuliu.text = @"物流服务";
    labwuliu.textColor = [RegularExpressionsMethod ColorWithHexString:BASELITTLEBLACKCOLOR];
    labwuliu.font = Font(14);
    [_view_star addSubview:labwuliu];

    _star_wuliu=[[CWStarRateView alloc]initWithFrame:CGRectMake(labwuliu.Right+20, 75, kMSScreenWith-190, 30)numberOfStars:5];
    _star_wuliu.delegate = self;
    [_view_star addSubview:_star_wuliu];

    _lab_wuliu = LabelInit(_star_wuliu.Right+20, 80, 60, 20);
    _lab_wuliu.textColor = [RegularExpressionsMethod ColorWithHexString:BASEBLACKCOLOR];
    _lab_wuliu.font = Font(15);
    _lab_wuliu.text = @"5.0分";
    [_view_star addSubview:_lab_wuliu];
    _str_wuliuNum = @"5";
    
    UILabel *labfuwu = LabelInit(15, 135, 60, 20);
    labfuwu.text = @"服务态度";
    labfuwu.textColor = [RegularExpressionsMethod ColorWithHexString:BASELITTLEBLACKCOLOR];
    labfuwu.font = Font(14);
    [_view_star addSubview:labfuwu];

    _star_fuwu=[[CWStarRateView alloc]initWithFrame:CGRectMake(labMiaos.Right+20, 130, kMSScreenWith-190, 30)numberOfStars:5];
    _star_fuwu.delegate = self;
    [_view_star addSubview:_star_fuwu];

    _lab_fuwu = LabelInit(_star_fuwu.Right+20, 135, 60, 20);
    _lab_fuwu.textColor = [RegularExpressionsMethod ColorWithHexString:BASEBLACKCOLOR];
    _lab_fuwu.font = Font(15);
    _lab_fuwu.text = @"5.0分";
    [_view_star addSubview:_lab_fuwu];
    _str_fuwuNum = @"5";
    
    //发布按钮样式->可自定义!
    _submitBtn = [[UIButton alloc]init];
    [_submitBtn setTitle:@"提交" forState:UIControlStateNormal];
    [_submitBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_submitBtn setBackgroundColor:[RegularExpressionsMethod ColorWithHexString:BASEPINK]];
    [_submitBtn.layer setCornerRadius:4.0f];
    [_submitBtn.layer setMasksToBounds:YES];
    [_submitBtn.layer setShouldRasterize:YES];
    [_submitBtn.layer setRasterizationScale:[UIScreen mainScreen].scale];

    [_submitBtn addTarget:self action:@selector(submitBtnClicked) forControlEvents:UIControlEventTouchUpInside];

    [_mianScrollView addSubview:_noteTextView];
    [_mianScrollView addSubview:_textNumberLabel];
    [_mianScrollView addSubview:_view_niming];
    [_mianScrollView addSubview:_view_star];
    [_mianScrollView addSubview:_submitBtn];

    [self updateViewsFrame];
}
- (void)updateViewsFrame{


    //文本编辑框
    _noteTextView.frame = CGRectMake(15, 50, kMSScreenWith - 30, noteTextHeight);

    //文字个数提示Label
    _textNumberLabel.frame = CGRectMake(0, _noteTextView.frame.origin.y + _noteTextView.frame.size.height-15, kMSScreenWith-15, 15);


    //photoPicker
    [self updatePickerViewFrameY:_textNumberLabel.frame.origin.y + _textNumberLabel.frame.size.height];

    _view_niming.frame = CGRectMake(0, [self getPickerViewFrame].origin.y+[self getPickerViewFrame].size.height, kMSScreenWith, 49);

    //五星好评控件
    _view_star.frame = CGRectMake(0, _view_niming.Bottom+10, kMSScreenWith, 180);

    //发布按钮
    _submitBtn.bounds = CGRectMake(10, _view_star.frame.origin.y+_view_star.frame.size.height +30, kMSScreenWith -20, 40);
    _submitBtn.frame = CGRectMake(10, _view_star.frame.origin.y+_view_star.frame.size.height +30, kMSScreenWith -20, 40);


    allViewHeight = noteTextHeight + [self getPickerViewFrame].size.height + 410;

    _mianScrollView.contentSize = CGSizeMake(0,allViewHeight);
}
-(void)selectNimingBtnClick:(UIButton *)sender
{
    [self.noteTextView resignFirstResponder];
    sender.selected = !sender.selected;
    if (sender.selected) {
        _hide_username = @"1";
    }
    else
        _hide_username = @"0";
}

- (void)didSelectedButtonWithTag:(NSInteger)currTag
{
    [self.noteTextView resignFirstResponder];
    switch (currTag) {
        case 0:
            _comment_rank = @"1";
            break;
        case 1:
            _comment_rank = @"3";
            break;
        case 2:
            _comment_rank = @"5";
            break;
        default:
            break;
    }
}

- (void)starRateView:(CWStarRateView *)starRateView scroePercentDidChange:(CGFloat)newScorePercent
{
    if (starRateView==_star_miaosu) {
        _lab_miaosu.text = [NSString stringWithFormat:@"%.1f分",newScorePercent*5];
        _str_miaosuNum = [NSString stringWithFormat:@"%.f",newScorePercent*5];
    }
    else if (starRateView==_star_fuwu) {
        _lab_fuwu.text = [NSString stringWithFormat:@"%.1f分",newScorePercent*5];
        _str_fuwuNum = [NSString stringWithFormat:@"%.f",newScorePercent*5];
    }
    else if (starRateView==_star_wuliu) {
        _lab_wuliu.text = [NSString stringWithFormat:@"%.1f分",newScorePercent*5];
        _str_wuliuNum = [NSString stringWithFormat:@"%.f",newScorePercent*5];
    }

}
- (void)pickerViewFrameChanged{
    [self updateViewsFrame];
}

#pragma mark - UITextViewDelegate
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{

    NSLog(@"当前输入框文字个数:%ld",_noteTextView.text.length);
    //当前输入字数
    _textNumberLabel.text = [NSString stringWithFormat:@"%lu/%d    ",(unsigned long)_noteTextView.text.length,kMaxTextCount];
    if (_noteTextView.text.length > kMaxTextCount) {
        _textNumberLabel.textColor = [UIColor redColor];
    }else{
        _textNumberLabel.textColor = [UIColor colorWithRed:153.0/255.0 green:153.0/255.0 blue:153.0/255.0 alpha:1.0];
    }

    [self textChanged];
    return YES;
}

//文本框每次输入文字都会调用  -> 更改文字个数提示框
- (void)textViewDidChangeSelection:(UITextView *)textView{

    NSLog(@"当前输入框文字个数:%ld",_noteTextView.text.length);
    //
    _textNumberLabel.text = [NSString stringWithFormat:@"%lu/%d    ",(unsigned long)_noteTextView.text.length,kMaxTextCount];
    if (_noteTextView.text.length > kMaxTextCount) {
        _textNumberLabel.textColor = [UIColor redColor];
    }
    else{
        _textNumberLabel.textColor = [UIColor colorWithRed:153.0/255.0 green:153.0/255.0 blue:153.0/255.0 alpha:1.0];
    }
    [self textChanged];
}

/**
 *  文本高度自适应
 */
-(void)textChanged{

    CGRect orgRect = self.noteTextView.frame;//获取原始UITextView的frame

    //获取尺寸
    CGSize size = [self.noteTextView sizeThatFits:CGSizeMake(self.noteTextView.frame.size.width, MAXFLOAT)];

    orgRect.size.height=size.height+10;//获取自适应文本内容高度


    //如果文本框没字了恢复初始尺寸
    if (orgRect.size.height > 100) {
        noteTextHeight = orgRect.size.height;
    }else{
        noteTextHeight = 100;
    }

    [self updateViewsFrame];
}

/**
 *  发布按钮点击事件
 */
- (void)submitBtnClicked{
    [self.noteTextView resignFirstResponder];
    //检查输入
    if (![self checkInput]) {
        return;
    }
    //输入正确将数据上传服务器->
    [self submitToServer];
}

#pragma maek - 检查输入
- (BOOL)checkInput{
    //文本框没字
    if (_noteTextView.text.length == 0) {
        NSLog(@"文本框没字");
        //MBhudText(self.view, @"请添加记录备注", 1);
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:@"请输入文字" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *actionCacel = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:nil];
        [alertController addAction:actionCacel];
        [self presentViewController:alertController animated:YES completion:nil];

        return NO;
    }

    //文本框字数超过300
    if (_noteTextView.text.length > kMaxTextCount) {
        NSLog(@"文本框字数超过300");
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:@"超出文字限制" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *actionCacel = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:nil];
        [alertController addAction:actionCacel];
        [self presentViewController:alertController animated:YES completion:nil];
        return NO;
    }
    return YES;
}

- (void)submitToServer{

    if (_noteTextView.text.length<1||[_noteTextView.text isEqualToString:@"商品符合您预期吗？说说您的感受呗……"]) {
        [self requestFailed:@"请填写评价内容！"];
        return;
    }
    if (_comment_rank.length<1) {
        [self requestFailed:@"请给商品打分！"];
        return;
    }

    // 可以选择上传大图数据或者小图数据->

//
//    //小图数组
//    NSArray *smallImageArray = self.imageArray;

    //小图二进制数据
    NSMutableArray *smallImageDataArray = [NSMutableArray array];

    for (UIImage *smallImg in self.bigImageArray) {
         NSData *data = [self resetSizeOfImageData:smallImg maxSize:256]; ;
        [smallImageDataArray addObject:data];
    }
    NSLog(@"上传服务器... +++ 文本内容:%@",_noteTextView.text);
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSString *str_username = [[userDefaults objectForKey:@"userList"] objectForKey:@"username"];

    NSMutableDictionary *infos = [NSMutableDictionary dictionary];
    [infos setValue:_goods_id forKey:@"goods_id"];
    [infos setValue:[AppDelegate shareAppDelegate].user_id forKey:@"user_id"];
    [infos setValue:_rec_id forKey:@"rec_id"];
    [infos setValue:str_username forKey:@"user_name"];
    [infos setValue:_comment_rank forKey:@"comment_rank"];
    [infos setValue:_noteTextView.text forKey:@"content"];
    [infos setValue:_hide_username forKey:@"hide_username"];
    [infos setValue:_str_miaosuNum forKey:@"debe_comm"];
    [infos setValue:_str_wuliuNum forKey:@"lot_serve"];
    [infos setValue:_str_fuwuNum forKey:@"serve_att"];
    [self requestAPIWithServe:[kMSBaseMiYoMeiPortURL stringByAppendingString:kMSAddComment] andInfos:infos andImageDataArr:smallImageDataArray andImageName:@"array_file"];
}

-(void)processData
{
    if([[self.results objectForKey:@"code"] integerValue] == 200)
    {
        [self jxt_showAlertWithTitle:@"消息提示" message:@"发表评论成功！" appearanceProcess:^(JXTAlertController * _Nonnull alertMaker) {
            alertMaker.
            addActionCancelTitle(@"确定");
        } actionsBlock:^(NSInteger buttonIndex, UIAlertAction * _Nonnull action, JXTAlertController * _Nonnull alertSelf) {
            if (buttonIndex == 0) {
                [self.navigationController popViewControllerAnimated:YES];
            }

        }];

    }
    else
    {
        [SVProgressHUD showErrorWithStatus:[self
                                            .results objectForKey:@"msg"]];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    NSLog(@"内存警告...");
}
- (void)showleft {
    NSLog(@"取消");
    [self.noteTextView resignFirstResponder];
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *actionCacel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    UIAlertAction *actionGiveUpCommit = [UIAlertAction actionWithTitle:@"放弃上传" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        [self.navigationController popViewControllerAnimated:YES];
    }];
    [alertController addAction:actionCacel];
    [alertController addAction:actionGiveUpCommit];
    [self presentViewController:alertController animated:YES completion:nil];
}

#pragma mark - UIScrollViewDelegate
//用户向上偏移到顶端取消输入,增强用户体验
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{

    //    NSLog(@"偏移量 scrollView.contentOffset.y:%f",scrollView.contentOffset.y);
    if (scrollView.contentOffset.y < 0) {
        [self.view endEditing:YES];
    }
}
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self.noteTextView resignFirstResponder];
}
- (BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
    if([textView.text isEqualToString:@"商品符合您预期吗？说说您的感受呗……"])
    {
        textView.text = @"";
    }
    return YES;
}
- (void)textViewDidEndEditing:(UITextView *)textView;
{
    if ([textView.text isEqualToString:@""]) {
        textView.text = @"商品符合您预期吗？说说您的感受呗……";
    }
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
