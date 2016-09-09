//
//  TestUICell.h
//  TFTableViewManagerDemo
//
//  Created by Summer on 16/9/1.
//  Copyright © 2016年 Summer. All rights reserved.
//

#import "TFTableViewItemCell.h"
#import "TestUIItem.h"

@interface TestUIItemCell : TFTableViewItemCell

/** @brief TestUIItem */
@property (nonatomic, strong) TestUIItem *tableViewItem;

@end
