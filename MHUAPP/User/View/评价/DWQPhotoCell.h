

#import <UIKit/UIKit.h>

@interface DWQPhotoCell : UICollectionViewCell

@property (strong, nonatomic) IBOutlet UIImageView *profilePhoto;
@property (strong, nonatomic) IBOutlet UIButton *closeButton;

@property(nonatomic,strong) UIImageView *BigImgView;

/** 查看大图 */
- (void)setBigImgViewWithImage:(UIImage *)img;


@end
