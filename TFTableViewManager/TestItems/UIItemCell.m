//
//  UIItemCell.m
//  TFTableViewManager
//
//  Created by zguanyu on 16/9/26.
//  Copyright © 2016年 Summer. All rights reserved.
//

#import "UIItemCell.h"

@interface UIItemCell ()
@property (nonatomic, strong)UILabel* titleLabelForLine1;
@property (nonatomic, strong)UILabel* titleLabelForLine2;
@property (nonatomic, strong)UILabel* titleLabelForLine3;


@property (nonatomic, strong)UILabel* detailLabelForLine1;
@property (nonatomic, strong)UILabel* detailLabelForLine2;
@property (nonatomic, strong)UILabel* detailLabelForLine3;

@end

@implementation UIItemCell

- (UILabel *)titleLabelForLine1 {
    if (!_titleLabelForLine1) {
        _titleLabelForLine1 = [[UILabel alloc]init];
    }
    return _titleLabelForLine1;
}

- (UILabel *)titleLabelForLine2 {
    if (!_titleLabelForLine2) {
        _titleLabelForLine2 = [[UILabel alloc]init];
    }
    return _titleLabelForLine2;
}
- (UILabel *)titleLabelForLine3 {
    if (!_titleLabelForLine3) {
        _titleLabelForLine3 = [[UILabel alloc]init];
    }
    return _titleLabelForLine3;
}
- (void)cellLoadSubViews {
    [super cellLoadSubViews];
    
    [self addSubview:self.titleLabelForLine1];
    [self addSubview:self.titleLabelForLine2];
    [self addSubview:self.titleLabelForLine3];
    
    [self addSubview:self.detailLabelForLine1];
    [self addSubview:self.detailLabelForLine2];
    [self addSubview:self.detailLabelForLine3];
    
}

@end
