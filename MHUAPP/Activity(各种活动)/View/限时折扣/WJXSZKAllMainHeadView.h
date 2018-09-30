//
//  WJXSZKAllMainHeadView.h
//  MHUAPP
//
//  Created by jinri on 2018/9/30.
//  Copyright © 2018年 wenchengjun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HXSearchBar.h"


@interface WJXSZKAllMainHeadView : UICollectionReusableView<UISearchBarDelegate>

@property (strong, nonatomic) HXSearchBar *searchBar;

/* 图片 */
@property (strong , nonatomic) UIImageView *img_content;


/** 点击搜索 */
@property (nonatomic , copy) void(^userChickSearch)(NSString *searchText);
@end
