//
//  WJPostBackOrderViewController.m
//  MHUAPP
//
//  Created by jinri on 2018/5/30.
//  Copyright © 2018年 wenchengjun. All rights reserved.
//

#import "WJPostBackOrderViewController.h"

@interface WJPostBackOrderViewController ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation WJPostBackOrderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [RegularExpressionsMethod ColorWithHexString:kMSVCBackgroundColor];
    [self initSendReplyWithTitle:@"申请退款" andLeftButtonName:@"ic_back.png" andRightButtonName:nil andTitleLeftOrRight:YES];

    // Do any additional setup after loading the view.
}
-(void)postbackOderData
{
    NSMutableDictionary *infos = [NSMutableDictionary dictionary];
    [self requestAPIWithServe:[kMSBaseLargeCollectionPortURL stringByAppendingString:kMSPostBackOrder] andInfos:infos];
}

-(void)processData
{
    if([[self.results objectForKey:@"code"] integerValue] == 200)
    {
    }
    else
    {
        [self requestFailed:@"申请退款失败"];
    }
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
