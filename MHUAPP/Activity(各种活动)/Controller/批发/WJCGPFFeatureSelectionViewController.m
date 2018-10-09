//
//  WJCGPFFeatureSelectionViewController.m
//  MHUAPP
//
//  Created by jinri on 2018/10/8.
//  Copyright © 2018年 wenchengjun. All rights reserved.
//

#import "WJCGPFFeatureSelectionViewController.h"
#import "WJCGPFFeatureTopCell.h"
#import "WJFeatureList.h"
#import "WJCGPFfeatureListCell.h"
#import "WJCGPFHeaderFeatureView.h"


#import <MJExtension.h>
#import <SVProgressHUD.h>
#import <UIImageView+WebCache.h>
#import "UIViewController+XWTransition.h"
#import "UIView+UIViewFrame.h"


#define NowScreenH kMSScreenHeight * 0.8

@interface WJCGPFFeatureSelectionViewController ()<UITableViewDelegate,UITableViewDataSource>

/* tableView */
@property (strong , nonatomic)UITableView *tableView;
/* 数据 */
@property (strong , nonatomic) NSMutableArray <WJFeatureList *>  *featureAttr;

/* 选择数量 */
@property (strong , nonatomic) UILabel *lab_numAndPrice;

@end

static NSInteger num_;

@implementation WJCGPFFeatureSelectionViewController


- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.scrollEnabled = NO;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [self.tableView registerClass:[WJCGPFHeaderFeatureView class] forHeaderFooterViewReuseIdentifier:@"WJCGPFHeaderFeatureView"];
        [self.view addSubview:_tableView];
    }
    return _tableView;
}
- (void)viewDidLoad {
    [super viewDidLoad];

    [self setUpFeatureAlterView];

    [self setUpBase];

    [self setUpBottonView];
    // Do any additional setup after loading the view.
}

#pragma mark - initialize
- (void)setUpBase
{
    self.view.backgroundColor = [UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets = NO;
    _featureAttr = [WJFeatureList mj_objectArrayWithKeyValuesArray:self.arr_fuckData];
    self.tableView.frame = CGRectMake(0, 0, kMSScreenWith, NowScreenH-100);
}

#pragma mark - 底部按钮
- (void)setUpBottonView
{
    self.lab_numAndPrice = LabelInit(DCMargin,NowScreenH-80, kMSScreenWith-DCMargin*2, 20);
    self.lab_numAndPrice.backgroundColor = kMSCellBackColor;
    self.lab_numAndPrice.font = Font(14);
    self.lab_numAndPrice.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:self.lab_numAndPrice];

    NSMutableArray *titles = [NSMutableArray array];
    titles = [NSMutableArray arrayWithObjects:@"立即购买", nil];

    CGFloat buttonH = 50;
    CGFloat buttonW = kMSScreenWith / titles.count;
    CGFloat buttonY = NowScreenH - buttonH;
    for (NSInteger i = 0; i < titles.count; i++) {
        UIButton *buttton = [UIButton buttonWithType:UIButtonTypeCustom];
        [buttton setTitle:titles[i] forState:0];
        buttton.backgroundColor = (i == 0) ? [UIColor redColor] : [UIColor orangeColor];
        CGFloat buttonX = buttonW * i;
        buttton.tag = i;
        buttton.frame = CGRectMake(buttonX, buttonY, buttonW, buttonH);
        [self.view addSubview:buttton];
        [buttton addTarget:self action:@selector(buttomButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    }


}

#pragma mark - 底部按钮点击
- (void)buttomButtonClick:(UIButton *)button
{

    [SVProgressHUD showInfoWithStatus:@"请选择全属性"];
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
    [SVProgressHUD dismissWithDelay:1.0];

    [self dismissFeatureViewControllerWithTag:button.tag];

}

#pragma mark - 弹出弹框
- (void)setUpFeatureAlterView
{
    XWInteractiveTransitionGestureDirection direction = XWInteractiveTransitionGestureDirectionDown;
    WEAKSELF
    [self xw_registerBackInteractiveTransitionWithDirection:direction transitonBlock:^(CGPoint startPoint){
        [weakSelf dismissViewControllerAnimated:YES completion:^{
            [weakSelf dismissFeatureViewControllerWithTag:100];
        }];
    } edgeSpacing:0];
}

#pragma mark - <UITableViewDataSource>
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section==0) {
        return 1;
    }
    else
    return _featureAttr.count;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    WJCGPFHeaderFeatureView *view = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"WJCGPFHeaderFeatureView"];
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {

    return 44;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section==0)
    {
     WJCGPFFeatureTopCell *cell = [tableView dequeueReusableCellWithIdentifier:@"WJCGPFFeatureTopCell" forIndexPath:indexPath];
        if (cell == nil) {
            cell = [[WJCGPFFeatureTopCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"WJCGPFFeatureTopCell"];
        }
        cell.titleLabel.text = [NSString stringWithFormat:@"%@",_goods_name];
        cell.goodPriceLabel.text = [NSString stringWithFormat:@"¥ %.2f~¥ %.2f",[self.offer_price_three floatValue],[self.offer_price_one floatValue]];

        [cell.goodImageView sd_setImageWithURL:[NSURL URLWithString:_goodImageView]];
        WEAKSELF
        cell.crossButtonClickBlock = ^{
            [weakSelf dismissFeatureViewControllerWithTag:100];
        };
        return cell;
    }
    else
    {
        WJCGPFfeatureListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"WJCGPFfeatureListCell" forIndexPath:indexPath];
        if (cell == nil) {
            cell = [[WJCGPFfeatureListCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"WJCGPFfeatureListCell"];
        }

        return cell;
    }

}

#pragma mark - 退出当前界面
- (void)dismissFeatureViewControllerWithTag:(NSInteger)tag
{

    WEAKSELF
    [weakSelf dismissViewControllerAnimated:YES completion:^{

    }];
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
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
