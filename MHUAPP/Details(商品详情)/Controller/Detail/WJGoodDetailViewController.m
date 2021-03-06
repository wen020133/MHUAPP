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
#import "WJConversationViewController.h"

#import "UIView+UIViewFrame.h"
#import "WJToolsViewController.h"
#import "XWDrawerAnimator.h"
#import "UIViewController+XWTransition.h"

#import "WJShopCartClassViewController.h"
#import "WJStoreInfoClassViewController.h"
#import "WJMyFootprintViewController.h"
#import "JXButton.h"
#import "PST_MenuView.h"

#import "WJDetailPartCommentItem.h"
#import <UShareUI/UShareUI.h>
#import "WJLoginClassViewController.h"
#import "WJMainWebClassViewController.h"
#import "AESCrypt.h"

#import "SRWebSocket.h"
#import "WJToast.h"

@interface WJGoodDetailViewController ()<PST_MenuViewDelegate,SRWebSocketDelegate>

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

/* 商品评论 */
@property (strong , nonatomic)NSArray<WJDetailPartCommentItem *> *getCommentArray;

@property NSInteger postDataType;

@property(nonatomic,strong) SRWebSocket *webSocket;
@end

@implementation WJGoodDetailViewController

#pragma mark - LifeCyle
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self Reconnect];
    [self.navigationController setNavigationBarHidden:NO animated:animated];
}



//初始化
- (void)Reconnect{
    
    NSLog(@"1221---open");
    
    self.webSocket.delegate = nil;
    [self.webSocket close];
    
    NSString *str_url = @"";
    str_url =  @"wss://www.miyomei.com:8080/order";
    self.webSocket = [[SRWebSocket alloc] initWithURLRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:str_url]]];
    self.webSocket.delegate = self;
    
    [self.webSocket open];
}



- (void)viewDidDisappear:(BOOL)animated{
    // Close WebSocket
    self.webSocket.delegate = nil;
    [self.webSocket close];
    self.webSocket = nil;
}

//连接成功
//代理方法实现
#pragma mark - SRWebSocketDelegate
- (void)webSocketDidOpen:(SRWebSocket *)webSocket{
    NSLog(@"Websocket Connected");
}
//连接失败
- (void)webSocket:(SRWebSocket *)webSocket didFailWithError:(NSError *)error{
    NSLog(@":( Websocket Failed With Error %@", error);
    
    self.title = @"Connection Failed! (see logs)";
    self.webSocket = nil;
}
//接收到新消息的处理
- (void)webSocket:(SRWebSocket *)webSocket didReceiveMessage:(id)message{
    
    NSLog(@"%@--askl",message);
    NSData *jsonData = [message dataUsingEncoding:NSUTF8StringEncoding];
    
    NSError *err;
    
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:&err];
    if(err) {
        NSLog(@"json解析失败：%@",err);
    }
    else
    {
        WEAKSELF
        [WJToast showToastWithMessage:[dic objectForKey:@"user_name"] checkCouponButtonClickedBlock:^{
            WJGoodDetailViewController *dcVc = [[WJGoodDetailViewController alloc] init];
            dcVc.goods_id = dic[@"goods_id"];;
            dcVc.hidesBottomBarWhenPushed = YES;
            [weakSelf.navigationController pushViewController:dcVc animated:YES];
            weakSelf.hidesBottomBarWhenPushed = NO;
        }];
    }
    
}
//连接关闭
- (void)webSocket:(SRWebSocket *)webSocket didCloseWithCode:(NSInteger)code reason:(NSString *)reason wasClean:(BOOL)wasClean{
    NSLog(@"Closed Reason:%@",reason);
    self.title = @"Connection Closed! (see logs)";
    self.webSocket = nil;
}

- (void)webSocket:(SRWebSocket *)webSocket didReceivePong:(NSData *)pongPayload{
    
    NSString *reply = [[NSString alloc] initWithData:pongPayload encoding:NSUTF8StringEncoding];
    NSLog(@"reply==%@",reply);
}
- (void)viewDidLoad {

    [super viewDidLoad];
    
    [self setUpInit];

    [self setUpNav];

    [self setUpTopButtonView];

    [self getGoodsInfoItem];

    [self setUpBottomButton];

    [self acceptanceNote];

    [self initPostFootmarkData];
    
    // Do any additional setup after loading the view.
}

