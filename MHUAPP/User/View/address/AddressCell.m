//
//  AddressCell.m
//
//  Created by wenchengjun on 15-1-12.
//
//

#import "AddressCell.h"

@implementation AddressCell

- (void)awakeFromNib {
    // Initialization code
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)setAddressItem:(WJAddressItem *)addressItem
{
    _addressItem = addressItem;
    _lab_Name.text = ConvertNullString(addressItem.consignee);
    _lab_address.text = ConvertNullString(addressItem.assemble_site);
    _lab_telephone.text = ConvertNullString(addressItem.mobile);
}

@end
