//
//  AddAddressViewController.m
//
//  Created by wenchengjun on 14-12-29.
//
//

#import "AddAddressViewController.h"
#import "DeliveryAddressViewController.h"
#import "AddressCell.h"
#import "WJAddressItem.h"

#import "UITableView+FDTemplateLayoutCell.h"

@interface AddAddressViewController ()
// The response from server
@property (strong , nonatomic) NSMutableArray <WJAddressItem *> *records;

@end

@implementation AddAddressViewController


-(void)viewWillAppear:(BOOL)animated
{
    [self addInitList];
    [super viewWillAppear:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBarHidden = NO;
    self.view.backgroundColor = [RegularExpressionsMethod ColorWithHexString:kMSVCBackgroundColor];
    [self initSendReplyWithTitle:@"地址管理" andLeftButtonName:@"ic_back.png" andRightButtonName:nil andTitleLeftOrRight:YES];
    
    self.infoTableView =[[UITableView alloc]initWithFrame: CGRectMake(0, 0, kMSScreenWith, kMSScreenHeight-kMSNaviHight)];
    self.infoTableView.delegate = self;
    self.infoTableView.dataSource = self;
      self.infoTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.infoTableView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:self.infoTableView];
    self.selectedState = NO;

    UIButton *buttonAdd = [[UIButton alloc]initWithFrame:CGRectMake(0, kMSScreenHeight-kMSNaviHight-kTabBarHeight, kMSScreenWith, 49)];
    buttonAdd.backgroundColor = [RegularExpressionsMethod ColorWithHexString:BASEPINK];
    buttonAdd.titleLabel.textColor = [UIColor whiteColor];
    [buttonAdd setTitle:@"新增收货地址" forState:UIControlStateNormal] ;
    [buttonAdd addTarget:self action:@selector(gotodelivreyVC) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:buttonAdd];
    [[NSNotificationCenter defaultCenter] addObserver:self
     
                                             selector:@selector(addInitList)
                                                 name:@"addInitList"
                                               object:nil];

    // Do any additional setup after loading the view.
}
-(void)gotodelivreyVC
{
    DeliveryAddressViewController *deliverVC = [[DeliveryAddressViewController alloc]init];
    deliverVC.ADDorChange = YES;
    self.hidesBottomBarWhenPushed = YES;
    [SVProgressHUD dismiss];
    [self.navigationController pushViewController:deliverVC animated:YES];
}


-(void)addInitList
{
    self.regType = 0;
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSString *uid = [[userDefaults objectForKey:@"userList"] objectForKey:@"uid" ];
    [userDefaults synchronize];
    NSMutableDictionary *infos = [NSMutableDictionary dictionary];
    [infos setValue:uid forKey:@"user_id"];
    [self requestAPIWithServe:[kMSBaseLargeCollectionPortURL stringByAppendingString:kMSAddressGetsite] andInfos:infos];
}
- (void)refreshTableView
{
    if (0 < self.records.count)
    {
        self.infoTableView.tableHeaderView.hidden = NO;
    }
    else
    {
        self.infoTableView.tableHeaderView.hidden = YES;
    }
    [self.infoTableView reloadData];
    
}

-(void)processData
{
    if([[self.results objectForKey:@"code"] integerValue] == 200)
    {
        if (self.regType==0) {
             NSArray *arr = [self.results objectForKey:@"data"];
            if (arr&&arr.count>0) {
                [self.records removeAllObjects];
                self.records = [WJAddressItem mj_objectArrayWithKeyValuesArray:arr];
                [self.noMoreView hide];
                [self.infoTableView reloadData];
            }
            else
            {
                self.records = nil ;
                self.noMoreView = [[NOMoreDataView alloc]initWithFrame:CGRectMake(0, 0, kMSScreenWith, 300) withContent:@"暂无地址" withNODataImage:@"default_nomore.png"];
                self.infoTableView.tableHeaderView.hidden = NO;
                [self.infoTableView addSubview:self.noMoreView];
            }
        }
     else if(self.regType==1)
     {
         [self addInitList];
      }
        else if(self.regType==2)
        {
             [self addInitList];
            [self jxt_showAlertWithTitle:@"消息提示" message:@"删除成功" appearanceProcess:^(JXTAlertController * _Nonnull alertMaker) {
                alertMaker.toastStyleDuration = 1;
            } actionsBlock:NULL];

        }

    }
    else
    {
        [SVProgressHUD showErrorWithStatus:[self
                                            .results objectForKey:@"msg"]];
    }
}
#pragma mark - UITableViewDelegate UITableViewDataSource Methods
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.records.count;
}


