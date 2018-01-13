//
//  WJShopCartClassViewController.m
//  MHUAPP
//
//  Created by wenchengjun on 2017/11/28.
//  Copyright © 2017年 wenchengjun. All rights reserved.
//

#import "WJShopCartClassViewController.h"
#import "ShipCartCell.h"

@interface WJShopCartClassViewController ()

@end

@implementation WJShopCartClassViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [RegularExpressionsMethod ColorWithHexString:kMSVCBackgroundColor];
    if (self.isTabBar) {
        [self initSendReplyWithTitle:@"购物车" andLeftButtonName:@"ic_back.png" andRightButtonName:@"编辑" andTitleLeftOrRight:NO];
    }
    else
    {
        [self initSendReplyWithTitle:@"购物车" andLeftButtonName:nil andRightButtonName:@"编辑" andTitleLeftOrRight:NO];
    }

    self.arr_state = [NSMutableArray array];
    self.selectedState = NO;
    self.IshighBack = NO;
    [self.view addSubview:self.infoTableView];
    // Do any additional setup after loading the view.
}
-(UITableView *)infoTableView
{
    if (!_infoTableView) {
        _infoTableView =[[UITableView alloc]initWithFrame: CGRectMake(0, 0, kMSScreenWith, kMSScreenHeight-kMSNaviHight)];
        _infoTableView.delegate = self;
        _infoTableView.dataSource = self;
        _infoTableView.backgroundColor = [UIColor clearColor];
    }
    return _infoTableView;
}

-(void)viewWillAppear:(BOOL)animated
{
    [self investListRequest];
    [super viewWillAppear:YES];
}

-(void)investListRequest
{

}
- (void)refreshTableView
{
    if (0 < self.records.count)
    {
        [self.noMoreView removeFromSuperview];

    }
    else
    {

        self.infoTableView.tableHeaderView.hidden = YES;
    }
    [self.infoTableView reloadData];

}


-(void)headerRereshingCircle
{
    self.selectedState = NO;
    self.currPage = 1;
    [self investListRequest];
}

-(void)footerRereshingCircle
{
    self.selectedState = NO;
    self.currPage ++;
    [self investListRequest];
}

