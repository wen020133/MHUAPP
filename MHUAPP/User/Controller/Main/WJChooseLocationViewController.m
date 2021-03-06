//
//  WJChooseLocationViewController.m
//  MHUAPP
//
//  Created by jinri on 2018/1/30.
//  Copyright © 2018年 wenchengjun. All rights reserved.
//

#import "WJChooseLocationViewController.h"
// Categories
#import "UIViewController+XWTransition.h"


#import "AddressView.h"
#import "UIView+UIViewFrame.h"
#import "AddressTableViewCell.h"
#import "WJAddressItem.h"

static  CGFloat  const  kHYTopViewHeight = 40; //顶部视图的高度
static  CGFloat  const  kHYTopTabbarHeight = 30; //地址标签栏的高度

@interface WJChooseLocationViewController ()<UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate>
@property (nonatomic,weak) AddressView * topTabbar;
@property (nonatomic,weak) UIScrollView * contentView;
@property (nonatomic,weak) UIView * underLine;
@property (strong , nonatomic) NSMutableArray<WJAddressItem *>* allProvinces;
@property (nonatomic,strong) NSMutableArray<WJAddressItem *> * currentCityArray;
@property (nonatomic,strong) NSMutableArray<WJAddressItem *> * currentAreaArray;
@property (nonatomic,strong) NSMutableArray * tableViews;
@property (nonatomic,strong) NSMutableArray * topTabbarItems;
@property (nonatomic,weak) UIButton * selectedBtn;

@end

@implementation WJChooseLocationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUp];
    self.str_fatherID = @"1";
    [self getAddressArrayData];
    [[IQKeyboardManager sharedManager] setEnable:NO];
    // Do any additional setup after loading the view.
}
#pragma mark - 弹出弹框
- (void)setUpFeatureAlterView
{
    [self dismissViewControllerAnimated:YES completion:^{
        [self.delegate selectAddressRow:self.currentProvince provinceID:self.currentProvinceID city:self.currentCity cityID:self.currentCityID area:self.currentArea areaID:self.currentAreaID];
    }];

}

