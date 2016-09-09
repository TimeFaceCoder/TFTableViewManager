//
//  TodoHeaderNode.h
//  TFTableViewManager
//
//  Created by zguanyu on 16/9/9.
//  Copyright © 2016年 Summer. All rights reserved.
//

#import <AsyncDisplayKit/AsyncDisplayKit.h>
@class TodoHeaderNode;
@protocol TodoHeaderNodeDelegate <NSObject>

- (void)todoHeaderNode:(TodoHeaderNode*)node didClickButtonIndex:(NSInteger)index;

@end

@interface TodoHeaderNode : ASDisplayNode
@property (nonatomic, weak)id<TodoHeaderNodeDelegate> delegate;
@property (nonatomic, assign)BOOL editing;
@end
