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

    self.headerIconImgView = [UIImageView new];
    self.nameLbl = [UILabel new];
    self.txtContentLbl = [UILabel new];
    self.imgContentView = [self imageContentView];
    self.lab_title = [UILabel new];
    self.lab_collectionNum = [UILabel new];
    self.zanBtn = [UIButton new];
    self.commentBtn = [UIButton new];

    [self.contentView addSubview:self.headerIconImgView];
    [self.contentView addSubview:self.nameLbl];
    [self.contentView addSubview:self.txtContentLbl];
    [self.contentView addSubview:self.imgContentView];
    [self.contentView addSubview:self.lab_title];
    [self.contentView addSubview:self.lab_collectionNum];
    [self.contentView addSubview:self.zanBtn];
    [self.contentView addSubview:self.commentBtn];


    //头像
    self.headerIconImgView.frame = CGRectMake(5, 10, 40, 40);
    self.headerIconImgView.layer.cornerRadius = 20;
    self.headerIconImgView.layer.masksToBounds = YES;
    //名字
    self.nameLbl.frame = CGRectMake(50, 20,110, 20);
    self.nameLbl.font = [UIFont boldSystemFontOfSize:14];
    self.nameLbl.text = @"adadsdgfglhkkkk";
    self.nameLbl.textColor = [RegularExpressionsMethod ColorWithHexString:BASEBLACKCOLOR];

    //收藏数量
    self.lab_collectionNum.frame = CGRectMake(165, 20, 80, 20);
    self.lab_collectionNum.font = [UIFont systemFontOfSize:11];
    self.lab_collectionNum.text = @"10000人已收藏";

    //收藏
    self.zanBtn.frame = CGRectMake(self.lab_collectionNum.Right+5, 15, 30, 30);
    [self.zanBtn setBackgroundImage:[UIImage imageNamed:@"jxdp_shoucang"] forState:UIControlStateNormal];

    self.commentBtn.frame = CGRectMake(self.zanBtn.Right+10, 20, 60, 30);
    self.commentBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [self.commentBtn setTitle:@"进店看看" forState:UIControlStateNormal];

    //标题
    self.lab_title.font = [UIFont systemFontOfSize:12];
    self.lab_title.textColor = [RegularExpressionsMethod ColorWithHexString:BASEBLACKCOLOR];
    self.lab_title.frame = CGRectMake(10, 55, kMSScreenWith-20, 20);
    self.lab_title.text = @"店铺广告语";

    //文字部分
    self.txtContentLbl.frame = CGRectMake(10, self.lab_title.Bottom, kMSScreenWith-20, 0);
    self.txtContentLbl.font = [UIFont systemFontOfSize:13];
    self.txtContentLbl.textColor = [RegularExpressionsMethod ColorWithHexString:BASELITTLEBLACKCOLOR];
    self.txtContentLbl.numberOfLines = 0;
    self.txtContentLbl.lineBreakMode = NSLineBreakByWordWrapping;


}


-(UIView *)imageContentView{

    UIView *imgView = [[UIView alloc]initWithFrame:self.frame];

    for (int i = 0; i < 9; i++) {
        UIImageView *imageView = [UIImageView new];
        imageView.userInteractionEnabled = YES;

        [imgView addSubview:imageView];
    }

    return imgView;
}


-(void)setModel:(SLCommentsModel *)model{
    //设置属性
    _model = model;

    [self.headerIconImgView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",kMSBaseLargeCollectionPortURL,model.headerIconStr]] placeholderImage:[UIImage imageNamed:@"ic_no_heardPic.png"]];
    self.nameLbl.text = model.titleStr;
    self.txtContentLbl.text = model.txtContentStr;

    //说说的文字部分
    CGRect txtContentLblRect = [self.txtContentLbl.text boundingRectWithSize:CGSizeMake(kMSScreenWith - 20, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading | NSStringDrawingTruncatesLastVisibleLine attributes:@{NSFontAttributeName:self.txtContentLbl.font} context:nil];
    self.txtContentLbl.frame = CGRectMake(10, self.lab_title.Bottom, self.nameLbl.bounds.size.width, txtContentLblRect.size.height);

    //排版说说的图片部分
    [self layoutImgContentViewWithModel:model];
    self.imgContentView.frame = CGRectMake(10, self.txtContentLbl.frame.origin.y + self.txtContentLbl.frame.size.height + 5, self.imgContentView.bounds.size.width, [self heightForImgContentByCount:model.imageArr.count]);
    self.imgContentView.contentMode = UIViewContentModeScaleAspectFill;

    //
    self.lab_collectionNum.text = model.dateStr;

}

#pragma mark -对图片墙布局
-(void)layoutImgContentViewWithModel:(SLCommentsModel *)model{

    //先遍历所有的的图片，并将其置空
    for (UIImageView *imgView in [self.imgContentView subviews]) {
        imgView.frame = CGRectMake(0, 0, 0, 0);
        self.imgContentView.frame = CGRectMake(10, self.txtContentLbl.bounds.origin.y + self.txtContentLbl.bounds.size.height, kMSScreenWith - 20, 0);
    }

    for (numOfImg = 0; numOfImg < model.imageArr.count; numOfImg++) {
        UIImageView *imageView = [[self.imgContentView subviews] objectAtIndex:numOfImg];
        //给带图的imageView添加单击手势
        imageView.tag = numOfImg;
        [imageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",kMSBaseLargeCollectionPortURL,[[model.imageArr objectAtIndex:numOfImg] objectForKey:@"thumb_url"]]] placeholderImage:[UIImage imageNamed:@"noMore_bg"]];

    }
    //布局
    int numOfLine = 0;
    int colu = 3;

    if (kMSScreenWith == 320) {
        img_H = 80;
        img_W = 80;
    }else{
        img_H = 100;
        img_W = 100;
    }


    if ( model.imageArr.count > 0) {
        if (model.imageArr.count == 1) { //当只有一张图片时，按比例显示图片
            colu = 1;
        }
        numOfLine = 1;
        colu = (int)model.imageArr.count;
    }else{
        numOfLine = 0;
        img_H = 0;
        img_W = 0;
    }

    for (int i = 0; i < numOfLine; i++) {
        for (int j = 0; j < 3; j++) {
            UIImageView *imageView = (UIImageView *)[[self.imgContentView subviews] objectAtIndex:i * colu + j];
            imageView.frame = CGRectMake(j * (img_W + 3), i * (img_H + 3), img_W, img_H);
        }
    }
}
#pragma mark -返回次cell的高度
-(CGFloat)cellHeight{

    return self.lab_collectionNum.Bottom + 85;
}

#pragma mark -照片墙的高度
-(CGFloat)heightForImgContentByCount:(NSInteger)count{

    if (count == 0) {
        return 0;
    }else
        return img_H;

}

@end
