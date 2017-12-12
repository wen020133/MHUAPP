


#ifndef meijiaPrinter_Constants_h
#define meijiaPrinter_Constants_h

/** 弱引用 */
#define WEAKSELF __weak typeof(self) weakSelf = self;

#define DCMargin 8

#define PFR [[[UIDevice currentDevice] systemVersion] floatValue] >= 9.0 ? @"PingFangSC-Regular" : @"PingFang SC"

#define PFR20Font [UIFont fontWithName:PFR size:20];
#define PFR18Font [UIFont fontWithName:PFR size:18];
#define PFR16Font [UIFont fontWithName:PFR size:16];
#define PFR15Font [UIFont fontWithName:PFR size:15];
#define PFR14Font [UIFont fontWithName:PFR size:14];
#define PFR13Font [UIFont fontWithName:PFR size:13];
#define PFR12Font [UIFont fontWithName:PFR size:12];
#define PFR11Font [UIFont fontWithName:PFR size:11];
#define PFR10Font [UIFont fontWithName:PFR size:10];


#define IOS7 [[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0

#define kEVNScreenNavigationBarHeight 44.f


#define D_LocalizedCardString(s) [[NSBundle mainBundle] localizedStringForKey:s value:nil table:@"CardToolLanguage"]
#define D_Main_Appdelegate (AppDelegate *)[UIApplication sharedApplication].delegate

#define kMSVCBackgroundColor    @"F8F8F8"   //APP背景颜色
#define kGrayBgColor            @"#DFDFDF"  // 图像边缘浅灰色
#define BASEBLACKCOLOR          @"#6A6A6A"  //Cell title字体黑色
#define BASEPINK                @"#FF7A9A"  //程序基础粉色
#define BASELITTLEBLACKCOLOR    @"#9E9E9E"  //最浅的黑色

#define SDPhotoBrowserBackgrounColor [UIColor colorWithRed:0 green:0 blue:0 alpha:0.95]               // browser背景颜色

#define Font(F) [UIFont systemFontOfSize:F]

#define kMSCellSubtitleLableColor [UIColor colorWithRed:233/255.0 green:35/255.0 blue:46/255.0 alpha:1]
#define kMSLabelTextColor [UIColor colorWithRed:90/255.0 green:90/255.0 blue:90/255.0 alpha:1]
#define kMSButtonBackColor [UIColor colorWithRed:249/255.0 green:125/255.0 blue:10/255.0 alpha:1]
#define kMSNavBarBackColor [UIColor colorWithRed:253/255.0 green:56/255.0 blue:115/255.0 alpha:1]
#define kMSViewBorderColor [[UIColor colorWithRed:230/255.0 green:230/255.0 blue:230/255.0 alpha:1] CGColor]

#define kMSViewTitleColor [UIColor whiteColor]
#define kMSCellBackColor [UIColor whiteColor]
#define kMSViewBackColor [UIColor whiteColor]


#define kMSScreenWith CGRectGetWidth([UIScreen mainScreen].bounds)


#define ConvertString(str) ([str isEqual:[NSNull null]] ? @"0" : str)
#define ConvertNullString(str) ([str isEqual:[NSNull null]] ? @"" : str)
#define ConvertAnonymousString(str) ([str isEqual:[NSNull null]] ? @"匿名" : str)
#define kMSStartReplyNotification   @"StartReplyNotification"
#define kMSStartBackNotification   @"StartBackNotification"

#define iPhone5PrintHeght ([[UIScreen mainScreen] bounds].size.height>500? 30 : 20 )
#define iPhone5HeghtFrame ([[UIScreen mainScreen] bounds].size.height>500? 0 : 60 )
#define kMSScreenHeight CGRectGetHeight([UIScreen mainScreen].bounds)


#define kMSNaviHight  64
#define startOriginY ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0 ? 20:0)

#define _TencentAppid_  @"1105002914"
#define UmengAppkey @"57b16a5ee0f55acfa0002b1f"
#define kAppKey         @"3304591780"
#define kAppIDWeixin         @"wxcd6d759365bd725a"
#define kAppSecret         @"0a650997bb7a8da403999bf63993a13f"
#define kRedirectURI    @"https://itunes.apple.com/cn/app/omynail/id1115575145?mt=8"

#define kMSPULLtableViewCellNumber @"10"
#define kMSappVersionCode   1

#define kMSTOAFRICAAppKey   @"47baa5a71fbd46dca2c83aa085f8fd51"  //APP key

#define KNoDataText                @"The results not found!"
#define KFailedtogetthedata                @"Failed to get the data!"

#define KMSOSVersion                @"ios"      //版本
#define KMSLanguageCode               @"en"     //语言



#define mStringWithInt(A) [NSString stringWithFormat:@"%zi", A]
#define mStringWithFloat(A) [NSString stringWithFormat:@"%f", A]
#define mNSNumberWithString(A)   @([A integerValue])
#define GetObjectFromDicWithKey(dictonary, key , Class) [[dictonary objectForKey:key] isKindOfClass:[Class class]] ? [dictonary objectForKey:key] : nil

#define mGetString(A) A?A:@""



#define IS_IPHONE (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
#define IS_IPHONE_4_OR_LESS (IS_IPHONE && [[UIScreen mainScreen] bounds].size.height < 568.0)
#define IS_IPHONE_5 (IS_IPHONE && SCREEN_MAX_LENGTH == 568.0)
#define IS_IPHONE_6 (IS_IPHONE && SCREEN_MAX_LENGTH == 667.0)
#define IS_IPHONE_6P (IS_IPHONE && SCREEN_MAX_LENGTH == 736.0)
#define iPhone6PHeghtFrame ([[UIScreen mainScreen] bounds].size.height==736.0? 60 : 0 )
#define iPhone5Or6PHeght ([[UIScreen mainScreen] bounds].size.height== 568.0||667.0 ? 30 : 0 )

#define MSDynamicCast(C, o) ({ __typeof__(o) MSDynamicCast__o = (o); [MSDynamicCast__o isKindOfClass:[C class]] ? (C*)MSDynamicCast__o : nil; })

//定义UILabel对象
#define LabelInit(x,y,width,height)  [[UILabel alloc]initWithFrame:CGRectMake(x, y, width, height)]
//定义UIImageView对象
#define ImageViewInit(x,y,width,height) [[UIImageView alloc]initWithFrame:CGRectMake(x, y, width, height)]
//定义UIImageView对象
#define ViewInit(x,y,width,height) [[UIView alloc]initWithFrame:CGRectMake(x, y, width, height)]



#endif
