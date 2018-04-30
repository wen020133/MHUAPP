//
//  WJGoodDetailViewController.m
//  MHUAPP
//
//  Created by jinri on 2017/12/4.
//  Copyright © 2017年 wenchengjun. All rights reserved.
//

#import "WJGoodDetailViewController.h"

#import "WJGoodBaseViewController.h"
#import "WJGoodParticularsViewController.h"
#import "WJGoodCommentViewController.h"

#import "UIView+UIViewFrame.h"
#import "WJToolsViewController.h"
#import "XWDrawerAnimator.h"
#import "UIViewController+XWTransition.h"
#import "WJShopCartClassViewController.h"

#import "PST_MenuView.h"

#import "WJDetailPartCommentItem.h"

@interface WJGoodDetailViewController ()<PST_MenuViewDelegate>

@property (strong, nonatomic) UIScrollView *scrollerView;
@property (strong, nonatomic) UIView *bgView;
/** 记录上一次选中的Button */
@property (nonatomic , weak) UIButton *selectBtn;
/* 标题按钮地下的指示器 */
@property (weak ,nonatomic) UIView *indicatorView;
/* 通知 */
@property (weak ,nonatomic) id dcObserve;

/** 右侧下拉框图片数组 */
@property(nonatomic,strong)NSArray *imgArr;
/** 右侧下拉框文字数组 */
@property(nonatomic,strong)NSArray *titleArr;

@end

@implementation WJGoodDetailViewController

#pragma mark - LifeCyle
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:animated];
}

- (void)viewDidLoad {

    [super viewDidLoad];
    
    [self setUpInit];

    [self setUpNav];

    [self setUpTopButtonView];

    [self getGoodsInfoItem];

    [self setUpBottomButton];

    [self acceptanceNote];

    // Do any additional setup after loading the view.
}

-(void)getGoodsInfoItem
{
    _serverType = 1;
    [self requestGetAPIWithServe:[NSString stringWithFormat:@"%@/%@/%@?id=%@",kMSBaseMiYoMeiPortURL,kMSappVersionCode,kMSGetDetailed,_goods_id]];
}

-(void)setkMSGetComment
{
    _serverType = 2;
    [self requestGetAPIWithServe:[NSString stringWithFormat:@"%@/%@/%@/%@",kMSBaseMiYoMeiPortURL,kMSappVersionCode,kMSGetComment,_goods_id]];
}
-(void)getProcessData
{
    if([[self.results objectForKey:@"code"] integerValue] == 200)
    {

        switch (_serverType) {
            case KGetshopInfoClass:
            {
                _goodTitle = self.results[@"data"][@"goods_name"];
                _goodPrice = self.results[@"data"][@"shop_price"];
                _oldPrice = self.results[@"data"][@"market_price"];
                _goodImageView = self.results[@"data"][@"goods_thumb"];
                _shufflingArray = self.results[@"data"][@"gallery"];
                _attributeArray = self.results[@"data"][@"attr"];
//                self.galleryArray = self.results[@"data"][@"gallery"];
                _supplier_id = self.results[@"data"][@"supplier_id"];
                [self setkMSGetComment];
                 [self setUpChildViewControllers];
                 [self addChildViewController];

            }
                break;
            case KGetComment:
            {

                NSMutableArray *arr_Datalist = [NSMutableArray array];
                arr_Datalist = [self.results objectForKey:@"data"];
                if (![arr_Datalist isEqual:[NSNull null]]) {
                    _attributeArray = arr_Datalist;
                }
            }
                break;
            default:
                break;
        }


    }
    else
    {
//        [SVProgressHUD showErrorWithStatus:[self.results objectForKey:@"msg"]];
        return;
    }
}



#pragma mark - LazyLoad
- (UIScrollView *)scrollerView
{
    if (!_scrollerView) {
        _scrollerView = [[UIScrollView alloc] initWithFrame:CGRectZero];
        _scrollerView.frame = self.view.bounds;
        _scrollerView.showsVerticalScrollIndicator = NO;
        _scrollerView.showsHorizontalScrollIndicator = NO;
        _scrollerView.pagingEnabled = YES;
        _scrollerView.bounces = NO;
        _scrollerView.delegate = self;
        [self.view addSubview:_scrollerView];
    }
    return _scrollerView;
}

