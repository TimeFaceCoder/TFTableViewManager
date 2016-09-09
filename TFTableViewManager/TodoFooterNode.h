//
//  TodoFooterNode.h
//  TFTableViewManager
//
//  Created by zguanyu on 16/9/9.
//  Copyright © 2016年 Summer. All rights reserved.
//

#import <AsyncDisplayKit/AsyncDisplayKit.h>
@class TodoFooterNode;
@protocol TodoFooterNodeeDelegate <NSObject>

- (void)todoFooterNode:(TodoFooterNode*)node didClickButtonIndex:(NSInteger)index;

@end
@interface TodoFooterNode : ASDisplayNode
@property (nonatomic, weak)id<TodoFooterNodeeDelegate> delegate;
@end
