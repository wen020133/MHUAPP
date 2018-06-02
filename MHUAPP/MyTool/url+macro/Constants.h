


#ifndef meijiaPrinter_Constants_h
#define meijiaPrinter_Constants_h

/** 弱引用 */
#define WEAKSELF __weak typeof(self) weakSelf = self;

#define DCMargin 8

#define PFR [[[UIDevice currentDevice] systemVersion] floatValue] >= 9.0 ? @"PingFangSC-Regular" : @"PingFang SC"

#define PFR20Font [UIFont fontWithName:@"Helvetica-Bold" size:20];
#define PFR18Font [UIFont fontWithName:PFR size:18];
#define PFR16Font [UIFont fontWithName:PFR size:16];
#define PFR15Font [UIFont fontWithName:PFR size:15];
#define PFR14Font [UIFont fontWithName:PFR size:14];
#define PFR13Font [UIFont fontWithName:PFR size:13];
#define PFR12Font [UIFont fontWithName:PFR size:12];
#define PFR11Font [UIFont fontWithName:PFR size:11];
#define PFR10Font [UIFont fontWithName:PFR size:10];



#define D_LocalizedCardString(s) [[NSBundle mainBundle] localizedStringForKey:s value:nil table:@"CardToolLanguage"]
#define D_Main_Appdelegate (AppDelegate *)[UIApplication sharedApplication].delegate

#define kMSVCBackgroundColor    @"F8F8F8"   //APP背景颜色
#define kGrayBgColor            @"999999"  // 灰色字体
#define BASEBLACKCOLOR          @"333333"  //Cell title字体黑色
#define BASEPINK                @"fd233c"  //程序基础红色
#define BASELITTLEBLACKCOLOR    @"666666"  //浅的字黑色
#define BASEGreenColor    [UIColor greenColor]  //物流的绿色


#define SDPhotoBrowserBackgrounColor [UIColor colorWithRed:0 green:0 blue:0 alpha:0.95]               // browser背景颜色
//R G B 颜色
#define kMSColorFromRGB(r,g,b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1]

#define Font(F) [UIFont systemFontOfSize:F]

#define kMSCellSubtitleLableColor [UIColor colorWithRed:233/255.0 green:35/255.0 blue:46/255.0 alpha:1]
#define kMSLabelTextColor [UIColor colorWithRed:90/255.0 green:90/255.0 blue:90/255.0 alpha:1]
#define kMSButtonBackColor [UIColor colorWithRed:249/255.0 green:125/255.0 blue:10/255.0 alpha:1]
#define kMSNavBarBackColor [UIColor colorWithRed:253/255.0 green:35/255.0 blue:60/255.0 alpha:1]
#define kMSViewBorderColor [[UIColor colorWithRed:230/255.0 green:230/255.0 blue:230/255.0 alpha:1] CGColor]

#define HEXCOLOR(rgbValue)                                                                                             \
[UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16)) / 255.0                                               \
green:((float)((rgbValue & 0xFF00) >> 8)) / 255.0                                                  \
blue:((float)(rgbValue & 0xFF)) / 255.0                                                           \
alpha:1.0]

#define kMSViewTitleColor [UIColor whiteColor]
#define kMSCellBackColor [UIColor whiteColor]
#define kMSViewBackColor [UIColor whiteColor]


#define kMSScreenWith [UIScreen mainScreen].bounds.size.width


#define ConvertString(str) ([RegularExpressionsMethod isBlankString:str] ? @"0" : str)
#define ConvertNullString(str) ([RegularExpressionsMethod isBlankString:str] ? @"null" : str)
#define ConvertAnonymousString(str) ([RegularExpressionsMethod isBlankString:str] ? @"匿名" : str)
#define kMSStartReplyNotification   @"StartReplyNotification"
#define kMSStartBackNotification   @"StartBackNotification"

#define kMSScreenHeight [UIScreen mainScreen].bounds.size.height


#define kMSNaviHight  64

#define  TAG_Height 100

#define _TencentAppid_  @"1106528553"
#define UmengAppkey @"5a40c52cf43e482d4d000032"
#define kAppIDWeixin         @"wx586d8045169c86f1"
#define kAppSecret         @"b97c4cb8386368a799296656539a4e9e"
#define kRedirectURI    @"https://itunes.apple.com/cn/app/omynail/id1115575145?mt=8"
#define RONGClOUDAPPKEY    @"3argexb63mdle"
#define RONGClOUDAPPSecret     @"omGLVnwCHwubOP"


#define kMSPULLtableViewCellNumber @"10"
#define kMSappVersionCode   @"v1"


#define kEVNScreenNavigationBarHeight 44.f


#define MSDynamicCast(C, o) ({ __typeof__(o) MSDynamicCast__o = (o); [MSDynamicCast__o isKindOfClass:[C class]] ? (C*)MSDynamicCast__o : nil; })

//定义UILabel对象
#define LabelInit(x,y,width,height)  [[UILabel alloc]initWithFrame:CGRectMake(x, y, width, height)]
//定义UIImageView对象
#define ImageViewInit(x,y,width,height) [[UIImageView alloc]initWithFrame:CGRectMake(x, y, width, height)]
//定义UIImageView对象
#define ViewInit(x,y,width,height) [[UIView alloc]initWithFrame:CGRectMake(x, y, width, height)]


#endif