#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 114;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIndentifier = @"shipCartCell";
    AddressCell *cell = (AddressCell *)[tableView dequeueReusableCellWithIdentifier:CellIndentifier];
    if (cell == nil)
    {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"AddressCell" owner:self options:nil] lastObject];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.addressItem = self.records[indexPath.row];
    cell.btn_edit.tag = indexPath.row;
    [cell.btn_edit addTarget:self action:@selector(editAddressBookForCell:) forControlEvents:UIControlEventTouchUpInside];

//    [cell.btn_Delete.layer setBorderWidth:1];
//     [cell.btn_Delete.layer setBorderColor:kMSViewBorderColor];
    cell.btn_Delete.tag = indexPath.row;
    [cell.btn_Delete addTarget:self action:@selector(deleteCellIndexpathAddress:) forControlEvents:UIControlEventTouchUpInside];

    if( [self.records[indexPath.row].is_default integerValue]==1)
    {
        [cell.btn_setting setImage:[UIImage imageNamed:@"shipcart_seleHigh.png"] forState:UIControlStateNormal];
    }
    else
    {
        [cell.btn_setting setImage:[UIImage imageNamed:@"user_weigouxuan.png"] forState:UIControlStateNormal];
    }
    cell.btn_setting.tag = indexPath.row;
    [cell.btn_setting addTarget:self action:@selector(changeShipCart:) forControlEvents:UIControlEventTouchUpInside];
    return cell;
}
-(void)changeShipCart:(UIButton *)sender
{
    UIImage *currImage = [sender currentImage];
    if ([currImage isEqual:[UIImage imageNamed:@"shipcart_seleHigh.png"]])
    {
        return;
    }
    
    else
    {
        self.regType = 1;
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        NSString *uid = [[userDefaults objectForKey:@"userList"] objectForKey:@"uid" ];
        [userDefaults synchronize];
        NSMutableDictionary *infos = [NSMutableDictionary dictionary];
        [infos setValue:uid forKey:@"user_id"];
        [infos setValue:[NSString stringWithFormat:@"%@",[self.records objectAtIndex:sender.tag].site_id] forKey:@"site_id"];
        [self requestAPIWithServe:[kMSBaseLargeCollectionPortURL stringByAppendingString:kMSAddressChangeDefault] andInfos:infos];
//        for (int kkk=0; kkk<4; kkk++) {
//
//            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:kkk inSection:0];
//            AddressCell* cell = (AddressCell*)[self.infoTableView cellForRowAtIndexPath:indexPath];
//            if(kkk==sender.tag)
//            {
//                [sender setImage:[UIImage imageNamed:@"shipcart_seleHigh.png"] forState:UIControlStateNormal];
//            }
//            else
//            {
//            [cell.btn_setting setImage:[UIImage imageNamed:@"user_weigouxuan.png"] forState:UIControlStateNormal];
//            }
//        }

    }
}
-(void)deleteCellIndexpathAddress:(UIButton *)sender
{
    [self jxt_showAlertWithTitle:nil message:@"移除收货地址?" appearanceProcess:^(JXTAlertController * _Nonnull alertMaker) {
        alertMaker.
        addActionCancelTitle(@"取消").
        addActionDestructiveTitle(@"移除");
    } actionsBlock:^(NSInteger buttonIndex, UIAlertAction * _Nonnull action, JXTAlertController * _Nonnull alertSelf) {
        if (buttonIndex == 0) {
            NSLog(@"cancel");
        }
        else if (buttonIndex == 1) {
            self.regType = 2;
            NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
            NSString *uid = [[userDefaults objectForKey:@"userList"] objectForKey:@"uid" ];
            [userDefaults synchronize];
            NSMutableDictionary *infos = [NSMutableDictionary dictionary];
            [infos setValue:uid forKey:@"uid"];
            [infos setValue:[NSString stringWithFormat:@"%@",[self.records objectAtIndex:sender.tag].site_id] forKey:@"site_id"];
            [infos setValue:@"delete" forKey:@"type"];
            [self requestAPIWithServe:[kMSBaseLargeCollectionPortURL stringByAppendingString:kMSAddressChangeType] andInfos:infos];
        }
        NSLog(@"%@--%@", action.title, action);
    }];

}



