//
//  ShipCartCell.h
//  TOAFRICA
//
//
//

#import <UIKit/UIKit.h>

@interface ShipCartCell : UITableViewCell
@property (assign, nonatomic) IBOutlet UIButton *btn_select;
@property (assign, nonatomic) IBOutlet UIImageView *img_shipinto;
@property (assign, nonatomic) IBOutlet UILabel *lab_title;
@property (assign, nonatomic) IBOutlet UILabel *lab_price;
@property (assign, nonatomic) IBOutlet UIView *vie_addOr;
@property (assign, nonatomic) IBOutlet UIView *vie_price;
@property (assign, nonatomic) IBOutlet UIButton *btn_subtract;
@property (assign, nonatomic) IBOutlet UIButton *btn_add;
@property (assign, nonatomic) IBOutlet UITextField *textf_number;
@property BOOL isEditState;
@end
