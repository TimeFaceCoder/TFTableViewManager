//
//  TestUICell.h
//  PFTableViewManagerDemo
//
//  Created by Summer on 16/9/1.
//  Copyright © 2016年 Summer. All rights reserved.
//

#import "TFUITableViewItemCell.h"
#import "TestUIItem.h"

@interface TestUIItemCell : TFUITableViewItemCell

/** @brief TestUIItem */
@property (nonatomic, strong) TestUIItem *tableViewItem;

@end
