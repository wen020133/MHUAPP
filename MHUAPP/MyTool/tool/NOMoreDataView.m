//
//  NOMoreDataView.m
//  TOAFRICA
//
//  Created by wenchengjun on 15-3-16.
//
//

#import "NOMoreDataView.h"

@implementation NOMoreDataView
- (id)initWithFrame:(CGRect)frame withContent:(NSString *)str withNODataImage:(NSString *)imageName
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initnoMoredata:str withImageBack:imageName];
    }
    return self;
}
-(void)initnoMoredata:(NSString *)str withImageBack:(NSString *)imageName
{
    UIImageView *imag_nomore = [[UIImageView alloc]initWithFrame:CGRectMake(kMSScreenWith/2-40, 70, 80, 100)];
    [imag_nomore setImage:[UIImage imageNamed:imageName]];
    imag_nomore.contentMode = UIViewContentModeScaleAspectFit;
    [self addSubview:imag_nomore];
    
    UILabel *lab_content = [[UILabel alloc]initWithFrame:CGRectMake(20, 190, kMSScreenWith-40, 21)];
    lab_content.text = str;
    lab_content.font = [UIFont systemFontOfSize:14];
    lab_content.textColor = [UIColor lightGrayColor];
    lab_content.textAlignment = NSTextAlignmentCenter;
    [self addSubview:lab_content];
}
- (void)hide
{
    [self removeFromSuperview];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
