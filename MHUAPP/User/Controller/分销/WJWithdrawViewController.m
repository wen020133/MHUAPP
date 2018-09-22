//
//  WJWithdrawViewController.m
//  MHUAPP
//
//  Created by wenchengjun on 2018/8/24.
//  Copyright © 2018年 wenchengjun. All rights reserved.
//

#import "WJWithdrawViewController.h"
#import "UIView+UIViewFrame.h"

@interface WJWithdrawViewController ()<UIImagePickerControllerDelegate,UIPrintInteractionControllerDelegate,UINavigationControllerDelegate>

@property (nonatomic,strong) UIButton *selectedBtn;

@end

@implementation WJWithdrawViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [RegularExpressionsMethod ColorWithHexString:kMSVCBackgroundColor];
    [self initSendReplyWithTitle:@"分销提现" andLeftButtonName:@"ic_back.png" andRightButtonName:nil andTitleLeftOrRight:YES];
    [self initWithdrawView];
    // Do any additional setup after loading the view from its nib.
}

-(void)initWithdrawView
{
    UIImageView *headBV = ImageViewInit(0, 0, kMSScreenWith, 100);
    headBV.backgroundColor = kMSNavBarBackColor;
    [self.scr_withdraw addSubview:headBV];
    
    UILabel *labZHYE = LabelInit(DCMargin, 20, 200, 20);
    labZHYE.textColor = [UIColor whiteColor];
    labZHYE.text = @"可提现金额";
    labZHYE.font = Font(13);
    [self.scr_withdraw addSubview:labZHYE];
    
    self.labAmount = LabelInit(DCMargin, 50, 200, 40);
    self.labAmount.textColor = kMSCellBackColor;
    self.labAmount.font = Font(30);
    self.labAmount.text = @"0.00元";
    [self.scr_withdraw addSubview:self.labAmount];
    
    _btn_WX = [[UIButton alloc]initWithFrame:CGRectMake(kMSScreenWith/9, headBV.Bottom+20, kMSScreenWith/3, kMSScreenWith/9+3)];
    _btn_WX.tag = 1000;
    [_btn_WX setBackgroundImage:[UIImage imageNamed:@"user_fenxiaoWX.png"] forState:UIControlStateNormal];
    [_btn_WX setBackgroundImage:[UIImage imageNamed:@"user_fenxiaoWXSelect.png"] forState:UIControlStateSelected];
    [_btn_WX addTarget:self action:@selector(titleBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.scr_withdraw addSubview:_btn_WX];
    
    _btn_ZFB = [[UIButton alloc]initWithFrame:CGRectMake(kMSScreenWith/9*5, headBV.Bottom+20, kMSScreenWith/3, kMSScreenWith/9+3)];
    _btn_ZFB.tag = 1001;
    [_btn_ZFB setBackgroundImage:[UIImage imageNamed:@"user_fenxiaoZFB.png"] forState:UIControlStateNormal];
    [_btn_ZFB setBackgroundImage:[UIImage imageNamed:@"user_fenxiaoZFBSelect.png"] forState:UIControlStateSelected];
    [_btn_ZFB addTarget:self action:@selector(titleBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.scr_withdraw addSubview:_btn_ZFB];
  
    self.view_downUp.frame = CGRectMake(0, _btn_ZFB.Bottom+10, kMSScreenWith, 564);
    [self.scr_withdraw addSubview:self.view_downUp];
    
    self.scr_withdraw.contentSize = CGSizeMake(kMSScreenWith, 564+200);
}

-(void)titleBtnClick:(UIButton *)sender
{
    if (sender.tag==1000) {
        _btn_WX.selected = !_btn_WX.selected;
        _btn_ZFB.selected = NO;
        _payment = @"2";
    }
    else
    {
        _btn_ZFB.selected = !_btn_ZFB.selected;
        _btn_WX.selected = NO;
        _payment = @"1";
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

- (IBAction)allDraw:(id)sender {
    self.textF_money.text =self.str_distributionMoney;
}
- (IBAction)depositDrow:(id)sender {
    if(self.payment.length==0)
    {
        [self requestFailed:@"请选择收款方式！"];
        return;
    }
    if (self.textF_money.text.length==0) {
        [self requestFailed:@"请填写金额"];
        return;
    }
    if (self.textF_account.text.length==0) {
        [self requestFailed:@"请填写收款账号"];
        return;
    }
    if (self.textV_message.text.length==0) {
        [self requestFailed:@"请填写备注"];
        return;
    }
    if (![RegularExpressionsMethod validateMobile:self.textF_moble.text]) {
        [self requestFailed:@"请填写正确的手机号"];
        return;
    }
    if (self.textF_realName.text.length==0) {
        [self requestFailed:@"请填写真实姓名"];
        return;
    }
    UIImage *imageplus= [UIImage imageNamed:@"plus"];
    if ([UIImagePNGRepresentation(_img_moneyContent.image) isEqual:UIImagePNGRepresentation(imageplus)])
    {
        [self requestFailed:@"请上传收款二维码！"];
        return;
    }
//    if (UIImagePNGRepresentation(self.img_moneyContent.image) == nil&&UIImageJPEGRepresentation(self.img_moneyContent.image, 1)==nil) {
//    }
    NSString *str_ext;
    if (UIImagePNGRepresentation(_img_moneyContent.image))
    {
        str_ext = @"png";
    }else{
        str_ext = @"jpg";
    }
    NSData *data = [self resetSizeOfImageData:_img_moneyContent.image maxSize:256];
    [self initCircleClassDataCount:data addImageSuffix:str_ext];

}
- (IBAction)upImagePhoto:(id)sender {
    
    [self jxt_showActionSheetWithTitle:@"选择图片" message:@"" appearanceProcess:^(JXTAlertController * _Nonnull alertMaker) {
        alertMaker.
        addActionCancelTitle(@"取消").
        addActionDestructiveTitle(@"相册选取").
        addActionDefaultTitle(@"拍照");
    } actionsBlock:^(NSInteger buttonIndex, UIAlertAction * _Nonnull action, JXTAlertController * _Nonnull alertSelf) {
        
        if ([action.title isEqualToString:@"取消"]) {
            NSLog(@"cancel");
        }
        else if ([action.title isEqualToString:@"相册选取"]) {
            if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary])
            {
                NSUInteger sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
                UIImagePickerController *picker=[[UIImagePickerController alloc] init];
                picker.delegate=self;
                picker.allowsEditing=NO;
                sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
                picker.sourceType=UIImagePickerControllerSourceTypePhotoLibrary;
                [self presentViewController:picker animated:YES completion:^{}];
            }
            else
            {
                [SVProgressHUD showErrorWithStatus:@"请在设置-隐私-照片对APP授权"];
            }
        }
        else if ([action.title isEqualToString:@"拍照"]) {
            NSLog(@"拍照");
            UIImagePickerController *picker=[[UIImagePickerController alloc] init];
            picker.delegate=self;
            picker.allowsEditing=NO;
            NSUInteger sourceType = UIImagePickerControllerSourceTypeCamera;
            // 判断是否支持相机
            if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
            {
                sourceType = UIImagePickerControllerSourceTypeCamera;
                picker.sourceType=UIImagePickerControllerSourceTypeCamera;
                [self presentViewController:picker animated:YES completion:^{}];
            }
            else
            {
                [SVProgressHUD showErrorWithStatus:@"请在设置-隐私-照片对APP授权"];
            }
        }
        
    }];
    
    
}



- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}
#pragma mark -
#pragma mark UIImagePickerController Method
//完成拍照
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    [picker dismissViewControllerAnimated:YES completion:^{}];
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    
    
    [self.img_moneyContent setImage:image];
//    NSData *data = [self resetSizeOfImageData:image maxSize:256];
//    [self initCircleClassDataCount:data addImageSuffix:str_ext];
}