#pragma mark - initialize
- (void)setUpInit
{
    self.view.backgroundColor = [UIColor whiteColor];
    self.scrollerView.backgroundColor = self.view.backgroundColor;
    self.scrollerView.contentSize = CGSizeMake(self.view.width * self.childViewControllers.count, 0);
    self.automaticallyAdjustsScrollViewInsets = NO;
}

#pragma mark - 接受通知
- (void)acceptanceNote
{

    //滚动到详情
    __weak typeof(self)weakSlef = self;
    _dcObserve = [[NSNotificationCenter defaultCenter]addObserverForName:@"scrollToDetailsPage" object:nil queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification * _Nonnull note) {
        [weakSlef topBottonClick:weakSlef.bgView.subviews[1]]; //跳转详情
    }];

    _dcObserve = [[NSNotificationCenter defaultCenter]addObserverForName:@"scrollToCommentsPage" object:nil queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification * _Nonnull note) {
        [weakSlef topBottonClick:weakSlef.bgView.subviews[2]]; //跳转到评论界面
    }];
}

#pragma mark - 点击事件
#pragma mark - 头部按钮点击
- (void)topBottonClick:(UIButton *)button
{
    button.selected = !button.selected;

    _selectBtn = button;

    WEAKSELF
    [UIView animateWithDuration:0.25 animations:^{
        weakSelf.indicatorView.width = button.titleLabel.width;
        weakSelf.indicatorView.dc_centerX = button.dc_centerX;
    }];

    CGPoint offset = _scrollerView.contentOffset;
    offset.x = _scrollerView.width * button.tag;
    [_scrollerView setContentOffset:offset animated:YES];
}

#pragma mark - 头部View
- (void)setUpTopButtonView
{
    NSArray *titles = @[@"商品",@"详情",@"评价"];
    CGFloat margin = 5;
    _bgView = [[UIView alloc] init];
    _bgView.dc_centerX = kMSScreenWith * 0.5;
    _bgView.height = 44;
    _bgView.width = (_bgView.height + margin) * titles.count;
    _bgView.y = 0;
    self.navigationItem.titleView = _bgView;

    CGFloat buttonW = _bgView.height;
    CGFloat buttonH = _bgView.height;
    CGFloat buttonY = _bgView.y;
    for (NSInteger i = 0; i < titles.count; i++) {

        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setTitle:titles[i] forState:0];
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        button.tag = i;
        button.titleLabel.font = PFR16Font;
        [button addTarget:self action:@selector(topBottonClick:) forControlEvents:UIControlEventTouchUpInside];
        CGFloat buttonX = i * (buttonW + margin);

        button.frame = CGRectMake(buttonX, buttonY, buttonW, buttonH);

        [_bgView addSubview:button];

    }

    UIButton *firstButton = _bgView.subviews[0];
    [self topBottonClick:firstButton]; //默认选择第一个

    UIView *indicatorView = [[UIView alloc]init];
    self.indicatorView = indicatorView;
    indicatorView.backgroundColor = [firstButton titleColorForState:UIControlStateSelected];

    indicatorView.height = 2;
    indicatorView.y = _bgView.height - indicatorView.height;

    [firstButton.titleLabel sizeToFit];
    indicatorView.width = firstButton.titleLabel.width;
    indicatorView.dc_centerX = firstButton.dc_centerX;

    [_bgView addSubview:indicatorView];

}

#pragma mark - 添加子控制器View
-(void)addChildViewController
{
    NSInteger index = _scrollerView.contentOffset.x / _scrollerView.width;
    UIViewController *childVc = self.childViewControllers[index];

    if (childVc.view.superview) return; //判断添加就不用再添加了
    childVc.view.frame = CGRectMake(index * _scrollerView.width, 0, _scrollerView.width, _scrollerView.height);
    [_scrollerView addSubview:childVc.view];

}

