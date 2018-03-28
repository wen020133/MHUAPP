//
//  WJSecondsKillViewController.m
//  MHUAPP
//
//  Created by jinri on 2018/1/4.
//  Copyright © 2018年 wenchengjun. All rights reserved.
//

#import "WJSecondsKillViewController.h"
#import "WJTimeLabel.h"
#import "MJRefresh.h"

#import "WJSecondsKissCell.h"


@interface WJSecondsKillViewController ()

@property (strong , nonatomic) WJTimeLabel *timeView;

@end

@implementation WJSecondsKillViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [RegularExpressionsMethod ColorWithHexString:kMSVCBackgroundColor];
    [self initSendReplyWithTitle:@"限时秒杀" andLeftButtonName:@"ic_back.png" andRightButtonName:nil andTitleLeftOrRight:YES];
    [self addTimeViewHead];
    // Do any additional setup after loading the view.
}

-(NSMutableArray *)arr_dateTitle
{
    if (_arr_dateTitle.count<1) {
            NSDate *now=[NSDate date];
            NSCalendar *cal=[NSCalendar currentCalendar];
            unsigned int time=NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay|NSCalendarUnitHour|NSCalendarUnitMinute|NSCalendarUnitSecond;
            NSDateComponents *t=[cal components:time fromDate:now];
            int year=(int)[t year];
            int month=(int)[t month];
            int day=(int)[t day];
        //判断当前月分的天数
        int endDate = 0;
        switch (month) {
            case 1:
            case 3:
            case 5:
            case 7:
            case 8:
            case 10:
            case 12:
                endDate = 31;
                break;
                break;
            case 4:
            case 6:
            case 9:
            case 11:
                endDate = 30;
                break;
            case 2:
                // 是否为闰年
                if (year % 400 == 0) {
                    endDate = 29;
                    break;
                } else {
                    if (year % 100 != 0 && year %4 ==4) {
                        endDate = 29;
                    } else {
                        endDate = 28;
                    }
                    break;
                }
                break;
            default:
                break;
        }

        NSDictionary *dic =  [self calculateDateWithEndDate:endDate withDay:day withMonth:month];
        NSLog(@"%@",dic);
        NSString *today = [NSString stringWithFormat:@"%@日9:00\n正在抢购",dic[@"day"]];
        NSString *tomorrow = [NSString stringWithFormat:@"%@日9:00\n即将开始",dic[@"tomorrow"]];
        NSString *afterDay = [NSString stringWithFormat:@"%@日9:00\n即将开始",dic[@"afterDay"]];
        self.arr_dateTitle = [NSMutableArray arrayWithObjects:today,tomorrow,afterDay, nil];
    }
    return _arr_dateTitle;
}
-(NSDictionary *)calculateDateWithEndDate:(int)endDate withDay:(NSInteger)day withMonth:(NSInteger)month
{
    NSInteger tomorrow = 0; //明天
    NSInteger afterDay = 0;  //后天
    NSInteger tomorrowMonth = 0;
    NSInteger afterDayMonth = 0;
    NSDate *now=[NSDate date];
    NSCalendar *cal=[NSCalendar currentCalendar];
    unsigned int time=NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay|NSCalendarUnitHour|NSCalendarUnitMinute|NSCalendarUnitSecond;
    NSDateComponents *t=[cal components:time fromDate:now];
    NSInteger currentYear=(NSInteger)[t year];
    NSInteger nextYear = currentYear;
    NSInteger lastYear = nextYear;

    if(endDate - day <= 0)
    {
        tomorrow = 1;
        afterDay = tomorrow + 1;
        tomorrowMonth = month + 1;
        if(tomorrowMonth > 12)
        {
            tomorrowMonth = 1;
            nextYear=nextYear + 1;
            lastYear = nextYear;
        }
        afterDayMonth = tomorrowMonth;
    }

    else if(endDate - day == 1)
    {
        tomorrow = endDate;
        afterDay = 1;
        tomorrowMonth = month;
        afterDayMonth = month + 1;
        if(month == 12)
        {
            afterDayMonth = 1;
            lastYear = nextYear + 1;
        }
    }

    else
    {
        tomorrow = day+1;
        afterDay = tomorrow + 1;
        tomorrowMonth = month;
        afterDayMonth = month;
    }

    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setObject:[NSNumber numberWithInteger:day] forKey:@"day"];
    [dic setObject:[NSNumber numberWithInteger:month] forKey:@"month"];
    [dic setObject:[NSNumber numberWithInteger:currentYear] forKey:@"year"];

    [dic setObject:[NSNumber numberWithInteger:tomorrow] forKey:@"tomorrow"];
    [dic setObject:[NSNumber numberWithInteger:tomorrowMonth] forKey:@"tomorrowMonth"];
    [dic setObject:[NSNumber numberWithInteger:nextYear] forKey:@"nextYear"];

    [dic setObject:[NSNumber numberWithInteger:afterDay] forKey:@"afterDay"];
    [dic setObject:[NSNumber numberWithInteger:lastYear] forKey:@"lastYear"];
    [dic setObject:[NSNumber numberWithInteger:afterDayMonth] forKey:@"afterDayMonth"];

    return dic;

}
- (void)didSelectedButtonWithTag:(NSInteger)currTag
{

}
-(void)addTimeViewHead
{
    [self.view addSubview:self.timeView];
    _timeView.secondsCountDown = 48*3600;
    [self.view addSubview:self.menuScrollView];
}

-(WJButtonNewlineScrollView *)menuScrollView
{
    if(!_menuScrollView)
    {
        _menuScrollView = [[WJButtonNewlineScrollView alloc]initWithFrame:CGRectMake(0, 0, kMSScreenWith, 50)];
        _menuScrollView.delegate = self;
        _menuScrollView.backgroundColor = [RegularExpressionsMethod ColorWithHexString:BASEPINK];
        _menuScrollView.arr_titles = self.arr_dateTitle;
        [_menuScrollView initScrollView];
    }
    return _menuScrollView;
}
-(WJTimeLabel *)timeView
{
    if (!_timeView) {
        _timeView = [[WJTimeLabel alloc]initWithFrame:CGRectMake(0, 50, kMSScreenWith, 70)];
        _timeView.backgroundColor = [RegularExpressionsMethod ColorWithHexString:kMSVCBackgroundColor];
    }
    return _timeView;
}

-(UITableView *)mainTableView
{
    if (!_mainTableView) {

        self.mainTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kMSScreenWith, kMSScreenHeight-kMSNaviHight-44)];
        self.mainTableView.backgroundColor = [UIColor clearColor];
        self.mainTableView.delegate = self;
        self.mainTableView.dataSource = self;

        [self.mainTableView registerClass:[WJSecondsKissCell class] forCellReuseIdentifier:@"WJSecondsKissCell"];
        self.mainTableView.alwaysBounceVertical = YES;

        // 下拉刷新
        self.mainTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(headerKillRereshing)];
        [self.mainTableView.mj_header beginRefreshing];

        // 上拉刷新
        self.mainTableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(footerKillRereshing)];
    }
    return _mainTableView;
}
-(void)headerKillRereshing
{

}

-(void)footerKillRereshing
{

}


#pragma mark TableViewDelegate

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    return 2;
}



-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    WJSecondsKissCell *cell = [tableView dequeueReusableCellWithIdentifier:@"WJSecondsKissCell" forIndexPath:indexPath];
    return cell;
}

- (void)firstLoadViewRefresh
{
    [self.mainTableView.mj_footer endRefreshing];
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
