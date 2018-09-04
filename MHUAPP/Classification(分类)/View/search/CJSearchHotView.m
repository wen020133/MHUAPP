//
//  CJSearchHotView.m
//  CJSearchDemo
//
//  Created by 创建zzh on 2017/9/18.
//  Copyright © 2017年 cjzzh. All rights reserved.
//

#import "CJSearchHotView.h"

@interface CJSearchHotView ()<UIGestureRecognizerDelegate>

@property (nonatomic, strong)UILabel *lastTagLabel;

@end

@implementation CJSearchHotView

- (instancetype)initWithFrame:(CGRect)frame
                     tagColor:(UIColor *)tagColor
                     tagBlock:(ClickHotTagBlock)clickBlock {

    self = [super initWithFrame:frame];
    
    if (self) {
                
        self.userInteractionEnabled = YES;
        
        self.backgroundColor = [UIColor whiteColor];
        
        _tagColor = tagColor;
        
        _clickBlock = clickBlock;
        
    }
    return self;
}

- (void)setHotKeyArr:(NSArray *)hotKeyArr {
    
    _hotKeyArr = hotKeyArr;
    
    //移除所有标签
    [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview) withObject:nil];
    
    //如果没有文本
    if (_hotKeyArr.count == 0) {
        self.hidden = YES;
        return;
    }

    //热门搜索tipLabel
    self.hidden = NO;
    UILabel *tipLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, DCMargin, self.bounds.size.width, 20)];
    tipLabel.text = @"   热门搜索";
    tipLabel.backgroundColor = [UIColor whiteColor];
    tipLabel.textColor = [RegularExpressionsMethod ColorWithHexString:BASEBLACKCOLOR];
    tipLabel.font = [UIFont boldSystemFontOfSize:14];
    [self addSubview:tipLabel];
    

    //复原布局
    _lastTagLabel = nil;
    
    for (int i = 0 ; i<_hotKeyArr.count ;i++) {
        
        NSString *textStr = _hotKeyArr[i];
        
        UILabel *tag = [UILabel new];
        
        tag.text = textStr;
        
        CGSize tagSize = [textStr sizeWithAttributes:@{NSFontAttributeName:Font(13)}];
        tagSize.width += DCMargin*2;
        tagSize.height += DCMargin*2;

        if (i == 0) {
            //第一条，不存在lastTagLabel
            tag.frame = CGRectMake(12, 28+12, tagSize.width, tagSize.height);
        } else {
            
            if (CGRectGetMaxX(_lastTagLabel.frame)+
                15 +
                tagSize.width  > self.bounds.size.width-12) {
                //换行
                tag.frame = CGRectMake(12, CGRectGetMaxY(_lastTagLabel.frame)+10, tagSize.width, tagSize.height);
            }
            else {
                // 同一行
                tag.frame = CGRectMake(CGRectGetMaxX(_lastTagLabel.frame)+15, CGRectGetMinY(_lastTagLabel.frame), tagSize.width, tagSize.height);
                
            }
        }

        //配置文本
        [self configLabel:tag];
        
        [self addSubview:tag];
        
        _lastTagLabel = tag;
        
        //最后一个tag的时候赋值高度
        if (i == _hotKeyArr.count-1) {
            CGRect tempFrame = self.frame;
            tempFrame.size.height = CGRectGetMaxY(_lastTagLabel.frame)+10;
            self.frame = tempFrame;
        }
    }
    

}
- (void)setBgColor:(UIColor *)bgColor {
    _bgColor = bgColor;
    self.backgroundColor = bgColor;
}
#pragma mark -- 文本属性设置
- (void)configLabel:(UILabel *)tag {
    
    
    tag.userInteractionEnabled = YES;
    
    tag.textAlignment = NSTextAlignmentCenter;
    tag.textColor = _tagColor;
    tag.font = Font(13);
    tag.layer.cornerRadius = 10.0;
    tag.layer.borderWidth = 1.0;
    tag.layer.borderColor = [[UIColor colorWithWhite:0.895 alpha:1.000] CGColor];
    tag.clipsToBounds = YES;
    
    //给文本添加点击
    UITapGestureRecognizer *tapOne = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(touchSubTagView:)];
    tapOne.delegate = self;
    tapOne.numberOfTapsRequired = 1.0;
    [tag addGestureRecognizer:tapOne];
}

#pragma mark -- 点击文本
-(void)touchSubTagView:(UITapGestureRecognizer*)tapOne
{
    UILabel *tag = (UILabel *)tapOne.view;
    if (_clickBlock) {
        _clickBlock(tag.text);
    }
}


@end
