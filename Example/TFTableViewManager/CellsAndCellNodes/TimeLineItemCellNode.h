//
//  TimeLineItemCell.h
//  TableNodeDataManager_Example
//
//  Created by Melvin on 2018/8/8.
//  Copyright © 2018 melvin7. All rights reserved.
//
#import "TFTableViewItemCellNode.h"
#import "TimeLineItem.h"
NS_ASSUME_NONNULL_BEGIN

@interface TimeLineItemCellNode : TFTableViewItemCellNode

@property (strong, readwrite, nonatomic) TimeLineItem *tableViewItem;

@end

NS_ASSUME_NONNULL_END