-(void)showright
{
    if(self.selectedState)
    {
        self.selectedState = NO;
    }
    else
        self.selectedState = YES;

    if(self.isTabBar)
    {
        if(self.selectedState)
        {
            [self addDeleteVC];
            [self initSendReplyWithTitle:@"购物车" andLeftButtonName:@"ic_back.png" andRightButtonName:@"编辑" andTitleLeftOrRight:NO];
        }
        else
        {
            [self initSendReplyWithTitle:@"购物车" andLeftButtonName:@"ic_back.png" andRightButtonName:@"完成" andTitleLeftOrRight:NO];
            [self cartEdit];
        }
    }
    else
    {
        if(self.selectedState)
        {
            [self addDeleteVC];
            [self initSendReplyWithTitle:@"购物车" andLeftButtonName:nil andRightButtonName:@"编辑" andTitleLeftOrRight:NO];
        }
        else
        {
            [self initSendReplyWithTitle:@"购物车" andLeftButtonName:nil andRightButtonName:@"完成" andTitleLeftOrRight:NO];
            [self cartEdit];
        }
    }

    [self.infoTableView reloadData];
}
-(void)cartEdit
{
    for (int kkk=0; kkk<self.records.count; kkk++) {

        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:kkk inSection:0];
        ShipCartCell* cell = (ShipCartCell*)[self.infoTableView cellForRowAtIndexPath:indexPath];
        self.regType =1;
        NSMutableDictionary *infos = [NSMutableDictionary dictionary];
        [infos setObject:[[self.records objectAtIndex:kkk] objectForKey:@"id"] forKey:@"id"];
        [infos setObject:[NSString stringWithFormat:@"%@",cell.textf_number.text] forKey:@"goodsQuantity"];
    }
}
-(void)addDeleteVC
{

    [self.lab_total removeFromSuperview];
    [self.btn_settlement removeFromSuperview];
    if (self.IshighBack) {
        [self.btn_selectAll setImage:[UIImage imageNamed:@"shipcart_sele.png"] forState:UIControlStateNormal];
    }
    else
    {
        [self.btn_selectAll setImage:[UIImage imageNamed:@"shipcart_total_selehigh.png"] forState:UIControlStateNormal];
    }

    self.lab_selectAll = [[UILabel alloc]initWithFrame:CGRectMake(40, 9, 150, 22)];
    self.lab_selectAll.textColor = [UIColor whiteColor];
    self.lab_selectAll.text = @"Select all";
    self.lab_selectAll.font = [UIFont systemFontOfSize:14.0f];
    [self.settlementV addSubview:self.lab_selectAll];


    self.btn_delete = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.btn_delete setFrame:CGRectMake(kMSScreenWith-120, 0, 120, 44)];
    self.btn_delete.titleLabel.font = [UIFont systemFontOfSize:14.0f];
    [self.btn_delete setBackgroundColor:[UIColor clearColor]];
    [self.btn_delete setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.btn_delete setTitle:@"Delete" forState:UIControlStateNormal];
    [self.btn_delete addTarget:self action:@selector(deleteCart) forControlEvents:UIControlEventTouchUpInside];
    [self.settlementV addSubview:self.btn_delete];

    [self.view addSubview:self.settlementV];
}
-(void)stateChanege
{
    float TotalPrice = 0 ;
    int settlementNUM = 0 ;
    for (int kkk=0; kkk<self.records.count; kkk++) {

        NSString *indexpathState = [self.arr_state objectAtIndex:kkk];
        if ([indexpathState isEqual: @"1"])
        {
            TotalPrice =  [[[self.records objectAtIndex:kkk] objectForKey:@"goodsQuantity"]  floatValue]*[[[self.records objectAtIndex:kkk] objectForKey:@"skuPrice"] floatValue] +TotalPrice;

            settlementNUM++;
        }
    }
    self.lab_total.text =[NSString stringWithFormat:@"Total:$%.2f",TotalPrice];
    [self.btn_settlement setTitle:[NSString stringWithFormat:@"Checkout(%d)" ,settlementNUM] forState:UIControlStateNormal];
}
-(void)deleteCart
{
    NSMutableArray *cartId = [NSMutableArray array];
    int settlementNUM = 0 ;
    for (int kkk=0; kkk<self.records.count; kkk++) {

        NSString *indexpathState = [self.arr_state objectAtIndex:kkk];
        if ([indexpathState isEqual: @"1"])
        {
            NSLog(@"执行了 %d 次",kkk);
            [cartId addObject:[[self.records objectAtIndex:kkk] objectForKey:@"id"]];
            settlementNUM++;
        }
        NSLog(@"没有执行 %d 次",kkk);
    }
    if(settlementNUM>0)
    {

        NSMutableDictionary *infos = [NSMutableDictionary dictionary];
        if (settlementNUM ==1) {
            [infos setObject:[cartId objectAtIndex:0] forKey:@"ids"];
        } else {
            NSMutableString *borrowway = [NSMutableString string];
            borrowway = [cartId objectAtIndex:0];
            for (int i = 1; i < cartId.count; i++)
            {   // 1,3,4,5
                borrowway = [NSMutableString stringWithFormat:@"%@,%@",borrowway,[cartId objectAtIndex:i]];
            }
            [infos setObject:borrowway forKey:@"ids"];

        }
    }
    else
    {

        return;
    }
}
-(void)addsettlementVC
{
    [self.settlementV removeFromSuperview];
    [self.lab_selectAll removeFromSuperview];
    [self.btn_delete removeFromSuperview];
    self.settlementV = [[UIView alloc]initWithFrame:CGRectMake(0, kMSScreenHeight-kMSNaviHight-kMSNaviHight-44, kMSScreenWith, 44)];
    self.settlementV.backgroundColor =kMSViewBackColor;

    UIImageView *imgtotal = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kMSScreenWith-120, 44)];
    imgtotal.backgroundColor = kMSNavBarBackColor;
    [self.settlementV addSubview:imgtotal];

    UIImageView *imgCheckout = [[UIImageView alloc]initWithFrame:CGRectMake(kMSScreenWith-120, 0,120 , 44)];
    imgCheckout.backgroundColor = [UIColor redColor];
    [self.settlementV addSubview:imgCheckout];

    self.btn_selectAll = [UIButton buttonWithType:UIButtonTypeCustom];
    if (self.IshighBack) {
        [self.btn_selectAll setImage:[UIImage imageNamed:@"shipcart_sele.png"] forState:UIControlStateNormal];
    }
    else
    {
        [self.btn_selectAll setImage:[UIImage imageNamed:@"shipcart_total_selehigh.png"] forState:UIControlStateNormal];
    }
    [self.btn_selectAll addTarget:self action:@selector(selectAllShop:) forControlEvents:UIControlEventTouchUpInside];
    [self.btn_selectAll setFrame:CGRectMake(5, 7, 30, 30)];
    [self.settlementV addSubview:self.btn_selectAll];

    self.lab_total = [[UILabel alloc]initWithFrame:CGRectMake(40, 12, kMSScreenWith-160, 20)];
    self.lab_total.textColor = [UIColor whiteColor];
    self.lab_total.text = @"Total:$5800.00";
    self.lab_total.font = [UIFont systemFontOfSize:14.0f];
    [self.settlementV addSubview:self.lab_total];



    self.btn_settlement = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.btn_settlement setFrame:CGRectMake(kMSScreenWith-120, 0, 120, 44)];
    [self.btn_settlement setBackgroundColor:[UIColor clearColor]];
    [self.btn_settlement setTitle:[NSString stringWithFormat:@"Checkout(%ld)" ,self.records.count] forState:UIControlStateNormal];
    self.btn_settlement.titleLabel.font = [UIFont systemFontOfSize:14.0f];
    [self.btn_settlement setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];

    [self.btn_settlement addTarget:self action:@selector(gotoConfirmOrder) forControlEvents:UIControlEventTouchUpInside];
    [self.settlementV addSubview:self.btn_settlement];
    float TotalPrice = 0 ;
    for (int lll=0; lll<self.records.count; lll++) {
        TotalPrice =  [[[self.records objectAtIndex:lll] objectForKey:@"goodsQuantity"] floatValue]*[[[self.records objectAtIndex:lll] objectForKey:@"skuPrice"] floatValue]+TotalPrice;
    }
    self.lab_total.text =[NSString stringWithFormat:@"Total:$%.2f",TotalPrice];
    self.strprice = [NSString stringWithFormat:@"$%.2f",TotalPrice];
    [self.view addSubview:self.settlementV];
}
-(void)selectAllShop:(UIButton *)sender
{
    UIImage *currImage = [sender currentImage];
    if ([currImage isEqual:[UIImage imageNamed:@"shipcart_total_selehigh.png"]])
    {
        self.IshighBack = YES;
        [sender setImage:[UIImage imageNamed:@"shipcart_sele.png"] forState:UIControlStateNormal];
        for (int kkk=0; kkk<self.records.count; kkk++) {

            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:kkk inSection:0];
            ShipCartCell* cell = (ShipCartCell*)[self.infoTableView cellForRowAtIndexPath:indexPath];
            [cell.btn_select setImage:[UIImage imageNamed:@"shipcart_sele.png"] forState:UIControlStateNormal];
            [self.arr_state replaceObjectAtIndex:kkk withObject:@"0"];
        }
        [self.infoTableView reloadData];
    }
    else
    {
        self.IshighBack = NO;
        [sender setImage:[UIImage imageNamed:@"shipcart_total_selehigh.png"] forState:UIControlStateNormal];
        for (int kkk=0; kkk<self.records.count; kkk++) {

            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:kkk inSection:0];
            ShipCartCell* cell = (ShipCartCell*)[self.infoTableView cellForRowAtIndexPath:indexPath];
            [cell.btn_select setImage:[UIImage imageNamed:@"shipcart_seleHigh.png"] forState:UIControlStateNormal];
            [self.arr_state replaceObjectAtIndex:kkk withObject:@"1"];
        }
        [self.infoTableView reloadData];
    }
    [self stateChanege];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)gotoConfirmOrder
{

}