-(void)initPostFootmarkData
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSString *uid = [[userDefaults objectForKey:@"userList"] objectForKey:@"uid" ];
    _postDataType =1;
    NSMutableDictionary *infos = [NSMutableDictionary dictionary];
    [infos setValue:uid forKey:@"user_id"];
    [infos setValue:_goods_id forKey:@"id"];
    [self requestAPIWithServe:[kMSBaseMiYoMeiPortURL stringByAppendingString:kMSPostFootmark] andInfos:infos];
}
-(void)initPostCollectGoodsData
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSString *uid = [[userDefaults objectForKey:@"userList"] objectForKey:@"uid" ];
    _postDataType =2;
    NSMutableDictionary *infos = [NSMutableDictionary dictionary];
    [infos setValue:uid forKey:@"user_id"];
    [infos setValue:_goods_id forKey:@"id"];
    [self requestAPIWithServe:[kMSBaseMiYoMeiPortURL stringByAppendingString:kMSPostCollectGoods] andInfos:infos];
}
-(void)processData
{
    if([[self.results objectForKey:@"code"] integerValue] == 200)
    {
        if (_postDataType==1) {
             NSLog(@"加入足迹---%@！",self.results[@"data"]);
        }
        else if (_postDataType == 2 )
        {
            [SVProgressHUD showSuccessWithStatus:@"关注成功"];
            [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
            [SVProgressHUD dismissWithDelay:1.0];
        }

    }
    else
    {
        NSLog(@"加入足迹---%@！",self.results[@"data"]);
        if (_postDataType == 2 )
        {
            [self requestFailed:self.results[@"msg"]];
        }
        return;
    }
}
-(void)getGoodsInfoItem
{
    _serverType = 1;
    [self requestGetAPIWithServe:[NSString stringWithFormat:@"%@/%@/%@?id=%@",kMSBaseMiYoMeiPortURL,kMSappVersionCode,kMSGetDetailed,_goods_id]];
}

-(void)setkMSGetComment
{
    _serverType = 2;
    [self requestGetAPIWithServe:[NSString stringWithFormat:@"%@/%@/%@/?goods_id=%@&start=%d&numb=%@",kMSBaseMiYoMeiPortURL,kMSappVersionCode,kMSGetComment,_goods_id,0,kMSPULLtableViewCellNumber]];
    
    [self performSelector:@selector(delayMethod) withObject:nil afterDelay:1.0];
}
-(void)delayMethod
{
    [self setgetSupplierUserId];
}
-(void)setgetSupplierUserId
{
    _serverType = 3;
    [self requestGetAPIWithServe:[NSString stringWithFormat:@"%@/%@/%@?id=%@",kMSBaseMiYoMeiPortURL,kMSappVersionCode,kMSGetSupplierUserId,_supplier_id]];
}
-(void)getProcessData
{
    if([[self.results objectForKey:@"code"] integerValue] == 200)
    {

        
        switch (_serverType) {
            case KGetshopInfoClass:
            {
                if([[self.results objectForKey:@"data"] isKindOfClass:[NSNull class]])
                {
                    return;
                }
                _goodTitle =[NSString stringWithFormat:@"%@", self.results[@"data"][@"goods_name"]];
                _goods_brief =[NSString stringWithFormat:@"%@", self.results[@"data"][@"goods_brief"]];
                _goodPrice =[NSString stringWithFormat:@"%@", self.results[@"data"][@"shop_price"]];
                _oldPrice = [NSString stringWithFormat:@"%@",self.results[@"data"][@"market_price"]];
                _is_use_bonus = [NSString stringWithFormat:@"%@",self.results[@"data"][@"is_use_bonus"]];
                _bonus_tips = [NSString stringWithFormat:@"%@",self.results[@"data"][@"bonus_tips"]];
                _goodImageView =[NSString stringWithFormat:@"%@", self.results[@"data"][@"goods_thumb"]];
                _shufflingArray = self.results[@"data"][@"gallery"];
                _attributeArray = self.results[@"data"][@"attr"];
                _goods_number = [self.results[@"data"][@"goods_number"] integerValue];
//                self.galleryArray = self.results[@"data"][@"gallery"];
                _supplier_id = [NSString stringWithFormat:@"%@",self.results[@"data"][@"supplier_id"]];
                id supplierU = [[self.results objectForKey:@"data"] objectForKey:@"supplier_name"];
                if ([supplierU isKindOfClass:[NSDictionary class]]) {
                    _supplier_name = [supplierU objectForKey:@"supplier_name"];
                     _supplier_logo = [supplierU objectForKey:@"logo"];
                }

                [self setkMSGetComment];
            }
                break;
            case KGetComment:
            {

                NSMutableArray *arr_Datalist = [NSMutableArray array];
                arr_Datalist = [self.results objectForKey:@"data"];
                if (![arr_Datalist isEqual:[NSNull null]]) {
                    _getCommentArray = [WJDetailPartCommentItem mj_objectArrayWithKeyValuesArray:arr_Datalist];
                }
                [self setUpChildViewControllers];
                [self addChildViewController];
            }
                break;
                case KGetSupplierUserId:
            {
                _supplierUserId = [NSString stringWithFormat:@"%@", [self.results objectForKey:@"data"]];
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
    WJGoodBaseViewController *goodBaseVc = [[WJGoodBaseViewController alloc] init];
    goodBaseVc.goodTitle = _goodTitle;
    goodBaseVc.goodPrice = _goodPrice;
    goodBaseVc.goodSubtitle = _goodSubtitle;
    goodBaseVc.shufflingArray = _shufflingArray;
    goodBaseVc.oldPrice = _oldPrice;
    goodBaseVc.bonus_tips = _bonus_tips;
    goodBaseVc.is_use_bonus = _is_use_bonus;
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
    goodBaseVc.goods_number = _goods_number;
    goodBaseVc.goodImageView = _goodImageView;
    goodBaseVc.goods_id = _goods_id;
    goodBaseVc.supplier_id = _supplier_id;
    goodBaseVc.commentArray = _getCommentArray;
    [self addChildViewController:goodBaseVc];

    WJGoodParticularsViewController *goodParticularsVc = [[WJGoodParticularsViewController alloc] init];
    goodParticularsVc.goods_id = _goods_id;
    [self addChildViewController:goodParticularsVc];

    WJGoodCommentViewController *goodCommentVc = [[WJGoodCommentViewController alloc] init];
     goodCommentVc.goods_id = _goods_id;
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
    
    NSArray *imagesNor = @[@"shop_default",@"customerService",@"home_Like_icon"];
    NSArray *imagesSel = @[@"店铺",@"客服",@"关注"];
    CGFloat buttonW = kMSScreenWith * 0.5/3;
    CGFloat buttonH = 50;
    CGFloat buttonY = kMSScreenHeight -kMSNaviHight- buttonH;
    
    UIView *imagev = [[UIView alloc]initWithFrame:CGRectMake(0, buttonY, kMSScreenWith * 0.5, buttonH)];
    imagev.backgroundColor = kMSCellBackColor;
    imagev.layer.masksToBounds = YES;
    imagev.layer.shadowColor = [UIColor lightGrayColor].CGColor;//阴影颜色
    imagev.layer.shadowOffset = CGSizeMake(0, 0);//偏移距离
    imagev.layer.shadowOpacity = 0.5;//不透明度
    imagev.layer.shadowRadius = 10.0;//半径
    [self.view addSubview:imagev];
    
    for (NSInteger i = 0; i < imagesNor.count; i++) {
        JXButton *button = [JXButton new];
        [button setTitle:imagesSel[i] forState:UIControlStateNormal];
        [button setTitleColor:[RegularExpressionsMethod ColorWithHexString:BASEBLACKCOLOR] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:imagesNor[i]] forState:UIControlStateNormal];
        button.tag = i;
        [button addTarget:self action:@selector(bottomButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        CGFloat buttonX = (buttonW-32)/2+i*buttonW;
        button.frame = CGRectMake(buttonX, DCMargin, 32, 38);
        
        [imagev addSubview:button];
    }
}
#pragma mark - 加入购物车 立即购买
- (void)setUpRightTwoButton
{
    NSArray *titles = @[@"加入购物车",@"立即购买"];
    CGFloat buttonW = kMSScreenWith * 0.5 * 0.5;
    CGFloat buttonH = 50;
    CGFloat buttonY = kMSScreenHeight -kMSNaviHight- buttonH;
    for (NSInteger i = 0; i < titles.count; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.titleLabel.font = PFR16Font;
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        button.tag = i + 3;
        [button setTitle:titles[i] forState:UIControlStateNormal];
        button.backgroundColor = (i == 0) ? [UIColor redColor] : kMSButtonBackColor;
        [button addTarget:self action:@selector(bottomButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        CGFloat buttonX = kMSScreenWith * 0.5 + (buttonW * i);
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
    [self.navigationItem setRightBarButtonItems:[NSArray arrayWithObjects:save,pulish,nil]];

    _titleArr = @[@"消息",@"首页",@"足迹",@"购物车"];
    _imgArr = @[@"Tab_icon_messsge_normal",@"Tab_icon_Home_normal",@"main_zuji",@"Tab_icon_Cart_normal"];
}

-(void)goodInfoshare
{
    //创建分享消息对象
   UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];

    //设置文本
    messageObject.text = self.goodTitle;

    UMShareWebpageObject *shareObject = [UMShareWebpageObject shareObjectWithTitle:self.goodTitle descr:self.goods_brief thumImage:self.goodImageView];
    //设置网页地址
    shareObject.webpageUrl = [NSString stringWithFormat:@"https://www.miyomei.com/mobile/goods.php?id=%@",_goods_id] ;
    

    //分享消息对象设置分享内容对象
    messageObject.shareObject = shareObject;

    [UMSocialUIManager setPreDefinePlatforms:@[@(UMSocialPlatformType_QQ),@(UMSocialPlatformType_WechatSession)]];
    [UMSocialUIManager showShareMenuViewInWindowWithPlatformSelectionBlock:^(UMSocialPlatformType platformType, NSDictionary *userInfo) {
        // 根据获取的platformType确定所选平台进行下一步操作
        
        //调用分享接口
        [[UMSocialManager defaultManager] shareToPlatform:platformType messageObject:messageObject currentViewController:self completion:^(id data, NSError *error) {
            if (error) {
                NSString *str_error = [error localizedDescription];
                [self requestFailed:str_error];
            }else{
                NSLog(@"response data is %@",data);
            }
        }];
    }];
    
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
    NSLog(@"index----%ld,  title---%@, image---%@", index, title, img);
    switch (index) {
        case 0:
        {
            self.tabBarController.selectedIndex = 2;
            [self.navigationController popToRootViewControllerAnimated:NO];
            
        }
            break;
            case 1:
        {
            [self.navigationController popToRootViewControllerAnimated:YES];
            self.tabBarController.selectedIndex = 0;
        }
            break;
            case 2:
        {
             WJMyFootprintViewController *storeInfo = [[WJMyFootprintViewController alloc]init];
            storeInfo.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:storeInfo animated:YES];
            self.hidesBottomBarWhenPushed = YES;
        }
            break;
            case 3:
        {
            WJShopCartClassViewController *storeInfo = [[WJShopCartClassViewController alloc]init];
            storeInfo.isHasTabBarController = NO;
            storeInfo.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:storeInfo animated:YES];
            self.hidesBottomBarWhenPushed = YES;
        }
            break;
        default:
            break;
    }
}

-(void)showleft
{
    [self.navigationController popViewControllerAnimated:YES];
    [self dismissViewControllerAnimated:YES completion:nil];
}


- (void)bottomButtonClick:(UIButton *)button
{
    WEAKSELF
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSString *loginState = [userDefaults objectForKey:@"loginState"];
    if(![loginState isEqualToString:@"1"])
    {
        WJLoginClassViewController *land = [[WJLoginClassViewController alloc]init];
        UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:land];
        [nav.navigationBar setIsMSNavigationBar];
        [weakSelf presentViewController:nav animated:YES completion:^{
        }];
        return;
    }
    if (button.tag == 0) {
        NSLog(@"店铺");
        button.selected = !button.selected;
        WJStoreInfoClassViewController *storeInfo = [[WJStoreInfoClassViewController alloc]init];
        storeInfo.storeId = _supplier_id;
        storeInfo.storeLogo = _supplier_logo;
        storeInfo.storeName = _supplier_name;
        storeInfo.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:storeInfo animated:YES];
        self.hidesBottomBarWhenPushed = YES;
    }else if(button.tag == 1){
        NSLog(@"客服");
//        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
//
//        NSString *loginState = [userDefaults objectForKey:@"loginState"];
//        if(![loginState isEqualToString:@"1"])
//        {
//            WJLoginClassViewController *land = [[WJLoginClassViewController alloc]init];
//            UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:land];
//            [nav.navigationBar setIsMSNavigationBar];
//            [self presentViewController:nav animated:YES completion:^{
//            }];
//        }
//        else
//        {
            if (![_supplierUserId isEqual:[NSNull null]]) {
                if (_supplierUserId.length>0) {
            NSString *uid = [[userDefaults objectForKey:@"userList"] objectForKey:@"uid" ];
            WJMainWebClassViewController *conversationVC = [[WJMainWebClassViewController alloc]init];
            NSString *encryptedData = [AESCrypt encrypt:[NSString stringWithFormat:@"uid=%@@sid=%@",uid,_supplierUserId] password:@"miyomei2018"];
            
            NSString *encodedString =[RegularExpressionsMethod encodeString:encryptedData];
            
            
            NSString *str_url = [NSString stringWithFormat:@"https://www.miyomei.com/mobile/mobile_chat_online.php?suppId=%@&goodsId=%@&appToken=%@",_supplier_id,_goods_id,encodedString];
            conversationVC.str_urlHttp =str_url;
            
            NSString *message = [AESCrypt decrypt:@"piaJVqHq3yBxT0H3QORtQ==" password:@"miyomei2018"];
            NSLog(@"message==%@    %@",message,str_url);
            conversationVC.str_title = _supplier_name;
            self.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:conversationVC animated:YES];
//        }
//        else
//        {
//            [self requestFailed:@"获取客服信息失败！"];
//            return;
//        }
    }
    else
    {
        [self requestFailed:@"获取客服信息失败！"];
        return;
    }
        }

//                WJConversationViewController *conversationVC = [[WJConversationViewController alloc]init];
//                conversationVC.conversationType = ConversationType_PRIVATE;
//                NSString *kefuUserId = _supplierUserId;
//                conversationVC.targetId =  kefuUserId;
//
//                conversationVC.strTitle =_supplier_name;
//                NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
//
//                NSArray *friendsList = [userDefaults objectForKey:@"RYFriendsList"];
//                NSMutableArray *allTimeArr = [NSMutableArray arrayWithArray:friendsList];
//                int kk=0;
//                for (NSDictionary *goodsDic in friendsList) {
//                    NSString *userId = goodsDic[@"userId"];
//                    if([kefuUserId isEqualToString:userId]){
//                        kk++;
//                    }
//                }
//                if (kk==0) {
//                    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
//                    [dic setValue:_supplierUserId forKey:@"userId"];
//                    [dic setValue:_supplier_name forKey:@"name"];
//                    [dic setValue:_supplier_logo forKey:@"portrait"];
//                    [allTimeArr addObject:dic];
//                    [userDefaults setObject:allTimeArr forKey:@"RYFriendsList"];
//                    [userDefaults synchronize];
//                }
//                else
//                {
//                    int bb=0;
//                    for (int aa=0; aa<friendsList.count; aa++) {
//                        NSString *userId = friendsList[aa][@"userId"];
//                        if([kefuUserId isEqualToString:userId]){
//                            bb=aa;
//                        }
//                    }
//                    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
//                    [dic setValue:_supplierUserId forKey:@"userId"];
//                    [dic setValue:_supplier_name forKey:@"name"];
//                    [dic setValue:_supplier_logo forKey:@"portrait"];
//                    [allTimeArr insertObject:dic atIndex:bb];
//                    [userDefaults setObject:allTimeArr forKey:@"RYFriendsList"];
//                    [userDefaults synchronize];
//                }
//                RCRichContentMessage *richMsg = [RCRichContentMessage messageWithTitle:_goodTitle digest:[NSString stringWithFormat:@"￥%@",_goodPrice] imageURL:_goodImageView url:[NSString stringWithFormat:@"https://www.miyomei.com/goods.php?id=%@",_goods_id] extra:nil];
//                RCMessage *message = [[RCIMClient sharedRCIMClient]
//                                      insertOutgoingMessage:ConversationType_PRIVATE
//                                      targetId:kefuUserId
//                                      sentStatus:SentStatus_SENT
//                                      content:richMsg];
//                 [[NSNotificationCenter defaultCenter] postNotificationName:@"RCDSharedMessageInsertSuccess" object:message];
            
    }
    else if(button.tag == 2){
        NSLog(@"关注");
        [self initPostCollectGoodsData];
    }else  if (button.tag == 3 || button.tag == 4) {
        
         dispatch_sync(dispatch_get_global_queue(0, 0), ^{
            NSDictionary *dict = [[NSDictionary alloc] initWithObjectsAndKeys:[NSString stringWithFormat:@"%ld",button.tag],@"buttonTag", nil];
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