-(void)getAddressArrayData
{
    self.regType = 0;
    NSMutableDictionary *infos = [NSMutableDictionary dictionary];
    [infos setValue:self.str_fatherID forKey:@"region_id"];
    [self requestAPIWithServe:[kMSBaseLargeCollectionPortURL stringByAppendingString:kMSAddressSiteList] andInfos:infos];
}
-(void)processData
{
    if([[self.results objectForKey:@"code"] integerValue] == 200)
    {
        switch (self.regType) {
            case 0:
            {
                id arr = [self.results objectForKey:@"data"];
                if([arr isKindOfClass:[NSArray class]])
                {
                    self.allProvinces =   [WJAddressItem mj_objectArrayWithKeyValuesArray:arr];
                    [[self.tableViews objectAtIndex:0] reloadData];
                }
            }
                break;
            case 1:
            {
                id arr = [self.results objectForKey:@"data"];
                if([arr isKindOfClass:[NSArray class]])
                {
                    self.currentCityArray =   [WJAddressItem mj_objectArrayWithKeyValuesArray:arr];
                    [[self.tableViews objectAtIndex:1] reloadData];
                }
            }
                break;
            case 2:
            {
                id arr = [self.results objectForKey:@"data"];
                if([arr isKindOfClass:[NSArray class]])
                {
                    self.currentAreaArray =   [WJAddressItem mj_objectArrayWithKeyValuesArray:arr];
                    [[self.tableViews objectAtIndex:2] reloadData];
                }
            }
                break;
            default:
                break;
        }

    }
    else
    {
        [SVProgressHUD showErrorWithStatus:[self
                                            .results objectForKey:@"msg"]];
    }
}
- (void)setUp{

    UIView * topView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kMSScreenWith, kHYTopViewHeight)];
    [self.view addSubview:topView];
    UILabel * titleLabel = [[UILabel alloc]init];
    titleLabel.text = @"配送至";
    [titleLabel sizeToFit];
    [topView addSubview:titleLabel];
    titleLabel.center = topView.center;
    UIView * separateLine = [self separateLine];
    [topView addSubview: separateLine];
    separateLine.y = topView.height - separateLine.height;
    topView.backgroundColor = [UIColor whiteColor];


    AddressView * topTabbar = [[AddressView alloc]initWithFrame:CGRectMake(0, topView.height, kMSScreenWith, kHYTopViewHeight)];
    [self.view addSubview:topTabbar];
    _topTabbar = topTabbar;
    [self addTopBarItem];
    UIView * separateLine1 = [self separateLine];
    [topTabbar addSubview: separateLine1];
    separateLine1.y = topTabbar.height - separateLine.height;
    [_topTabbar layoutIfNeeded];
    topTabbar.backgroundColor = [UIColor whiteColor];

    UIView * underLine = [[UIView alloc] initWithFrame:CGRectZero];
    [topTabbar addSubview:underLine];
    _underLine = underLine;
    underLine.height = 2.0f;
    UIButton * btn = self.topTabbarItems.lastObject;
    [self changeUnderLineFrame:btn];
    underLine.y = separateLine1.y - underLine.height;

    _underLine.backgroundColor = [UIColor orangeColor];
    UIScrollView * contentView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(topTabbar.frame), kMSScreenWith, self.view.height - kHYTopViewHeight - kHYTopTabbarHeight)];
    contentView.contentSize = CGSizeMake(kMSScreenWith, 0);
    [self.view addSubview:contentView];
    _contentView = contentView;
    _contentView.pagingEnabled = YES;
    _contentView.backgroundColor = [UIColor whiteColor];
    [self addTableView];
    _contentView.delegate = self;
}
- (void)addTableView{

    UITableView * tabbleView = [[UITableView alloc]initWithFrame:CGRectMake(self.tableViews.count * kMSScreenWith, 0, kMSScreenWith, _contentView.height)];
    [_contentView addSubview:tabbleView];
    [self.tableViews addObject:tabbleView];
    tabbleView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tabbleView.delegate = self;
    tabbleView.dataSource = self;
    tabbleView.contentInset = UIEdgeInsetsMake(0, 0, 44, 0);
    [tabbleView registerNib:[UINib nibWithNibName:@"AddressTableViewCell" bundle:nil] forCellReuseIdentifier:@"AddressTableViewCell"];
}

- (void)addTopBarItem{

    UIButton * topBarItem = [UIButton buttonWithType:UIButtonTypeCustom];
    [topBarItem setTitle:@"请选择" forState:UIControlStateNormal];
    [topBarItem setTitleColor:[UIColor colorWithRed:43/255.0 green:43/255.0 blue:43/255.0 alpha:1] forState:UIControlStateNormal];
    [topBarItem setTitleColor:[UIColor orangeColor] forState:UIControlStateSelected];
    [topBarItem sizeToFit];
    topBarItem.dc_centerY = _topTabbar.height * 0.5;
    [self.topTabbarItems addObject:topBarItem];
    [_topTabbar addSubview:topBarItem];
    [topBarItem addTarget:self action:@selector(topBarItemClick:) forControlEvents:UIControlEventTouchUpInside];
}

#pragma mark - TableViewDatasouce

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    if([self.tableViews indexOfObject:tableView] == 0){
        return self.allProvinces.count;
    }else if ([self.tableViews indexOfObject:tableView] == 1){
        return self.currentCityArray.count;
    }else if ([self.tableViews indexOfObject:tableView] == 2){
        return self.currentAreaArray.count;
    }
    return self.allProvinces.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    AddressTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"AddressTableViewCell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    WJAddressItem * item;
    //省级别
    if([self.tableViews indexOfObject:tableView] == 0){
        item = self.allProvinces[indexPath.row];
        //市级别
    }else if ([self.tableViews indexOfObject:tableView] == 1){
        item = self.currentCityArray[indexPath.row];
        //县级别
    }else if ([self.tableViews indexOfObject:tableView] == 2){
        item = self.currentAreaArray[indexPath.row];
    }
    cell.item = item;
    return cell;
}

/** 获取当前省 的市数组 */
-(void)resetCityArray{
    [self.currentCityArray removeAllObjects];
    [self.currentAreaArray removeAllObjects];
    self.regType = 1;
    NSMutableDictionary *infos = [NSMutableDictionary dictionary];
    [infos setValue:self.allProvinces[self.provinceIndex].region_id forKey:@"region_id"];
    [self requestAPIWithServe:[kMSBaseLargeCollectionPortURL stringByAppendingString:kMSAddressSiteList] andInfos:infos];

}

