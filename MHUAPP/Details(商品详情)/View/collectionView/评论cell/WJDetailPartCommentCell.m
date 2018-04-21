//
//  WJDetailPartCommentCell.m
//  MHUAPP
//
//  Created by jinri on 2017/12/5.
//  Copyright © 2017年 wenchengjun. All rights reserved.
//

#import "WJDetailPartCommentCell.h"
#import "UIImageView+WebCache.h"

@implementation WJDetailPartCommentCell{

    int numOfImg;  //图片说说部分，图片的个数
    float img_W;     //图片的宽高
    float img_H;
}

#pragma mark - Intial
- (instancetype)initWithFrame:(CGRect)frame {

    self = [super initWithFrame:frame];
    if (self) {
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

    [self.contentView addSubview:self.headerIconImgView];
    [self.contentView addSubview:self.nameLbl];
    [self.contentView addSubview:self.txtContentLbl];
    [self.contentView addSubview:self.imgContentView];
 

    //说说发表者头像
    self.headerIconImgView.frame = CGRectMake(5, 10, 40, 40);
    self.headerIconImgView.layer.cornerRadius = 20;
    self.headerIconImgView.layer.masksToBounds = YES;
    //说说发表者名字
    self.nameLbl.frame = CGRectMake(50, 12, kMSScreenWith - 50 - 10, 20);
    self.nameLbl.font = [UIFont boldSystemFontOfSize:14];
    self.nameLbl.textColor = [UIColor colorWithRed:68/256.0 green:137/256.0 blue:178/256.0 alpha:1];
    //说说的文字部分
    self.txtContentLbl.frame = CGRectMake(50, 40, kMSScreenWith - 50 - 10, 0);
    self.txtContentLbl.font = [UIFont systemFontOfSize:13];
    self.txtContentLbl.numberOfLines = 0;
    self.txtContentLbl.lineBreakMode = NSLineBreakByWordWrapping;
    
}



-(UIView *)imageContentView{

    UIView *imgView = [[UIView alloc]initWithFrame:self.frame];

    for (int i = 0; i < 9; i++) {
        UIImageView *imageView = [UIImageView new];
        [imgView addSubview:imageView];
    }

    return imgView;
}


-(void)setModel:(WJDetailPartCommentItem *)model{
    //设置属性
    _model = model;

    [self.headerIconImgView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",kMSBaseLargeCollectionPortURL,model.headerIconStr]] placeholderImage:[UIImage imageNamed:@"ic_no_heardPic.png"]];
    self.nameLbl.text = model.titleStr;
    self.txtContentLbl.text = model.txtContentStr;

    //说说的文字部分
    CGRect txtContentLblRect = [self.txtContentLbl.text boundingRectWithSize:CGSizeMake(kMSScreenWith - 50 - 10, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading | NSStringDrawingTruncatesLastVisibleLine attributes:@{NSFontAttributeName:self.txtContentLbl.font} context:nil];
    self.txtContentLbl.frame = CGRectMake(50, 40, self.nameLbl.bounds.size.width, txtContentLblRect.size.height);

    //排版说说的图片部分
    [self layoutImgContentViewWithModel:model];
    self.imgContentView.frame = CGRectMake(50, self.txtContentLbl.frame.origin.y + self.txtContentLbl.frame.size.height + 5, self.imgContentView.bounds.size.width, [self heightForImgContentByCount:model.imageArr.count]);
    self.imgContentView.contentMode = UIViewContentModeScaleAspectFill;
}

#pragma mark -对图片墙布局
-(void)layoutImgContentViewWithModel:(WJDetailPartCommentItem *)model{

    //先遍历所有的的图片，并将其置空
    for (UIImageView *imgView in [self.imgContentView subviews]) {
        imgView.frame = CGRectMake(0, 0, 0, 0);
        self.imgContentView.frame = CGRectMake(50, self.txtContentLbl.bounds.origin.y + self.txtContentLbl.bounds.size.height, kMSScreenWith - 50 -10, 0);
    }

    for (numOfImg = 0; numOfImg < model.imageArr.count; numOfImg++) {
        UIImageView *imageView = [[self.imgContentView subviews] objectAtIndex:numOfImg];
        [imageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",kMSBaseLargeCollectionPortURL,[[model.imageArr objectAtIndex:numOfImg] objectForKey:@"thumb_url"]]] placeholderImage:[UIImage imageNamed:@"noMore_bg"]];
    }

    //布局
    int numOfLine = 0;
    int colu = 4;

        img_H = kMSScreenWith/4-2;
        img_W = kMSScreenWith/4-2;


    if (model.imageArr.count > 0) {
        numOfLine = 1;
        colu = (int)model.imageArr.count;
    }
    else
    {
        numOfLine = 0;
        img_H = 0;
        img_W = 0;
    }

        for (int j = 0; j < colu; j++) {
            UIImageView *imageView = (UIImageView *)[[self.imgContentView subviews] objectAtIndex: colu + j];
            imageView.frame = CGRectMake(j * (img_W + 2),0 ,img_W, img_H);
        }
}
#pragma mark -照片墙的高度
-(CGFloat)heightForImgContentByCount:(NSInteger)count{

    if (count == 0) {
        return 0;
    }else  {
        return img_H;
    }
}

#pragma mark -返回次cell的高度
-(CGFloat)cellHeight{

    return self.txtContentLbl.frame.origin.y + self.txtContentLbl.bounds.size.height + 5+img_H;
}

@end
