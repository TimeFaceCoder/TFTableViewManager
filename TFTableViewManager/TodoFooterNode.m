//
//  TodoFooterNode.m
//  TFTableViewManager
//
//  Created by zguanyu on 16/9/9.
//  Copyright © 2016年 Summer. All rights reserved.
//

#import "TodoFooterNode.h"

@interface TodoFooterNode ()
@property (nonatomic, strong)ASButtonNode* cancleButtonNode;
@property (nonatomic, strong)ASButtonNode* deleteButtonNode;
@end

@implementation TodoFooterNode
- (ASButtonNode *)cancleButtonNode {
    if (!_cancleButtonNode) {
        _cancleButtonNode = [[ASButtonNode alloc]init];
        [_cancleButtonNode setTitle:@"取消" withFont:[UIFont systemFontOfSize:16] withColor:[UIColor blueColor] forState:ASControlStateNormal];
        [_cancleButtonNode setImage:[UIImage imageNamed:@"cancel-icon"] forState:ASControlStateNormal];
        [_cancleButtonNode addTarget:self action:@selector(onCreateButtonClicked:) forControlEvents:ASControlNodeEventTouchUpInside];
    }
    return _cancleButtonNode;
}
- (ASButtonNode *)deleteButtonNode {
    if (!_deleteButtonNode) {
        _deleteButtonNode = [[ASButtonNode alloc]init];
        [_deleteButtonNode setTitle:@"删除" withFont:[UIFont systemFontOfSize:16] withColor:[UIColor redColor] forState:ASControlStateNormal];
        [_deleteButtonNode setImage:[UIImage imageNamed:@"del-icon"] forState:ASControlStateNormal];
        
        [_deleteButtonNode addTarget:self action:@selector(onDeleteButtonClicked:) forControlEvents:ASControlNodeEventTouchUpInside];
    }
    return _deleteButtonNode;
}
- (void)onCreateButtonClicked:(id)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(todoFooterNode:didClickButtonIndex:)]) {
        [self.delegate todoFooterNode:self didClickButtonIndex:0];
    }
}
- (void)onDeleteButtonClicked:(id)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(todoFooterNode:didClickButtonIndex:)]) {
        [self.delegate todoFooterNode:self didClickButtonIndex:1];
    }
}
- (instancetype)init {
    if (self = [super init]) {
        [self addSubnode:self.cancleButtonNode];
        [self addSubnode:self.deleteButtonNode];
        self.backgroundColor = [UIColor colorWithRed:250.0f/255.0f green:250.0/255.0f blue:250.0f/255.0f alpha:1.0f];
    }
    return self;
}

- (ASLayoutSpec *)layoutSpecThatFits:(ASSizeRange)constrainedSize {
    ASStackLayoutSpec* stackLayoutSpec = [ASStackLayoutSpec horizontalStackLayoutSpec];
    stackLayoutSpec.children = @[self.cancleButtonNode,self.deleteButtonNode];
    stackLayoutSpec.justifyContent = ASStackLayoutJustifyContentSpaceAround;
    stackLayoutSpec.alignItems = ASStackLayoutAlignItemsCenter;
    
    return [ASInsetLayoutSpec insetLayoutSpecWithInsets:UIEdgeInsetsMake(15, 15, 15, 15) child:stackLayoutSpec];
}
@end
