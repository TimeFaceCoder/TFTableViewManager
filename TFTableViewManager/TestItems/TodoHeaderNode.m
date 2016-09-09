//
//  TodoHeaderNode.m
//  TFTableViewManager
//
//  Created by zguanyu on 16/9/9.
//  Copyright © 2016年 Summer. All rights reserved.
//

#import "TodoHeaderNode.h"

@interface TodoHeaderNode ()
@property (nonatomic, strong)ASButtonNode* createButtonNode;
@property (nonatomic, strong)ASButtonNode* deleteButtonNode;
@end

@implementation TodoHeaderNode

- (ASButtonNode *)createButtonNode {
    if (!_createButtonNode) {
        _createButtonNode = [[ASButtonNode alloc]init];
        [_createButtonNode setTitle:@"新建" withFont:[UIFont systemFontOfSize:14] withColor:[UIColor blueColor] forState:ASControlStateNormal];
        [_createButtonNode setImage:[UIImage imageNamed:@"add-icon"] forState:ASControlStateNormal];
    }
    return _createButtonNode;
}
- (ASButtonNode *)deleteButtonNode {
    if (!_deleteButtonNode) {
        _deleteButtonNode = [[ASButtonNode alloc]init];
        [_deleteButtonNode setTitle:@"删除" withFont:[UIFont systemFontOfSize:14] withColor:[UIColor blueColor] forState:ASControlStateNormal];
        [_createButtonNode setImage:[UIImage imageNamed:@"close-icon"] forState:ASControlStateNormal];
    }
    return _deleteButtonNode;
}

- (instancetype)init {
    if (self = [super init]) {
        [self addSubnode:self.createButtonNode];
        [self addSubnode:self.deleteButtonNode];
    }
    return self;
}

- (ASLayoutSpec *)layoutSpecThatFits:(ASSizeRange)constrainedSize {
    ASStackLayoutSpec* stackLayoutSpec = [ASStackLayoutSpec horizontalStackLayoutSpec];
    stackLayoutSpec.children = @[self.createButtonNode,self.deleteButtonNode];
    stackLayoutSpec.justifyContent = ASStackLayoutJustifyContentSpaceBetween;
    stackLayoutSpec.alignItems = ASStackLayoutAlignItemsCenter;
    
    return [ASInsetLayoutSpec insetLayoutSpecWithInsets:UIEdgeInsetsMake(8, 8, 8, 8) child:stackLayoutSpec];
}

@end