/** 根据当前城市编号 获取区数组 */
-(void)resetAreaArray{
    [self.currentAreaArray removeAllObjects];

    self.regType = 2;
    NSMutableDictionary *infos = [NSMutableDictionary dictionary];
    [infos setValue:self.currentCityArray[self.cityIndex].region_id forKey:@"region_id"];
    [self requestAPIWithServe:[kMSBaseLargeCollectionPortURL stringByAppendingString:kMSAddressSiteList] andInfos:infos];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    WJAddressItem * item;
    if([self.tableViews indexOfObject:tableView] == 0){
        item = self.allProvinces[indexPath.row];

        for (int i = 0; i < self.tableViews.count && self.tableViews.count != 1; i++) {
            [self removeLastItem];
        }

        //之前未选中省，第一次选择省
        [self addTopBarItem];
        [self addTableView];
        [self scrollToNextItem:self.allProvinces[indexPath.row].region_name ];
        // 重置当前城市数组
        self.provinceIndex = indexPath.row;
        [self resetCityArray];

        _currentProvince = _allProvinces[indexPath.row].region_name;
        _currentProvinceID = _allProvinces[indexPath.row].region_id;

    }else if ([self.tableViews indexOfObject:tableView] == 1){
        item = self.currentCityArray[indexPath.row];

        [self addTopBarItem];
        [self addTableView];
        [self scrollToNextItem:self.currentCityArray[indexPath.row].region_name ];
        // 重置当前城市数组
        self.cityIndex = indexPath.row;
        [self resetAreaArray];

        _currentCity = _currentCityArray[indexPath.row].region_name;
        _currentCityID = _currentCityArray[indexPath.row].region_id;

    }else if ([self.tableViews indexOfObject:tableView] == 2){
        item = self.currentAreaArray[indexPath.row];
        _currentArea = _currentAreaArray[indexPath.row].region_name;
        _currentAreaID = _currentAreaArray[indexPath.row].region_id;
        [self setUpAddress:self.currentAreaArray[indexPath.row].region_name];

    }
    item.isSelected = YES;
    [tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    [tableView selectRowAtIndexPath:indexPath animated:NO scrollPosition:UITableViewScrollPositionNone];

}



#pragma mark - private

//点击按钮,滚动到对应位置
- (void)topBarItemClick:(UIButton *)btn{

    NSInteger index = [self.topTabbarItems indexOfObject:btn];

    [UIView animateWithDuration:0.5 animations:^{
        self.contentView.contentOffset = CGPointMake(index * kMSScreenWith, 0);
        [self changeUnderLineFrame:btn];
    }];
}

//调整指示条位置
- (void)changeUnderLineFrame:(UIButton  *)btn{

    _selectedBtn.selected = NO;
    btn.selected = YES;
    _selectedBtn = btn;
    _underLine.x = btn.x;
    _underLine.width = btn.width;
}

//完成地址选择,执行chooseFinish代码块
- (void)setUpAddress:(NSString *)address{

    NSInteger index = self.contentView.contentOffset.x / kMSScreenWith;
    UIButton * btn = self.topTabbarItems[index];
    [btn setTitle:address forState:UIControlStateNormal];
    [btn sizeToFit];
    [_topTabbar layoutIfNeeded];
    [self changeUnderLineFrame:btn];
   

        self.view.hidden = YES;
            [self setUpFeatureAlterView];

}

//当重新选择省或者市的时候，需要将下级视图移除。
- (void)removeLastItem{

    [self.tableViews.lastObject performSelector:@selector(removeFromSuperview) withObject:nil withObject:nil];
    [self.tableViews removeLastObject];

    [self.topTabbarItems.lastObject performSelector:@selector(removeFromSuperview) withObject:nil withObject:nil];
    [self.topTabbarItems removeLastObject];
}

//滚动到下级界面,并重新设置顶部按钮条上对应按钮的title
- (void)scrollToNextItem:(NSString *)preTitle{

    NSInteger index = self.contentView.contentOffset.x / kMSScreenWith;
    UIButton * btn = self.topTabbarItems[index];
    [btn setTitle:preTitle forState:UIControlStateNormal];
    [btn sizeToFit];
    [_topTabbar layoutIfNeeded];
    [UIView animateWithDuration:0.25 animations:^{
        self.contentView.contentSize = (CGSize){self.tableViews.count * kMSScreenWith,0};
        CGPoint offset = self.contentView.contentOffset;
        self.contentView.contentOffset = CGPointMake(offset.x + kMSScreenWith, offset.y);
        [self changeUnderLineFrame: [self.topTabbar.subviews lastObject]];
    }];
}


#pragma mark - <UIScrollView>
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if(scrollView != self.contentView) return;
    __weak typeof(self)weakSelf = self;
    [UIView animateWithDuration:0.25 animations:^{
        NSInteger index = scrollView.contentOffset.x / kMSScreenWith;
        UIButton * btn = weakSelf.topTabbarItems[index];
        [weakSelf changeUnderLineFrame:btn];
    }];
}