#pragma mark - UITableViewDelegate UITableViewDataSource Methods
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //    return self.records.count;
    return 4;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 95.f;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIndentifier = @"shipCartCell";
    ShipCartCell *cell = (ShipCartCell *)[tableView dequeueReusableCellWithIdentifier:CellIndentifier];
    if (cell == nil)
    {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"ShipCartCell" owner:self options:nil] lastObject];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;

    NSString *titlemessage = [[self.records objectAtIndex:indexPath.row] objectForKey:@"skuName"];
    if([self contentCellHeightWithText:titlemessage]>20)
        cell.lab_title.frame = CGRectMake(cell.lab_title.frame.origin.x, cell.lab_title.frame.origin.y, cell.lab_title.frame.size.width, 41);
    cell.lab_title.numberOfLines = 2;
    cell.lab_title.text = titlemessage;
    //    cell.textf_number.text = cell.lab_quantity.text =[NSString stringWithFormat:@"%@", [[self.records objectAtIndex:indexPath.row] objectForKey:@"goodsQuantity"]];
    NSURL *url=[NSURL URLWithString:[NSString stringWithFormat:@"%@",[[self.records objectAtIndex:indexPath.row]objectForKey:@"goodsImg"]]];

    NSString *text =[NSString stringWithFormat:@"$%@ x %@", [[self.records objectAtIndex:indexPath.row] objectForKey:@"skuPrice"],[[self.records objectAtIndex:indexPath.row] objectForKey:@"goodsQuantity"]];

    NSMutableAttributedString *source=[[NSMutableAttributedString alloc] initWithString:text];
    NSRange range = [text rangeOfString:@"x"];
    [source addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:NSMakeRange(range.location,1)];
    cell.lab_price.attributedText=source;
    if(!self.selectedState)
    {
        cell.vie_addOr.hidden = YES;
        cell.vie_price.hidden = NO;
    }
    else
    {
        cell.vie_addOr.hidden = NO;
        cell.vie_price.hidden = YES;
        [cell.textf_number.layer setBorderWidth:1];
        cell.textf_number.layer.borderColor = kMSViewBorderColor;   //设置边框
        cell.btn_subtract.tag = indexPath.row;
        [cell.btn_subtract addTarget:self action:@selector(quantitySubtractChange:) forControlEvents:UIControlEventTouchUpInside];
        cell.btn_add.tag = indexPath.row;
        [cell.btn_add addTarget:self action:@selector(quantityAddChange:) forControlEvents:UIControlEventTouchUpInside];
    }
    //    if ([[self.arr_state objectAtIndex:indexPath.row] isEqualToString:@"1"]) {
    //        [cell.btn_select setImage:[UIImage imageNamed:@"shipcart_seleHigh.png"] forState:UIControlStateNormal];
    //    }
    //    else
    //    {
    //        [cell.btn_select setImage:[UIImage imageNamed:@"user_weigouxuan.png"] forState:UIControlStateNormal];
    //    }

    cell.btn_select.tag = indexPath.row;
    [cell.btn_select addTarget:self action:@selector(changeShipCart:) forControlEvents:UIControlEventTouchUpInside];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //    ShipInfoClassViewController *shopdepinfoVC =[[ShipInfoClassViewController alloc]init];
    //    shopdepinfoVC.goodsid = [NSString stringWithFormat:@"%@",[[self.records objectAtIndex:indexPath.row]objectForKey:@"goodsId"]];
    //    [self.navigationController pushViewController:shopdepinfoVC animated:YES];
}
-(void)changeShipCart:(UIButton *)sender
{
    UIImage *currImage = [sender currentImage];
    if ([currImage isEqual:[UIImage imageNamed:@"shipcart_seleHigh.png"]])
    {
        self.IshighBack = YES;
        [sender setImage:[UIImage imageNamed:@"user_weigouxuan.png"] forState:UIControlStateNormal];
        //        [self.arr_state replaceObjectAtIndex:sender.tag withObject:@"0"];
        [self.btn_selectAll setImage:[UIImage imageNamed:@"shipcart_sele.png"] forState:UIControlStateNormal];
        [self.infoTableView reloadData];
    }
    else
    {
        [sender setImage:[UIImage imageNamed:@"shipcart_seleHigh.png"] forState:UIControlStateNormal];
        //        [self.arr_state replaceObjectAtIndex:sender.tag withObject:@"1"];
        int aaa=0;
        for (int kkk=0; kkk<self.records.count; kkk++) {

            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:kkk inSection:0];
            ShipCartCell* cell = (ShipCartCell*)[self.infoTableView cellForRowAtIndexPath:indexPath];
            UIImage *currImage = [cell.btn_select currentImage];
            if ([currImage isEqual:[UIImage imageNamed:@"user_weigouxuan.png"]])
            {
                aaa++;
            }
        }
        if(aaa==0)
        {
            self.IshighBack = NO;
            [self.btn_selectAll setImage:[UIImage imageNamed:@"shipcart_total_selehigh.png"] forState:UIControlStateNormal];
        }
        else
        {
            self.IshighBack = YES;
            [self.btn_selectAll setImage:[UIImage imageNamed:@"shipcart_sele.png"] forState:UIControlStateNormal];
        }
        [self.infoTableView reloadData];
    }
    [self stateChanege];
}
-(CGFloat)contentCellHeightWithText:(NSString*)text

