//
//  TestUICell.m
//  TFTableViewManagerDemo
//
//  Created by Summer on 16/9/1.
//  Copyright © 2016年 Summer. All rights reserved.
//

#import "TestItemCell.h"

@interface TestItemCell ()

@property (nonatomic,strong) UIImageView *userPhotoImageView;

@property (nonatomic,strong) UILabel *userNameLabel;

@property (nonatomic,strong) UILabel *userPhoneLabel;

@property (nonatomic,strong) UIButton *selectedBtn;

@end

@implementation TestItemCell

@dynamic tableViewItem;

+ (CGFloat)heightWithItem:(TFTableViewItem *)item tableViewManager:(TFTableViewManager *)tableViewManager {
    return 60.0;
}

- (void)cellLoadSubViews {
    [super cellLoadSubViews];
    [self.contentView addSubview:self.selectedBtn];
    [self.contentView addSubview:self.userPhotoImageView];
    [self.contentView addSubview:self.userNameLabel];
    [self.contentView addSubview:self.userPhoneLabel];
}

- (void)cellWillAppear {
    [super cellWillAppear];
    self.selectedBtn.selected = self.tableViewItem.model.selected;
    self.userPhotoImageView.image = [UIImage imageNamed:self.tableViewItem.model.userPhoto];
    self.userNameLabel.text = self.tableViewItem.model.userName;
    self.userPhoneLabel.text = self.tableViewItem.model.userPhone;
    
    
}

#pragma mark selectedBtn
-(UIButton *)selectedBtn {
    if (!_selectedBtn) {
        _selectedBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _selectedBtn.frame = CGRectMake(10, 10, 40, 40);
        [_selectedBtn setImage:[UIImage imageNamed:@"contactNotSelect"] forState:UIControlStateNormal];
        [_selectedBtn setImage:[UIImage imageNamed:@"contactSelected"] forState:UIControlStateSelected];
        _selectedBtn.userInteractionEnabled = NO;
    }
    return _selectedBtn;
}

-(UIImageView *)userPhotoImageView {
    if (!_userPhotoImageView) {
        _userPhotoImageView = [[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_selectedBtn.frame)+10.0, 10, 40, 40)];
        _userPhotoImageView.layer.cornerRadius = 20.0;
        _userPhotoImageView.layer.masksToBounds = YES;
    }
    return _userPhotoImageView;
}

-(UILabel *)userNameLabel {
    if (!_userNameLabel) {
        _userNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_userPhotoImageView.frame)+10.0, 10, 200, 20)];
        _userNameLabel.font = [UIFont systemFontOfSize:15];
        _userNameLabel.textColor = [UIColor blackColor];
    }
    return _userNameLabel;
}



-(UILabel *)userPhoneLabel {
    if (!_userPhoneLabel) {
        _userPhoneLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_userPhotoImageView.frame)+10.0, 30, 200, 20)];
        _userPhoneLabel.font = [UIFont systemFontOfSize:13];
        _userPhoneLabel.textColor = [UIColor lightGrayColor];
    }
    return _userPhoneLabel;
}

//- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
//    self = [super initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:reuseIdentifier];
//    if (self) {
//        
//    }
//    return self;
//}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
