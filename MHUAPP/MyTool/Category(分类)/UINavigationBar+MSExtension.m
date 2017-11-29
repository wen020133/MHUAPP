
#import "UINavigationBar+MSExtension.h"
#import <Foundation/NSObjCRuntime.h>
#import <objc/objc-api.h>
#import <objc/runtime.h>

#define MSNavigationBarID 77779999

NSString * const kMSNavigationBar_ScrollToTopNotification = @"MSNavigationBar.ScrollToTopNotification";

@implementation UINavigationController(KeyboardDismiss)

// up even when there is no first responder.
// See: http://stackoverflow.com/questions/3372333/ipad-keyboard-will-not-dismiss-if-navigation-controller-presentation-style-is-fo
- (BOOL)disablesAutomaticKeyboardDismissal
{
    return NO;
}

@end

static void Swizzle(Class c, SEL orig, SEL new) {
    Method origMethod = class_getInstanceMethod(c, orig);
    Method newMethod = class_getInstanceMethod(c, new);
    if(class_addMethod(c, orig, method_getImplementation(newMethod), method_getTypeEncoding(newMethod)))
        class_replaceMethod(c, new, method_getImplementation(origMethod), method_getTypeEncoding(origMethod));
    else
        method_exchangeImplementations(origMethod, newMethod);
}

@implementation UINavigationBar(MSExtension)

+ (void)load
{
    bool canHack = ([[[[UIDevice currentDevice] systemVersion] substringToIndex:1] intValue] < 5);
    
    if ( canHack )
    {
        if (1)
        {
            Swizzle(self, @selector(drawRect:), @selector(drawRect_MSNavigationBar:));
        }
        
        if (1)
        {
            Swizzle(self, @selector(touchesBegan:withEvent:), @selector(MSNavigationBar_touchesBegan:withEvent:));
        }
        
        {
            Swizzle(self, @selector(updateTitleView), @selector(MSNavigationBar_updateTitleView));
        }
    }
}
-(void)updateTitleView
{
    
}
-(void)MSNavigationBar_updateTitleView
{
    
    [self MSNavigationBar_updateTitleView];
}

-(UIImage*)backgroundImageForMSNavigationBar:(UIDeviceOrientation)orientation
{
    
    UIImage *backgroundImage = nil;
    backgroundImage = [self createImageWithColor:kMSNavBarBackColor];
    return backgroundImage;
}

-(void)setIsMSNavigationBar
{
    if ([self respondsToSelector:@selector(setBackgroundImage:forBarMetrics:)])
        {
            UIImage *backgroundImage = [self backgroundImageForMSNavigationBar:UIDeviceOrientationUnknown];
            CGSize imSize = backgroundImage.size;
            if ((NSInteger)imSize.width > 3)
            {
                backgroundImage = [backgroundImage stretchableImageWithLeftCapWidth:5 topCapHeight:6];
            }
            [self setBackgroundImage:backgroundImage forBarMetrics:UIBarMetricsDefault];
        }

}

//颜色生成图片
- (UIImage *) createImageWithColor: (UIColor *) color
{
    CGRect rect=CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}

- (void)drawRect_MSNavigationBar:(CGRect)aRect
{
    if (self.tag == MSNavigationBarID)
    {
        UIImage *backgroundImage = [self backgroundImageForMSNavigationBar:UIDeviceOrientationUnknown];
        CGSize imSize = backgroundImage.size;
        // tchan: valid non-zero values are in [1,size-2].
        // Using size-1 or size results in errors like
        //   <Error>: CGImageCreateWithImageProvider: invalid image size: 0 x 0
        // With "sizes" of 0,0, 1,1, or leftCapWidth,leftCapWidth (suggesting that it's bugged and prints out width,width).
        if ((NSInteger)imSize.width > 3)
        {
            backgroundImage = [backgroundImage stretchableImageWithLeftCapWidth:5 topCapHeight:6];
        }
        [backgroundImage drawInRect:self.bounds];
    }
    else
    {
        [self drawRect_MSNavigationBar:aRect];
    }
}

- (void)MSNavigationBar_touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [[NSNotificationCenter defaultCenter] postNotificationName:kMSNavigationBar_ScrollToTopNotification object:nil];
    [self MSNavigationBar_touchesBegan:touches withEvent:event];
}

@end
