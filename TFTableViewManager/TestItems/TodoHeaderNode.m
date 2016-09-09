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
        [_createButtonNode setTitle:@"新建" withFont:[UIFont systemFontOfSize:16] withColor:[UIColor blueColor] forState:ASControlStateNormal];
        [_createButtonNode setImage:[UIImage imageNamed:@"add-icon"] forState:ASControlStateNormal];
        [_createButtonNode addTarget:self action:@selector(onCreateButtonClicked:) forControlEvents:ASControlNodeEventTouchUpInside];
    }
    return _createButtonNode;
}
- (ASButtonNode *)deleteButtonNode {
    if (!_deleteButtonNode) {
        _deleteButtonNode = [[ASButtonNode alloc]init];
        [_deleteButtonNode setTitle:@"删除" withFont:[UIFont systemFontOfSize:16] withColor:[UIColor redColor] forState:ASControlStateNormal];
        [_deleteButtonNode setImage:[UIImage imageNamed:@"close-icon"] forState:ASControlStateNormal];
        [_deleteButtonNode setTitle:@"全选" withFont:[UIFont systemFontOfSize:16] withColor:[UIColor redColor] forState:ASControlStateSelected];
        [_deleteButtonNode setImage:[UIImage imageNamed:@"ok-icon"] forState:ASControlStateSelected];
        [_deleteButtonNode addTarget:self action:@selector(onDeleteButtonClicked:) forControlEvents:ASControlNodeEventTouchUpInside];
    }
    return _deleteButtonNode;
}
- (void)onCreateButtonClicked:(id)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(todoHeaderNode:didClickButtonIndex:)]) {
        [self.delegate todoHeaderNode:self didClickButtonIndex:0];
    }
}
- (void)onDeleteButtonClicked:(id)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(todoHeaderNode:didClickButtonIndex:)]) {
        [self.delegate todoHeaderNode:self didClickButtonIndex:1];
    }
    if (!self.editing) {
        self.editing = YES;
        self.deleteButtonNode.selected = YES;
    }
}
- (instancetype)init {
    if (self = [super init]) {
        [self addSubnode:self.createButtonNode];
        [self addSubnode:self.deleteButtonNode];
        self.backgroundColor = [UIColor colorWithRed:250.0f/255.0f green:250.0/255.0f blue:250.0f/255.0f alpha:1.0f];
    }
    return self;
}

- (void)layout {
    [super layout];
    self.deleteButtonNode.selected = self.editing;
}

- (ASLayoutSpec *)layoutSpecThatFits:(ASSizeRange)constrainedSize {
    ASStackLayoutSpec* stackLayoutSpec = [ASStackLayoutSpec horizontalStackLayoutSpec];
    stackLayoutSpec.children = @[self.createButtonNode,self.deleteButtonNode];
    stackLayoutSpec.justifyContent = ASStackLayoutJustifyContentSpaceBetween;
    stackLayoutSpec.alignItems = ASStackLayoutAlignItemsCenter;
    
    return [ASInsetLayoutSpec insetLayoutSpecWithInsets:UIEdgeInsetsMake(15, 15, 15, 15) child:stackLayoutSpec];
}

@end