{
    NSInteger ch;

    UIFont *font = [UIFont systemFontOfSize:14.0];// 一定要跟label的显示字体大小一致

    //设置字体

    CGSize size = CGSizeMake(198, NSIntegerMax);//注：这个宽：198 是你要显示的宽度既固定的宽度，高度可以依照自己的需求而定

        NSDictionary * tdic = [NSDictionary dictionaryWithObjectsAndKeys:font, NSFontAttributeName,nil];
        size =[text boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin |NSStringDrawingUsesFontLeading attributes:tdic context:nil].size;
    ch = size.height;

    return ch;

}
-(void)quantitySubtractChange:(UIButton *)sender
{
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:sender.tag inSection:0];
    ShipCartCell* cell = (ShipCartCell*)[self.infoTableView cellForRowAtIndexPath:indexPath];
    NSInteger quantity = [cell.textf_number.text integerValue];
    if (quantity>1) {
        quantity--;
    }
    else
    {
        quantity=1;
    }
    cell.textf_number.text = [NSString stringWithFormat:@"%ld",quantity];
}
-(void)quantityAddChange:(UIButton *)sender
{
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:sender.tag inSection:0];
    ShipCartCell* cell = (ShipCartCell*)[self.infoTableView cellForRowAtIndexPath:indexPath];
    NSInteger quantity = [cell.textf_number.text integerValue];
    quantity++;
    cell.textf_number.text = [NSString stringWithFormat:@"%ld",quantity];
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