-(void)initCircleClassDataCount:(NSData *)data addImageSuffix:(NSString *)ext
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSString *uid = [[userDefaults objectForKey:@"userList"] objectForKey:@"uid" ];
    NSArray *arr= [NSArray arrayWithObject:data];
    NSMutableDictionary *infos = [NSMutableDictionary dictionary];
    [infos setValue:uid forKey:@"user_id"];
    [infos setValue:_payment forKey:@"payment"];
    [infos setValue:@"1" forKey:@"surplus_type"];
    [infos setValue:self.textF_realName.text forKey:@"real_name"];
    [infos setValue:self.textF_account.text forKey:@"account_name"];
    [infos setValue:self.textV_message.text forKey:@"user_note"];
    [infos setValue:self.textF_money.text forKey:@"amount"];
    [infos setValue:self.textF_moble.text forKey:@"phone"];
    
     [self requestAPIWithServe:[kMSBaseLargeCollectionPortURL stringByAppendingString:kMSDeposit] andInfos:infos andImageDataArr:arr andImageName:@"pic"];
}
-(void)processData
{
    if([[self.results objectForKey:@"code"] integerValue] == 200)
    {
        [self jxt_showActionSheetWithTitle:@"提现申请成功" message:@"请等待工作人审核" appearanceProcess:^(JXTAlertController * _Nonnull alertMaker) {
            alertMaker.
            addActionCancelTitle(@"确定");
        } actionsBlock:^(NSInteger buttonIndex, UIAlertAction * _Nonnull action, JXTAlertController * _Nonnull alertSelf) {
            
            if ([action.title isEqualToString:@"确定"]) {
                [self.navigationController popViewControllerAnimated:YES];
            }
        }];
    }
    else
    {
        [self requestFailed:self.results[@"msg"]];
        return;
    }
}

@end
