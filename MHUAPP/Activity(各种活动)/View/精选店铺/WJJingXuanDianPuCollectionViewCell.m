//
//  WJJingXuanDianPuCollectionViewCell.m
//  MHUAPP
//
//  Created by jinri on 2018/4/9.
//  Copyright © 2018年 wenchengjun. All rights reserved.
//

#import "WJJingXuanDianPuCollectionViewCell.h"
#import "SDPhotoBrowser.h"
#import "UIImageView+WebCache.h"
#import "UIView+UIViewFrame.h"


@interface WJJingXuanDianPuCollectionViewCell ()
{
    int numOfImg ;  //图片说说部分，图片的个数
    float img_W;     //图片的宽高
    float img_H;
}
@end

@implementation WJJingXuanDianPuCollectionViewCell



-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        img_H = 0;
        //先清除缓存
        [[SDWebImageManager sharedManager].imageCache clearDisk];
        [self createContents];
    }
    return self;
}

-(void)createContents{

    self.backgroundColor = kMSCellBackColor;

    //头像
    self.headerIconImgView = ImageViewInit(DCMargin, DCMargin, 50, 50);
    self.headerIconImgView.layer.cornerRadius = 25;
    self.headerIconImgView.layer.masksToBounds = YES;
    [self.contentView addSubview:self.headerIconImgView];
    //名字
  self.nameLbl = LabelInit(self.headerIconImgView.Right+DCMargin, 20,kMSScreenWith-80, 20);
    self.nameLbl.font = [UIFont boldSystemFontOfSize:14];
    self.nameLbl.text = @"adadsdgfglhkkkk";
    self.nameLbl.textColor = [RegularExpressionsMethod ColorWithHexString:BASEBLACKCOLOR];
    [self.contentView addSubview:self.nameLbl];

    //地址
    self.lab_address = LabelInit(self.headerIconImgView.Right+DCMargin, self.nameLbl.Bottom+2, kMSScreenWith-80, 20);
    self.lab_address.font = [UIFont systemFontOfSize:14];
    self.lab_address.text = @"深圳市光明新区公明镇";
    self.lab_address.textColor = [RegularExpressionsMethod ColorWithHexString:BASELITTLEBLACKCOLOR];
    [self.contentView addSubview:self.lab_address];


     CGFloat miaosuWidth = [RegularExpressionsMethod widthOfString:@"宝贝描述:5.0" font:[UIFont systemFontOfSize:14] height:20];
    //宝贝描述
    self.lab_BBmiansu = LabelInit(DCMargin, self.headerIconImgView.Bottom+DCMargin, miaosuWidth, 20);
    self.lab_BBmiansu.font = [UIFont systemFontOfSize:14];

    self.lab_BBmiansu.text = @"宝贝描述:5.0";
    self.lab_BBmiansu.textColor = [RegularExpressionsMethod ColorWithHexString:BASELITTLEBLACKCOLOR];
    [self.contentView addSubview:self.lab_BBmiansu];

    UILabel *labGao1= [[UILabel alloc] initWithFrame:CGRectMake(self.lab_BBmiansu.Right+2, self.headerIconImgView.Bottom+DCMargin, 20, 20)];
    labGao1.textAlignment = NSTextAlignmentCenter;
    labGao1.font = [UIFont systemFontOfSize:14];
    labGao1.backgroundColor = [RegularExpressionsMethod ColorWithHexString:BASEPINK];
    labGao1.textColor = [UIColor whiteColor];
    labGao1.text = @"高";
    labGao1.layer.cornerRadius = 3;
    labGao1.layer.masksToBounds = YES;//设置圆角
    [self.contentView addSubview:labGao1];
    

    //宝贝描述
    self.lab_MJfuwu = LabelInit((kMSScreenWith-miaosuWidth)/2-12, self.headerIconImgView.Bottom+DCMargin, miaosuWidth, 20);
    self.lab_MJfuwu.font = [UIFont systemFontOfSize:14];
    self.lab_MJfuwu.text = @"卖家服务:5.0";
    self.lab_MJfuwu.textColor = [RegularExpressionsMethod ColorWithHexString:BASELITTLEBLACKCOLOR];
    [self.contentView addSubview:self.lab_MJfuwu];

    UILabel *labGao2= [[UILabel alloc] initWithFrame:CGRectMake(self.lab_MJfuwu.Right+2, self.headerIconImgView.Bottom+DCMargin, 20, 20)];
    labGao2.textAlignment = NSTextAlignmentCenter;
    labGao2.font = [UIFont systemFontOfSize:14];
    labGao2.backgroundColor = [RegularExpressionsMethod ColorWithHexString:BASEPINK];
    labGao2.textColor = [UIColor whiteColor];
    labGao2.text = @"高";
    labGao2.layer.cornerRadius = 3;
    labGao2.layer.masksToBounds = YES;//设置圆角
    [self.contentView addSubview:labGao2];

    //物流服务
    self.lab_WLfwu = LabelInit(kMSScreenWith-miaosuWidth-22-DCMargin, self.headerIconImgView.Bottom+DCMargin, kMSScreenWith-80, 20);
    self.lab_WLfwu.font = [UIFont systemFontOfSize:14];
    self.lab_WLfwu.text = @"物流服务:5.0";
    self.lab_WLfwu.textColor = [RegularExpressionsMethod ColorWithHexString:BASELITTLEBLACKCOLOR];
    [self.contentView addSubview:self.lab_WLfwu];

    UILabel *labGao3= [[UILabel alloc] initWithFrame:CGRectMake(self.lab_WLfwu.Right+2, self.headerIconImgView.Bottom+DCMargin, 20, 20)];
    labGao3.textAlignment = NSTextAlignmentCenter;
    labGao3.font = [UIFont systemFontOfSize:14];
    labGao3.backgroundColor = [RegularExpressionsMethod ColorWithHexString:BASEPINK];
    labGao3.textColor = [UIColor whiteColor];
    labGao3.text = @"高";
    labGao3.layer.cornerRadius = 3;
    labGao3.layer.masksToBounds = YES;//设置圆角
    [self.contentView addSubview:labGao3];

    UIImageView *line1 = ImageViewInit(DCMargin,  self.lab_BBmiansu.Bottom+DCMargin, kMSScreenWith-DCMargin*2, 1);
    line1.backgroundColor = [RegularExpressionsMethod ColorWithHexString:@"E6E6E6"];
    [self.contentView addSubview:line1];

    //总多少商品
    self.lab_goodNum = LabelInit(DCMargin, line1.Bottom+DCMargin, kMSScreenWith-80, 20);
    self.lab_goodNum.font = [UIFont systemFontOfSize:14];
    self.lab_goodNum.text = @"共12件宝贝";
    self.lab_goodNum.textColor = [RegularExpressionsMethod ColorWithHexString:BASELITTLEBLACKCOLOR];
    [self.contentView addSubview:self.lab_goodNum];

    self.imgContentView = [self imageContentView];
    [self.contentView addSubview:self.imgContentView];

   


}


