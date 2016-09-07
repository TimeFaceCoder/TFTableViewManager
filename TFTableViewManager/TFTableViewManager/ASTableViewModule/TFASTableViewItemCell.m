//
//  PFASTableViewItemCell.m
//  TFTableViewManagerDemo
//
//  Created by Summer on 16/9/5.
//  Copyright © 2016年 Summer. All rights reserved.
//

#import "TFASTableViewItemCell.h"
#import "TFTableViewItem.h"

@implementation TFASTableViewItemCell

- (instancetype)initWithTableViewItem:(TFTableViewItem *)tableViewItem {
    self = [super init];
    if (self) {
        self.tableViewItem = tableViewItem;
    }
    [self cellLoadSubNodes];
    return self;
}

- (void)cellLoadSubNodes {
    self.selectionStyle = self.tableViewItem.selectionStyle;
    self.accessoryType = self.tableViewItem.accessoryType;
}

@end
