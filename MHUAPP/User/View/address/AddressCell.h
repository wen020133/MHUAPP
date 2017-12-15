//
//  AddressCell.h
//
//  Created by wenchengjun on 15-1-12.
//
//

#import <UIKit/UIKit.h>
#import "WJAddressItem.h"

@interface AddressCell : UITableViewCell
@property (retain, nonatomic) IBOutlet UILabel *lab_Name;
@property (retain, nonatomic) IBOutlet UILabel *lab_telephone;
@property (retain, nonatomic) IBOutlet UILabel *lab_address;
@property (weak, nonatomic) IBOutlet UIButton *btn_edit;
@property (weak, nonatomic) IBOutlet UIButton *btn_Delete;
@property (weak, nonatomic) IBOutlet UIButton *btn_setting;

@property (strong , nonatomic) WJAddressItem *addressItem;
@end