//初始化选中状态
- (void)setSelectedProvince:(NSString *)provinceName andCity:(NSString *)cityName andDistrict:(NSString *)districtName {

    for (WJAddressItem * item in self.allProvinces) {
        if ([item.region_name isEqualToString:provinceName]) {
            NSIndexPath * indexPath = [NSIndexPath indexPathForRow:[self.allProvinces indexOfObject:item] inSection:0];
            UITableView * tableView  = self.tableViews.firstObject;
            [tableView selectRowAtIndexPath:indexPath animated:NO scrollPosition:UITableViewScrollPositionMiddle];
            [self tableView:tableView didSelectRowAtIndexPath:indexPath];
            break;
        }
    }

    for (int i = 0; i < self.currentCityArray.count; i++) {
        WJAddressItem * item = self.currentCityArray[i];

        if ([item.region_name isEqualToString:cityName]) {
            NSIndexPath * indexPath = [NSIndexPath indexPathForRow:i inSection:0];
            UITableView * tableView  = self.tableViews[1];
            [tableView selectRowAtIndexPath:indexPath animated:NO scrollPosition:UITableViewScrollPositionMiddle];
            [self tableView:tableView didSelectRowAtIndexPath:indexPath];
            break;
        }
    }

    for (int i = 0; i <self.currentAreaArray.count; i++) {
        WJAddressItem * item = self.currentAreaArray[i];
        if ([item.region_name isEqualToString:districtName]) {
            NSIndexPath * indexPath = [NSIndexPath indexPathForRow:i inSection:0];
            UITableView * tableView  = self.tableViews[2];
            [tableView selectRowAtIndexPath:indexPath animated:NO scrollPosition:UITableViewScrollPositionMiddle];
            [self tableView:tableView didSelectRowAtIndexPath:indexPath];
            break;
        }
    }
}

#pragma mark - getter 方法

//分割线
- (UIView *)separateLine{

    UIView * separateLine = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kMSScreenWith, 1 / [UIScreen mainScreen].scale)];
    separateLine.backgroundColor = [UIColor colorWithRed:222/255.0 green:222/255.0 blue:222/255.0 alpha:1];
    return separateLine;
}

- (NSMutableArray *)tableViews{

    if (_tableViews == nil) {
        _tableViews = [NSMutableArray array];
    }
    return _tableViews;
}

- (NSMutableArray *)topTabbarItems{
    if (_topTabbarItems == nil) {
        _topTabbarItems = [NSMutableArray array];
    }
    return _topTabbarItems;
}


/** 所有省字典数据 */
-(NSArray *)allProvinces{
    if (!_allProvinces) {
        _allProvinces = [NSMutableArray array];
    }
    return _allProvinces;
}
/** 市名称 数组 */
-(NSMutableArray*)currentCityArray{
    if (!_currentCityArray) {
        _currentCityArray = [[NSMutableArray alloc] init];
    }
    return _currentCityArray;
}

/** 区名称 数组 */
-(NSMutableArray*)currentAreaArray{
    if (!_currentAreaArray) {
        _currentAreaArray = [[NSMutableArray alloc] init];
    }
    return _currentAreaArray;
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
