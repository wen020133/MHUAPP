//
//  WJLogisticsViewController.m
//  MHUAPP
//
//  Created by jinri on 2018/5/8.
//  Copyright © 2018年 wenchengjun. All rights reserved.
//

#import "WJLogisticsViewController.h"
#import "WJLogisticsView.h"
#import "WJLogisticsModel.h"


@interface WJLogisticsViewController ()

@property (nonatomic,strong) NSMutableArray * dataArry;

@end

@implementation WJLogisticsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [RegularExpressionsMethod ColorWithHexString:kMSVCBackgroundColor];
    [self initSendReplyWithTitle:@"物流信息" andLeftButtonName:@"ic_back.png" andRightButtonName:nil andTitleLeftOrRight:YES];
    
    self.dataArry = [NSMutableArray array];
    _shipping_name = @"中通速递";
    _invoice_no = @"490850486931";
    [self getMiYouMeiQuery];
    // Do any additional setup after loading the view.
}

-(void)getMiYouMeiQuery
{
    NSMutableDictionary *infos = [NSMutableDictionary dictionary];
    [infos setObject:_shipping_name forKey:@"shipping_name"];
    [infos setObject:_invoice_no forKey:@"invoice_no"];
    [self requestAPIWithServe:[kMSBaseMiYoMeiPortURL stringByAppendingString:kMSMiYoMeiQuery] andInfos:infos];
}
-(void)processData
{
    if ([_shipping_name isEqualToString:@"顺丰速运"]||[_shipping_name isEqualToString:@"申通速递"]||[_shipping_name isEqualToString:@"百世快递"]) {
        NSArray *arr_Traces = [[self.results objectForKey:@"result"] objectForKey:@"list"];
        if (arr_Traces&&arr_Traces.count>0) {
            for (NSDictionary *dic in arr_Traces) {

                    WJLogisticsModel *modelL = [[WJLogisticsModel alloc]init];
                    modelL.dsc = [dic objectForKey:@"remark"];
                    modelL.date = [dic objectForKey:@"datetime"];
                    [self.dataArry addObject:modelL];
                }
                //数组倒序
                self.dataArry = (NSMutableArray *)[[self.dataArry reverseObjectEnumerator]allObjects];
                WJLogisticsView *logisView = [[WJLogisticsView alloc]initWithDatas:_dataArry];
                // 给headView赋值
                switch ([[self.results objectForKey:@"status"] intValue]) {
                    case 1:
                        logisView.wltype = @"已签收";
                        break;
                    case 2:
                        logisView.wltype = @"在途中";
                        break;
                    case 3:
                        logisView.wltype = @"已签收";
                        break;
                    case 4:
                        logisView.wltype = @"问题件";
                        break;
                    default:
                        break;
                }

                logisView.number =  [[self.results objectForKey:@"result"] objectForKey:@"no"];
                logisView.company = [[self.results objectForKey:@"result"] objectForKey:@"company"];
                logisView.imageUrl = [self LogisticsCompanyNameSelectImageName:_shipping_name];
                logisView.frame = CGRectMake(0, 0, kMSScreenWith, kMSScreenHeight-kMSNaviHight);
                [self.view addSubview:logisView];

        }
    else
    {
        [SVProgressHUD showErrorWithStatus:[self.results objectForKey:@"reason"]];
        return;
    }


    }
    else
    {
    if([[self.results objectForKey:@"Success"] integerValue] == 1)
    {
        NSArray *arr_Traces = [self.results objectForKey:@"Traces"];
        if (arr_Traces&&arr_Traces.count>0) {
            for (NSDictionary *dic in arr_Traces) {
                WJLogisticsModel *modelL = [[WJLogisticsModel alloc]init];
                modelL.dsc = [dic objectForKey:@"AcceptStation"];
                modelL.date = [dic objectForKey:@"AcceptTime"];
                [self.dataArry addObject:modelL];
            }
            //数组倒序
            self.dataArry = (NSMutableArray *)[[self.dataArry reverseObjectEnumerator]allObjects];
            WJLogisticsView *logisView = [[WJLogisticsView alloc]initWithDatas:_dataArry];
            // 给headView赋值
            switch ([[self.results objectForKey:@"State"] intValue]) {
                case 2:
                    logisView.wltype = @"在途中";
                    break;
                case 3:
                     logisView.wltype = @"已签收";
                    break;
                case 4:
                    logisView.wltype = @"问题件";
                    break;
                default:
                    break;
            }

            logisView.number = [self.results objectForKey:@"LogisticCode"];
            logisView.company = [self.results objectForKey:@"name"];
            logisView.imageUrl = [self LogisticsCompanyNameSelectImageName:_shipping_name];
            logisView.frame = CGRectMake(0, 0, kMSScreenWith, kMSScreenHeight-kMSNaviHight);
            [self.view addSubview:logisView];

        }

    }
    else
    {
        [SVProgressHUD showErrorWithStatus:[self.results objectForKey:@"Reason"]];
        return;
    }
    }
}

-(NSString *)LogisticsCompanyNameSelectImageName:(NSString *)shippingName
{
    NSString *iamgeName;
    if ([shippingName isEqualToString:@"顺丰速运"]) {
        iamgeName = @"logistics_SF";
    }
    else if ([shippingName isEqualToString:@"百世快递"]) {
        iamgeName = @"logistics_HTKY";
    }
    else if ([shippingName isEqualToString:@"中通速递"]) {
        iamgeName = @"logistics_ZTO";
    }
    else if ([shippingName isEqualToString:@"申通快递"]) {
        iamgeName = @"logistics_STO";
    }
    else if ([shippingName isEqualToString:@"圆通速递"]) {
        iamgeName = @"logistics_YTO";
    }
    else if ([shippingName isEqualToString:@"韵达快递"]) {
        iamgeName = @"logistics_YD";
    }
    else if ([shippingName isEqualToString:@"EMS"]) {
        iamgeName = @"logistics_EMS";
    }
    else if ([shippingName isEqualToString:@"天天速递"]) {
        iamgeName = @"logistics_HHTT";
    }
    else if ([shippingName isEqualToString:@"京东物流"]) {
        iamgeName = @"logistics_JD";
    }
    else if ([shippingName isEqualToString:@"优速速递"]) {
        iamgeName = @"logistics_UC";
        
    }
    else if ([shippingName isEqualToString:@"德邦"]) {
        iamgeName = @"logistics_DBL";
    }
    else if ([shippingName isEqualToString:@"快捷速递"]) {
        iamgeName = @"logistics_FAST";
    }
    else if ([shippingName isEqualToString:@"宅急送"]) {
        iamgeName = @"logistics_ZJS";
    }
    else if ([shippingName isEqualToString:@"TNT速递"]) {
        iamgeName = @"logistics_TNT";
    }
    else if ([shippingName isEqualToString:@"邮政速递"]) {
        iamgeName = @"logistics_YZPY";
    }
    return iamgeName;

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
