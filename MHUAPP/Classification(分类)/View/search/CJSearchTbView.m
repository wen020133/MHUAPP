//
//  CJSearchTbView.m
//  CJSearchDemo
//
//  Created by 创建zzh on 2017/9/20.
//  Copyright © 2017年 cjzzh. All rights reserved.
//

#import "CJSearchTbView.h"

@interface CJSearchTbView ()
<UITableViewDelegate, UITableViewDataSource>

@end

@implementation CJSearchTbView

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    self = [super initWithFrame:frame style:style];
    if (self) {
        self.delegate = self;
        self.dataSource = self;
        self.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
    }
    return self;
}

#pragma mark -- delegate
#pragma mark -- UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return  self.sourceData.count;
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *identifier0 = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier0];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier0];
        cell.backgroundColor = [UIColor whiteColor];
        cell.textLabel.textColor = [RegularExpressionsMethod ColorWithHexString:BASEBLACKCOLOR];
        cell.textLabel.font = [UIFont systemFontOfSize:14];
        NSString *imageName = @"search_history_icon";
        cell.imageView.image = [UIImage imageNamed:imageName];
        cell.textLabel.font = [UIFont systemFontOfSize:13];
        cell.textLabel.textColor = [RegularExpressionsMethod ColorWithHexString:BASELITTLEBLACKCOLOR];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    cell.textLabel.text = self.sourceData[indexPath.row];
    return cell;
 
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
        NSString *keyword = nil;
        keyword = self.sourceData[indexPath.row];

        if (self.clickResultBlock) {
            self.clickResultBlock(keyword);
            
        }

    
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
}

#pragma mark -- groupHeadView
- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
        NSArray *originData = [[NSUserDefaults standardUserDefaults] objectForKey:kHistroySearchData];
        if (originData.count == 0) return nil;
        
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kMSScreenWith, 30)];
        view.backgroundColor = [UIColor whiteColor];
        
        UILabel *tipLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, kMSScreenWith, 20)];
        tipLabel.text = @"   历史搜索";
        tipLabel.backgroundColor = [UIColor whiteColor];
        tipLabel.textColor = [RegularExpressionsMethod ColorWithHexString:BASEBLACKCOLOR];
        tipLabel.font = [UIFont boldSystemFontOfSize:14];
        [view addSubview:tipLabel];

        UIButton *deleteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        deleteBtn.frame = CGRectMake(kMSScreenWith-60, 0, 50, 30);
        [deleteBtn setImage:[UIImage imageNamed:@"delete_icon"] forState:UIControlStateNormal];
        deleteBtn.contentMode = UIViewContentModeCenter;
        [view addSubview:deleteBtn];
        [deleteBtn addTarget:self action:@selector(deleteAction) forControlEvents:UIControlEventTouchUpInside];
        
        return view;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return [UIView new];
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    NSArray *originData = [[NSUserDefaults standardUserDefaults] objectForKey:kHistroySearchData];
    return  originData.count == 0 ? 0.01 : 30.f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.01;
}
#pragma mark -- Action
- (void)deleteAction {
    if (self.clickDeleteBlock) {
        self.clickDeleteBlock();
    }
}
#pragma mark -- LazyLoad
- (NSMutableArray *)sourceData {
    if (!_sourceData) {
        _sourceData = @[].mutableCopy;
    }
    return _sourceData;
}

@end
