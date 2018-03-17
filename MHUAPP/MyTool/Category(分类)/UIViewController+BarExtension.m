
#define TOPX 0
#define TOPY 0
#define WIDTH CGRectGetWidth([UIScreen mainScreen].applicationFrame)
#define NavigationHeight self.navigationController.navigationBar.frame.size.height
#define HEIGHT CGRectGetHeight([UIScreen mainScreen].applicationFrame) - NavigationHeight

#import "UINavigationBar+MSExtension.h"

@implementation UIViewController (BarExtension)

//Initialize the navigation bar when it needs the right button
//@parameters:titleName   :the title name of top navigation bar
//            leftBtnName :the name of the left button of top navigation bar
//            rightBtnName:the name of the right button of top navigation bar


- (void)initSendReplyWithTitle:(NSString *)titleName andLeftButtonName:(NSString *)leftImageName andRightButtonName:(NSString *)rightImageName andTitleLeftOrRight:(BOOL)yesOrNo
{

	
	 if (leftImageName) {
         UIButton *btnLeft = [UIButton buttonWithType:UIButtonTypeCustom];
//         [btnLeft setImage:[UIImage imageNamed:leftImageName] forState:UIControlStateNormal];
         [btnLeft setBackgroundImage:[UIImage imageNamed:leftImageName] forState:UIControlStateNormal];
         [btnLeft sizeToFit];

         [btnLeft addTarget:self action:@selector(showleft) forControlEvents:UIControlEventTouchUpInside];
         UIBarButtonItem* leftButtonItem = [[UIBarButtonItem alloc] init];
         leftButtonItem.customView = btnLeft;
         self.navigationItem.leftBarButtonItem = leftButtonItem;
	}
    else
    {
        self.navigationItem.hidesBackButton = YES;
        self.navigationItem.leftBarButtonItem.customView.hidden=YES;
    }


    
    // right button
    if(rightImageName)
    {
        UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
        UIImage *rightImage = [UIImage imageNamed:rightImageName];

        if (yesOrNo) {
            
         rightButton.frame = CGRectMake(0, 0,44, 44);
            [rightButton setImage:rightImage forState:UIControlStateNormal];
        }
        else
        {
            rightButton.frame = CGRectMake(0, 0,60, 35);
            [rightButton setTitle:rightImageName forState:UIControlStateNormal];
            [rightButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            rightButton.titleLabel.font = [UIFont systemFontOfSize:16];
        }
        
        [rightButton addTarget:self action:@selector(showright) forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem* rightButtonItem = [[UIBarButtonItem alloc] init];
        rightButtonItem.customView = rightButton;
        self.navigationItem.rightBarButtonItem = rightButtonItem;
    }
    
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(20, 10, kMSScreenWith-200, 20)];
    label.backgroundColor = [UIColor clearColor];
    label.textColor = kMSViewTitleColor;
    label.textAlignment = NSTextAlignmentCenter;
    label.center = CGPointMake(kMSScreenWith/2, kMSNaviHight/2);
    UIFont *font = PFR20Font;
    label.font = font;
    label.text = titleName;
    self.navigationItem.titleView = label;

}


#pragma mark - Actions

- (void)showleft {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)showright {
    
}
-(void)showTitleAction
{
    
}
- (void)initSendReplyWithTitleImage:(NSString *)titleName andLeftButtonNameImage:(NSString *)leftImageName andRightButtonName:(NSString *)rightImageName
{
    // left button
    if (leftImageName) {
        UIImage *leftImage = [UIImage imageNamed:leftImageName];
        UIButton *leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
        leftButton.frame =  CGRectMake(0, 9, 35, 35);
        [leftButton setBackgroundImage:leftImage forState:UIControlStateNormal];
        [leftButton addTarget:self action:@selector(showleft) forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem* leftButtonItem = [[UIBarButtonItem alloc] init];
        leftButtonItem.customView = leftButton;
        self.navigationItem.leftBarButtonItem = leftButtonItem;
    }
    
    // right button
    if(rightImageName)
    {
        UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
        rightButton.frame = CGRectMake(0, 0,40, 35);
        [rightButton setTitle:rightImageName forState:UIControlStateNormal];
        [rightButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        rightButton.titleLabel.font = [UIFont systemFontOfSize:18];
        [rightButton addTarget:self action:@selector(showright) forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem* rightButtonItem = [[UIBarButtonItem alloc] init];
        rightButtonItem.customView = rightButton;
        self.navigationItem.rightBarButtonItem = rightButtonItem;
    }
    UIView *view_titleVc = [[UIView alloc]initWithFrame:CGRectMake(50, 0, kMSScreenWith-100, 44)];
    view_titleVc.backgroundColor= [UIColor clearColor];
    
    
    UIButton *titleButton = [UIButton buttonWithType:UIButtonTypeCustom];
    titleButton.frame =  CGRectMake((kMSScreenWith-100)/2-18, 4, 45, 35);
    [titleButton setBackgroundImage:[UIImage imageNamed:titleName] forState:UIControlStateNormal];
    [titleButton addTarget:self action:@selector(showTitleAction) forControlEvents:UIControlEventTouchUpInside];
    [view_titleVc addSubview:titleButton];
    self.navigationItem.titleView = view_titleVc;
}



#pragma mark 根据size截取图片中间矩形区域的图片 这里的size是正方形
-(UIImage *)cutCenterImage:(UIImage *)image size:(CGSize)size{
    CGSize imageSize = image.size;
    CGRect rect;
    //根据图片的大小计算出图片中间矩形区域的位置与大小
    if (imageSize.width > imageSize.height) {
        float leftMargin = (imageSize.width - imageSize.height) * 0.5;
        rect = CGRectMake(leftMargin, 0, imageSize.height, imageSize.height);
    }else{
        float topMargin = (imageSize.height - imageSize.width) * 0.5;
        rect = CGRectMake(0, topMargin, imageSize.width, imageSize.width);
    }
    
    CGImageRef imageRef = image.CGImage;
    //截取中间区域矩形图片
    CGImageRef imageRefRect = CGImageCreateWithImageInRect(imageRef, rect);
    
    UIImage *tmp = [[UIImage alloc] initWithCGImage:imageRefRect];
    CGImageRelease(imageRefRect);
    
    UIGraphicsBeginImageContext(size);
    CGRect rectDraw = CGRectMake(0, 0, size.width, size.height);
    [tmp drawInRect:rectDraw];
    // 从当前context中创建一个改变大小后的图片
    tmp = UIGraphicsGetImageFromCurrentImageContext();
    
    // 使当前的context出堆栈
    UIGraphicsEndImageContext();
    
    return tmp;
}

- (NSString *)toFormatNumberString:(NSString *)qian //给数字多的价格加上逗号
{
    @try
    {
        if (qian.length < 3)
        {
            return qian;
        }
        NSString *numStr = qian;
        NSArray *array = [numStr componentsSeparatedByString:@","];
        NSString *numInt = [array objectAtIndex:0];
        if (numInt.length <= 3)
        {
            return qian;
        }
        NSString *suffixStr = @"";
        if ([array count] > 1)
        {
            suffixStr = [NSString stringWithFormat:@",%@",[array objectAtIndex:1]];
        }
        
        NSMutableArray *numArr = [[NSMutableArray alloc] init];
        while (numInt.length > 3)
        {
            NSString *temp = [numInt substringFromIndex:numInt.length - 3];
            numInt = [numInt substringToIndex:numInt.length - 3];
            [numArr addObject:[NSString stringWithFormat:@",%@",temp]];//得到的倒序的数据
        }
        NSInteger count = [numArr count];
        for (int i = 0; i < count; i++)
        {
            numInt = [numInt stringByAppendingFormat:@"%@",[numArr objectAtIndex:(count -1 -i)]];
        }
        //        [numArr release];
        numStr = [NSString stringWithFormat:@"%@%@",numInt,suffixStr];
        return numStr;
    }
    @catch (NSException *exception)
    {
        return qian;
    }
    @finally
    {}
}


@end


