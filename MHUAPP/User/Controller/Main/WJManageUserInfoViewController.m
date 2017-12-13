//
//  WJManageUserInfoViewController.m
//  MHUAPP
//
//  Created by jinri on 2017/12/12.
//  Copyright © 2017年 wenchengjun. All rights reserved.
//

#import "WJManageUserInfoViewController.h"
#import "WJUserInfoListCel.h"
#import <UIImageView+WebCache.h>

@interface WJManageUserInfoViewController ()<UIImagePickerControllerDelegate,UIPrintInteractionControllerDelegate,UINavigationControllerDelegate>

@end

@implementation WJManageUserInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [RegularExpressionsMethod ColorWithHexString:kMSVCBackgroundColor];
    [self initSendReplyWithTitle:@"个人信息" andLeftButtonName:@"ic_back.png" andRightButtonName:nil andTitleLeftOrRight:YES];
    self.arr_typeName = [NSArray arrayWithObjects:@"用户名", @"昵称",@"性别",@"出生日期",@"邮箱",nil];
    [self.view addSubview:self.infoTableView];
    // Do any additional setup after loading the view.
}
-(UITableView *)infoTableView
{
    if (!_infoTableView) {
        _infoTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kMSScreenWith, kMSScreenHeight-kMSNaviHight)];
        _infoTableView.delegate = self;
        _infoTableView.dataSource = self;
        _infoTableView.backgroundColor =[UIColor clearColor];
        _infoTableView.showsHorizontalScrollIndicator = NO;
        _infoTableView.separatorStyle=UITableViewCellSeparatorStyleNone;
        [_infoTableView registerClass:[WJUserInfoListCel class] forCellReuseIdentifier:@"WJUserInfoListCel"];

        _infoTableView.tableHeaderView = self.view_head;
    }
    return _infoTableView;
}

-(UIView *)view_head
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSLog(@"userlist=%@",[userDefaults objectForKey:@"userList"] );
    NSString *str_logo_img = [[userDefaults objectForKey:@"userList"] objectForKey:@"user_icon"];
    if (!_view_head) {
        _view_head = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kMSScreenWith, 140)];
        _view_head.backgroundColor = kMSCellBackColor;


        _headImageView = [[UIImageView alloc] init];
        _headImageView.contentMode = UIViewContentModeScaleAspectFit;
        _headImageView.layer.masksToBounds = YES;
        _headImageView.layer.cornerRadius = 33;
        _headImageView.userInteractionEnabled = YES;
        // 单击图片
        UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(changeUserIcon:)];
        [_headImageView addGestureRecognizer:singleTap];
        [_headImageView sd_setImageWithURL:[NSURL URLWithString:str_logo_img] placeholderImage:[UIImage imageNamed:@"ic_no_heardPic.png"]];
        [_view_head addSubview:_headImageView];
        [_headImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            [make.top.mas_equalTo(_view_head.mas_top)setOffset:10];
            make.centerX.mas_equalTo(_view_head.mas_centerX);
            make.size.mas_equalTo(CGSizeMake(66, 66));

        }];

        UILabel *labeluser = [[UILabel alloc] init];
        labeluser.font = PFR18Font;
        labeluser.textColor = [UIColor blueColor];
        labeluser.text = @"头像/更换头像";
        labeluser.textAlignment = NSTextAlignmentCenter;
        [_view_head addSubview:labeluser];
        [labeluser mas_makeConstraints:^(MASConstraintMaker *make) {
            [make.top.mas_equalTo(_headImageView.mas_bottom)setOffset:8];
            make.centerX.mas_equalTo(_view_head.mas_centerX);
            make.size.mas_equalTo(CGSizeMake(200, 20));

        }];
    [RegularExpressionsMethod dc_setUpAcrossPartingLineWith:_view_head WithColor:[[UIColor lightGrayColor]colorWithAlphaComponent:0.15]];
    }
    return _view_head;

}
-(void)changeUserIcon:(UITapGestureRecognizer *)recognizer
{
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

    NSString *str_ext;
    if (UIImagePNGRepresentation(image))
    {
        str_ext = @"png";
    }else{
        str_ext = @"jpg";
    }
    [self.headImageView setImage:image];
    NSData *data = [self resetSizeOfImageData:image maxSize:256];
    [self initCircleClassDataCount:data addImageSuffix:str_ext];
}

-(void)initCircleClassDataCount:(NSData *)data addImageSuffix:(NSString *)ext
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSString *uid = [[userDefaults objectForKey:@"userList"] objectForKey:@"uid" ];
    [SVProgressHUD showWithStatus:@"正在上传头像..."];
    [userDefaults synchronize];
    NSArray *arr= [NSArray arrayWithObject:data];
    NSMutableDictionary *infos = [NSMutableDictionary dictionary];
    [infos setObject:uid forKey:@"id"];
    [self requestAPIWithServe:[kMSBaseLargeCollectionPortURL stringByAppendingString:kMSUpLoadIcon] andInfos:infos andImageDataArr:arr andImageName:@"user_icon"];
}
-(void)processData
{
    if([[self.results objectForKey:@"code"] integerValue] == 200)
    {
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        NSDictionary *userListDic = [userDefaults objectForKey:@"userList"];
        NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:userListDic];
        NSLog(@"userListDic===%@",userListDic);
        NSString *usericon = [NSString stringWithFormat:@"%@%@",kMSBaseLargeCollectionPortURL,[self.results objectForKey:@"data"]];
        [dic setObject:usericon forKey:@"user_icon"];

        [userDefaults setObject:dic forKey:@"userList"];
        [userDefaults synchronize];

        [SVProgressHUD showErrorWithStatus:[self
                                            .results objectForKey:@"msg"]];

    }
    else
    {
        [SVProgressHUD showErrorWithStatus:[self
                                            .results objectForKey:@"msg"]];
    }
}

#pragma mark - UITableViewDelegate UITableViewDataSource Methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.arr_typeName.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44.f;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIndentifier = @"WJUserInfoListCel";
    WJUserInfoListCel *cell = (WJUserInfoListCel *)[tableView dequeueReusableCellWithIdentifier:CellIndentifier];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (indexPath.row == 0) {
        cell.actionImageView.hidden = YES;
    }
    else {
        cell.actionImageView.hidden = NO;
    }

    cell.nameLabel.text = self.arr_typeName[indexPath.row];
    cell.contentLabel.text = @"content";

    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

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
