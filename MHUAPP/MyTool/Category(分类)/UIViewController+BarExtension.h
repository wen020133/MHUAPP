

#import <UIKit/UIKit.h>
@interface UIViewController (BarExtension)
//设置naviagtionBar
- (void)initSendReplyWithTitle:(NSString *)titleName andLeftButtonName:(NSString *)leftImageName andRightButtonName:(NSString *)rightImageName andTitleLeftOrRight:(BOOL)yesOrNo;

- (void)initSendReplyWithTitleImage:(NSString *)titleName andLeftButtonNameImage:(NSString *)leftImageName andRightButtonName:(NSString *)rightImageName;

@end
