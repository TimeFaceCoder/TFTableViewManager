//
//  PersonItemCellNode.h
//  TFTableViewManager
//
//  Created by zguanyu on 16/9/14.
//  Copyright © 2016年 Summer. All rights reserved.
//

#import "TFTableViewItemCellNode.h"
#import "PersonItem.h"
@interface PersonItemCellNode : TFTableViewItemCellNode
@property (nonatomic, strong)PersonItem * tableViewItem;
@end
