//
//  PFUITableViewItemCell.m
//  PFTableViewManagerDemo
//
//  Created by Summer on 16/8/26.
//  Copyright © 2016年 Summer. All rights reserved.
//

#import "TFUITableViewItemCell.h"
#import "TFTableViewItem.h"

@interface TFUITableViewItemCell ()

@end

@implementation TFUITableViewItemCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
}

#pragma mark - Handling Cell Events.

+ (CGFloat)heightWithItem:(TFTableViewItem *)item tableViewManager:(TFUITableViewManager *)tableViewManager
{
    return UITableViewAutomaticDimension;
}

#pragma mark - Cell life cycle

- (void)cellLoadSubViews {
    //add subviews at here.
    self.selectionStyle = self.tableViewItem.selectionStyle;
    self.accessoryType = self.tableViewItem.accessoryType;
    if (self.tableViewItem.accessoryView) {
        self.accessoryView = self.tableViewItem.accessoryView;
    }
    self.preservesSuperviewLayoutMargins = NO;
    UIEdgeInsets lineInsets =  UIEdgeInsetsMake(0, self.tableViewItem.separatorLineLeftSpace, 0.0, 0.0);
    self.separatorInset = lineInsets;
    self.layoutMargins = lineInsets;
}

- (void)cellWillAppear {
    //set subviews property values at here.
    
}

- (void)cellDidDisappear {
    
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
