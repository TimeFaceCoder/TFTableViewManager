//
//  TFUIBaseTableViewItemCell.m
//  PFTableViewManagerDemo
//
//  Created by Summer on 16/9/5.
//  Copyright © 2016年 Summer. All rights reserved.
//

#import "TFUIBaseTableViewItemCell.h"

@implementation TFUIBaseTableViewItemCell

@dynamic tableViewItem;

+ (CGFloat)heightWithItem:(TFUIBaseTableViewItem *)item tableViewManager:(TFUITableViewManager *)tableViewManager {
    return item.cellHeight ? :44.0;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:self.tableViewItem.cellStyle reuseIdentifier:reuseIdentifier];
    if (self) {
        
    }
    return self;
}

- (void)cellLoadSubViews {
    [super cellLoadSubViews];
   
}

- (void)cellWillAppear {
    [super cellWillAppear];
    if (self.tableViewItem.image) {
        self.imageView.image = self.tableViewItem.image;
    }
    self.textLabel.text = self.tableViewItem.text;
    if (self.tableViewItem.textFont) {
        self.textLabel.font = self.tableViewItem.textFont;
    }
    if (self.tableViewItem.textColor) {
        self.textLabel.textColor = self.tableViewItem.textColor;
    }
    if (self.detailTextLabel) {
        self.detailTextLabel.text = self.tableViewItem.detail;
        if (self.tableViewItem.detailFont) {
            self.detailTextLabel.font = self.tableViewItem.detailFont;
        }
        if (self.tableViewItem.detailColor) {
            self.detailTextLabel.textColor = self.tableViewItem.detailColor;
        }
    }
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
