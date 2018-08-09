//
//  TestSectionHeaderView.m
//  TFTableViewManager
//
//  Created by Summer on 2017/12/26.
//  Copyright © 2017年 TFAppleWork-Summer. All rights reserved.
//

#import "TestSectionHeaderView.h"

@interface TestSectionHeaderView ()

@property (nonatomic, strong) UILabel *titleLabel;



@end

@implementation TestSectionHeaderView

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithReuseIdentifier:reuseIdentifier];
    if (self) {
        [self.contentView addSubview:self.titleLabel];
        
        _titleLabel.translatesAutoresizingMaskIntoConstraints = NO;
        [NSLayoutConstraint constraintWithItem:self.titleLabel attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeLeft multiplier:1.0 constant:16.0].active = YES;
        [NSLayoutConstraint constraintWithItem:self.titleLabel attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0.0].active = YES;
    }
    return self;
}

- (void)setTitle:(NSString *)title {
    _title = title;
    _titleLabel.text = title;
}

#pragma mark - lazy load.

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.textColor = [UIColor grayColor];
        _titleLabel.font = [UIFont systemFontOfSize:16];
    }
    return _titleLabel;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