-(UIView *)imageContentView{

    UIView *imgView = [[UIView alloc]initWithFrame:self.frame];
    return imgView;
}


-(void)setModel:(SLCommentsModel *)model{
    //设置属性
    _model = model;

    [self.headerIconImgView sd_setImageWithURL:[NSURL URLWithString:model.logo] placeholderImage:[UIImage imageNamed:@"ic_no_heardPic.png"]];
    self.nameLbl.text = model.supplier_name;


    //排版说说的图片部分
    [self layoutImgContentViewWithModel:model];
    self.imgContentView.frame = CGRectMake(DCMargin, self.lab_goodNum.Bottom+DCMargin, kMSScreenWith-DCMargin*2, [self heightForImgContentByCount:model.may_goods.count]);
    self.imgContentView.contentMode = UIViewContentModeScaleAspectFill;
    
    
    _btn_kefu = [UIButton buttonWithType:UIButtonTypeCustom];
    _btn_kefu.frame = CGRectMake(20, self.imgContentView.Bottom, kMSScreenWith/2-40, 40);
    [_btn_kefu setImage:[UIImage imageNamed:@"customerService"] forState:UIControlStateNormal];
    [_btn_kefu setBackgroundColor:kMSCellBackColor];
    _btn_kefu.layer.cornerRadius = 3;
    _btn_kefu.layer.masksToBounds = YES;//设置圆角
    _btn_kefu.imageEdgeInsets = UIEdgeInsetsMake(10, 10, 10, 95);
    [_btn_kefu setTitle:@"联系客服" forState:UIControlStateNormal];
//    _btn_kefu.titleEdgeInsets = UIEdgeInsetsMake(0, -20, 0, 0);
    _btn_kefu.layer.borderColor = [[[UIColor lightGrayColor]colorWithAlphaComponent:0.3] CGColor];
    _btn_kefu.layer.borderWidth = 1.0f;
    [_btn_kefu setTitleColor:[RegularExpressionsMethod ColorWithHexString:BASEBLACKCOLOR] forState:UIControlStateNormal];
    _btn_kefu.titleLabel.font = [UIFont systemFontOfSize:14];
    [self.contentView addSubview:_btn_kefu];
    
    _btn_shop = [UIButton buttonWithType:UIButtonTypeCustom];
    _btn_shop.frame = CGRectMake(kMSScreenWith/2+20, self.imgContentView.Bottom, kMSScreenWith/2-40, 40);
    [_btn_shop setImage:[UIImage imageNamed:@"shop_default"] forState:UIControlStateNormal];
    [_btn_shop setBackgroundColor:kMSCellBackColor];
    _btn_shop.layer.cornerRadius = 3;
    _btn_shop.layer.masksToBounds = YES;//设置圆角
    _btn_shop.imageEdgeInsets = UIEdgeInsetsMake(10, 10, 10, 95);
    [_btn_shop setTitle:@"进入店铺" forState:UIControlStateNormal];
//    _btn_shop.titleEdgeInsets = UIEdgeInsetsMake(0, -20, 0, 0);
    _btn_shop.layer.borderColor = [[[UIColor lightGrayColor]colorWithAlphaComponent:0.3] CGColor];
    _btn_shop.layer.borderWidth = 1.0f;
    [_btn_shop setTitleColor:[RegularExpressionsMethod ColorWithHexString:BASEBLACKCOLOR] forState:UIControlStateNormal];
    _btn_shop.titleLabel.font = [UIFont systemFontOfSize:14];
    [self.contentView addSubview:_btn_shop];
   

}
#pragma mark -照片墙的高度
-(CGFloat)heightForImgContentByCount:(NSInteger)count{
    
    if (count == 0) {
        return 0;
    }else{
        return img_W+30;
    }
}
#pragma mark -对图片墙布局
-(void)layoutImgContentViewWithModel:(SLCommentsModel *)model{

     img_W = img_H = (kMSScreenWith-DCMargin*2)/4-6;
    
    for (numOfImg = 0; numOfImg < model.may_goods.count; numOfImg++) {
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:  CGRectMake(numOfImg * (img_W + 6), 3, img_W, img_H)];
        [imageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",[[model.may_goods objectAtIndex:numOfImg] objectForKey:@"original_img"]]] placeholderImage:[UIImage imageNamed:@"noMore_bg"]];
        [self.imgContentView addSubview:imageView];
        
        UILabel *labPrice = LabelInit(numOfImg * (img_W + 6), imageView.Bottom-20, img_W, 20);
        labPrice.textAlignment = NSTextAlignmentCenter;
        labPrice.textColor = kMSCellBackColor;
        labPrice.font = Font(12);
        labPrice.backgroundColor = [[UIColor lightGrayColor]colorWithAlphaComponent:0.5];
        labPrice.text = @"￥30.00";
        [self.imgContentView addSubview:labPrice];
        
        UILabel *labTitle = LabelInit(numOfImg * (img_W + 6), imageView.Bottom, img_W, 30);
        labTitle.textColor = [RegularExpressionsMethod ColorWithHexString:BASEBLACKCOLOR];
        labTitle.font = Font(12);
        labTitle.text = [[model.may_goods objectAtIndex:numOfImg] objectForKey:@"goods_name"];
        [self.imgContentView addSubview:labTitle];
    }

}



@end