-(CGFloat)contentCellHeightWithText:(NSString*)text

{
    NSInteger ch;
    UIFont *font = [UIFont systemFontOfSize:13.0];// 一定要跟label的显示字体大小一致
    //设置字体
    
    CGSize size = CGSizeMake(304, NSIntegerMax);//注：这个宽：200 是你要显示的宽度既固定的宽度，高度可以依照自己的需求而定

    NSDictionary * tdic = [NSDictionary dictionaryWithObjectsAndKeys:font, NSFontAttributeName,nil];
    size =[text boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin |NSStringDrawingUsesFontLeading attributes:tdic context:nil].size;

    ch = size.height;
    return ch;
    
}
-(void)editAddressBookForCell:(UIButton *)sender
{
    DeliveryAddressViewController *deliverVC = [[DeliveryAddressViewController alloc]init];
    deliverVC.str_provinceName = [NSString stringWithFormat:@"%@",[self.records objectAtIndex:sender.tag].province];
    deliverVC.str_cityName = [NSString stringWithFormat:@"%@",[self.records objectAtIndex:sender.tag].city];
    deliverVC.str_district = [NSString stringWithFormat:@"%@",[self.records objectAtIndex:sender.tag].district];
    deliverVC.str_address = [NSString stringWithFormat:@"%@",[self.records objectAtIndex:sender.tag].address];
    deliverVC.str_id = [NSString stringWithFormat:@"%@",[self.records objectAtIndex:sender.tag].site_id];
//    deliverVC.str_postCode = [NSString stringWithFormat:@"%@",[self.records objectAtIndex:sender.tag].zip_code];
    deliverVC.str_mobile = [NSString stringWithFormat:@"%@",[self.records objectAtIndex:sender.tag].mobile];
    deliverVC.str_consignee = [NSString stringWithFormat:@"%@",[self.records objectAtIndex:sender.tag].consignee];
    deliverVC.ADDorChange = NO;
    [SVProgressHUD dismiss];
    [self.navigationController pushViewController:deliverVC animated:YES];
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
   
    if (self.selectCellIndexpathYES) {
        NSMutableDictionary *dic = [NSMutableDictionary dictionary];
        [dic setValue:[self.records objectAtIndex:indexPath.row].mobile forKey:@"mobile"];
        [dic setValue:[self.records objectAtIndex:indexPath.row].consignee forKey:@"consignee"];
        [dic setValue:[self.records objectAtIndex:indexPath.row].assemble_site forKey:@"assemble_site"];
        [dic setValue:[NSString stringWithFormat:@"%@",[self.records objectAtIndex:indexPath.row].site_id] forKey:@"site_id"];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"selectAddressNote" object:self userInfo:dic];
        
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        [userDefaults setObject:dic forKey:@"userAddress"];
        [userDefaults synchronize];
        [self.navigationController popViewControllerAnimated:YES];
        return;
    }
//        AddressCell *cell=(AddressCell*)[tableView cellForRowAtIndexPath:indexPath];
//        [tableView deselectRowAtIndexPath:indexPath animated:YES];
//    NSMutableDictionary *info = [NSMutableDictionary dictionary];
//    [info setValue:cell.lab_Name.text forKey:@"name"];
//    [info setValue:cell.lab_telephone.text forKey:@"telephone"];
//    [info setValue:cell.lab_address.text forKey:@"address"];
//    [[NSNotificationCenter defaultCenter] postNotificationName:@"addressChange" object:self userInfo:info];
//    [self.navigationController popViewControllerAnimated:YES];
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