#pragma mark - 添加子控制器
-(void)setUpChildViewControllers
{
    WEAKSELF
    WJGoodBaseViewController *goodBaseVc = [[WJGoodBaseViewController alloc] init];
    goodBaseVc.goodTitle = _goodTitle;
    goodBaseVc.goodPrice = _goodPrice;
    goodBaseVc.goodSubtitle = _goodSubtitle;
    goodBaseVc.shufflingArray = _shufflingArray;
    goodBaseVc.oldPrice = _oldPrice;
    NSMutableArray *arr = [NSMutableArray array];
    if(_attributeArray&&_attributeArray.count>0)
    {
        NSDictionary *dic =[NSMutableDictionary dictionary];
        [dic setValue:@"产品属性" forKey:@"attrname"];
        [dic setValue:_attributeArray forKey:@"list"];
        [arr addObject:dic];
    }
//    if(self.galleryArray&&self.galleryArray.count>0)
//    {
//        NSDictionary *dic =[NSMutableDictionary dictionary];
//        [dic setValue:@"规格选择" forKey:@"attrname"];
//        [dic setValue:self.galleryArray forKey:@"list"];
//        [arr addObject:dic];
//    }
    goodBaseVc.attributeArray = arr;
    goodBaseVc.goodImageView = _goodImageView;
    goodBaseVc.goods_id = _goods_id;
    goodBaseVc.supplier_id = _supplier_id;
    goodBaseVc.commentArray = _getCommentArray;
    goodBaseVc.changeTitleBlock = ^(BOOL isChange) {
        if (isChange) {
            UIButton *firstButton = _bgView.subviews[1];
            [weakSelf topBottonClick:firstButton];
            weakSelf.scrollerView.contentSize = CGSizeMake(weakSelf.view.width, 0);
        }else{
            weakSelf.scrollerView.contentSize = CGSizeMake(weakSelf.view.width * weakSelf.childViewControllers.count, 0);
        }
    };
    [self addChildViewController:goodBaseVc];

    WJGoodParticularsViewController *goodParticularsVc = [[WJGoodParticularsViewController alloc] init];
    goodParticularsVc.goods_id = _goods_id;
    [self addChildViewController:goodParticularsVc];

    WJGoodCommentViewController *goodCommentVc = [[WJGoodCommentViewController alloc] init];
    [self addChildViewController:goodCommentVc];
}
#pragma mark - 底部按钮(收藏 购物车 加入购物车 立即购买)
- (void)setUpBottomButton
{
    [self setUpLeftTwoButton];//收藏 购物车

    [self setUpRightTwoButton];//加入购物车 立即购买
}
#pragma mark - 收藏 购物车
- (void)setUpLeftTwoButton
{
    NSArray *imagesNor = @[@"tabr_07shoucang_up",@"tabr_08gouwuche"];
    NSArray *imagesSel = @[@"tabr_07shoucang_down",@"tabr_08gouwuche"];
    CGFloat buttonW = kMSScreenWith * 0.2;
    CGFloat buttonH = 50;
    CGFloat buttonY = kMSScreenHeight -kMSNaviHight- buttonH;

    for (NSInteger i = 0; i < imagesNor.count; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setImage:[UIImage imageNamed:imagesNor[i]] forState:UIControlStateNormal];
        button.backgroundColor = [UIColor whiteColor];
        [button setImage:[UIImage imageNamed:imagesSel[i]] forState:UIControlStateSelected];
        button.tag = i;
        [button addTarget:self action:@selector(bottomButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        CGFloat buttonX = (buttonW * i);
        button.frame = CGRectMake(buttonX, buttonY, buttonW, buttonH);

        [self.view addSubview:button];
    }
}
#pragma mark - 加入购物车 立即购买
- (void)setUpRightTwoButton
{
    NSArray *titles = @[@"加入购物车",@"立即购买"];
    CGFloat buttonW = kMSScreenWith * 0.6 * 0.5;
    CGFloat buttonH = 50;
    CGFloat buttonY = kMSScreenHeight -kMSNaviHight- buttonH;
    for (NSInteger i = 0; i < titles.count; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.titleLabel.font = PFR16Font;
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        button.tag = i + 2;
        [button setTitle:titles[i] forState:UIControlStateNormal];
        button.backgroundColor = (i == 0) ? [UIColor redColor] : kMSButtonBackColor;
        [button addTarget:self action:@selector(bottomButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        CGFloat buttonX = kMSScreenWith * 0.4 + (buttonW * i);
        button.frame = CGRectMake(buttonX, buttonY, buttonW, buttonH);

        [self.view addSubview:button];
    }
}
#pragma mark - <UIScrollViewDelegate>
-(void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    [self addChildViewController];
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    NSInteger index = scrollView.contentOffset.x / scrollView.width;
    UIButton *button = _bgView.subviews[index];

    [self topBottonClick:button];

    [self addChildViewController];
}

#pragma mark - 导航栏设置
- (void)setUpNav
{
    UIButton *btnLeft = [UIButton buttonWithType:UIButtonTypeCustom];
    [btnLeft setImage:[UIImage imageNamed:@"ic_back.png"] forState:UIControlStateNormal];
    [btnLeft setImage:[UIImage imageNamed:@"ic_back.png"] forState:UIControlStateHighlighted];
    [btnLeft sizeToFit];

    [btnLeft addTarget:self action:@selector(showleft) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem* leftButtonItem = [[UIBarButtonItem alloc] init];
    leftButtonItem.customView = btnLeft;
    self.navigationItem.leftBarButtonItem = leftButtonItem;


    UIButton *pulishButton=[UIButton buttonWithType:(UIButtonTypeCustom)];
    [pulishButton setImage:[UIImage imageNamed:@"goodInfo_share"] forState:UIControlStateNormal];
    [pulishButton addTarget:self action:@selector(goodInfoshare) forControlEvents:UIControlEventTouchUpInside];


    UIButton *saveButton=[UIButton buttonWithType:(UIButtonTypeCustom)];
   [saveButton setImage:[UIImage imageNamed:@"goodInfo_message"] forState:UIControlStateNormal];
    [saveButton addTarget:self action:@selector(messageAction) forControlEvents:UIControlEventTouchUpInside];

    pulishButton.frame = CGRectMake(0, 0, 19, 18);
    saveButton.frame=CGRectMake(0, 0, 16, 19);


    UIBarButtonItem *save = [[UIBarButtonItem alloc] initWithCustomView:saveButton];
    UIBarButtonItem *pulish = [[UIBarButtonItem alloc] initWithCustomView:pulishButton];
    [self.navigationItem setRightBarButtonItems:[NSArray arrayWithObjects:save, pulish,nil]];

//    _titleArr = @[@"消息",@"首页",@"足迹",@"购物车"];
//    _imgArr = @[@"Tab_icon_messsge_normal",@"Tab_icon_Home_normal",@"main_zuji",@"Tab_icon_Cart_normal"];
}

-(void)goodInfoshare
{

}
-(void)messageAction
{
    PST_MenuView *menuView = [[PST_MenuView alloc] initWithFrame:CGRectMake(kMSScreenWith- 120 - 8, 60, 120, 168) titleArr:_titleArr imgArr:_imgArr arrowOffset:104 rowHeight:40 layoutType:0 directionType:0 delegate:self];
    menuView.lineColor = [[UIColor lightGrayColor]colorWithAlphaComponent:0.15];
}

-(NSArray *)imgArr{
    if (!_imgArr) {
        _imgArr = [[NSArray alloc] init];
    }
    return _imgArr;
}
-(NSArray *)titleArr{
    if (!_titleArr) {
        _titleArr = [[NSArray alloc] init];
    }
    return _titleArr;
}

-(void)didSelectRowAtIndex:(NSInteger)index title:(NSString *)title img:(NSString *)img{
    NSLog(@"index----%zd,  title---%@, image---%@", index, title, img);
}

-(void)showleft
{
    [self.navigationController popViewControllerAnimated:YES];
    [self dismissViewControllerAnimated:YES completion:nil];
}


- (void)bottomButtonClick:(UIButton *)button
{
    if (button.tag == 0) {
        NSLog(@"收藏");
        button.selected = !button.selected;
    }else if(button.tag == 1){
        NSLog(@"购物车");
        WJShopCartClassViewController *shopCarVc = [[WJShopCartClassViewController alloc] init];
        shopCarVc.isHasTabBarController = NO;
        shopCarVc.isHasNavitationController = YES;
        self.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:shopCarVc animated:YES];
    }else  if (button.tag == 2 || button.tag == 3) {


         dispatch_sync(dispatch_get_global_queue(0, 0), ^{
            NSDictionary *dict = [[NSDictionary alloc] initWithObjectsAndKeys:[NSString stringWithFormat:@"%zd",button.tag],@"buttonTag", nil];
            [[NSNotificationCenter defaultCenter]postNotificationName:@"ClikAddOrBuy" object:nil userInfo:dict];
             });
    }
}


#pragma mark - 消失
- (void)dealloc
{
    NSLog(@"goodDetail 销毁");
    [[NSNotificationCenter defaultCenter]removeObserver:_dcObserve];
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
