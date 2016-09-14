//
//  PersonItemCellNode.m
//  TFTableViewManager
//
//  Created by zguanyu on 16/9/14.
//  Copyright © 2016年 Summer. All rights reserved.
//

#import "PersonItemCellNode.h"

@interface PersonItemCellNode ()
@property (nonatomic, strong) ASImageNode *avatarNode;

@property (nonatomic, strong) ASTextNode *nameNode;

@property (nonatomic, strong) ASTextNode *phoneNode;

@property (nonatomic, strong) ASButtonNode* phoneButtonNode;
@property (nonatomic, strong) ASButtonNode* messageButtonNode;
@end

@implementation PersonItemCellNode
@dynamic tableViewItem;
- (void)cellLoadSubNodes {
    [super cellLoadSubNodes];
    [self addSubnode:self.avatarNode];
    [self addSubnode:self.nameNode];
    [self addSubnode:self.phoneNode];
    
    [self addSubnode:self.phoneButtonNode];
    [self addSubnode:self.messageButtonNode];
    
    _nameNode.attributedText = [[NSAttributedString alloc] initWithString:self.tableViewItem.model.name attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15],NSForegroundColorAttributeName:[UIColor blackColor]}];
    _phoneNode.attributedText = [[NSAttributedString alloc] initWithString:self.tableViewItem.model.phone attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13],NSForegroundColorAttributeName:[UIColor lightGrayColor]}];
    
    _avatarNode.image = [UIImage imageNamed:self.tableViewItem.model.avatar];
}

- (ASLayoutSpec *)layoutSpecThatFits:(ASSizeRange)constrainedSize {
    
    ASStackLayoutSpec *infoSpec = [ASStackLayoutSpec verticalStackLayoutSpec];
    infoSpec.children = @[_nameNode,_phoneNode];
    infoSpec.spacing = 8.0;
    ASStackLayoutSpec *contentSpec = [ASStackLayoutSpec horizontalStackLayoutSpec];
    contentSpec.children = @[_avatarNode,infoSpec];
    contentSpec.spacing = 8.0;
    contentSpec.alignItems = ASStackLayoutAlignItemsCenter;
    ASInsetLayoutSpec *insetSpec = [ASInsetLayoutSpec insetLayoutSpecWithInsets:UIEdgeInsetsMake(10.0, 15.0, 10.0, 15.0) child:contentSpec];
    
    ASStackLayoutSpec *buttonsSpec = [ASStackLayoutSpec horizontalStackLayoutSpec];
    buttonsSpec.children = @[self.phoneButtonNode, self.messageButtonNode];
    buttonsSpec.spacing = 15.0f;
    buttonsSpec.alignItems = ASStackLayoutAlignItemsCenter;
    buttonsSpec.flexGrow = NO;
    ASStackLayoutSpec* allSpec = [ASStackLayoutSpec horizontalStackLayoutSpec];
    allSpec.children = @[insetSpec, [ASInsetLayoutSpec insetLayoutSpecWithInsets:UIEdgeInsetsMake(0, 0, 0, 20) child:buttonsSpec]];
    allSpec.alignItems = ASStackLayoutAlignItemsCenter;
    allSpec.justifyContent = ASStackLayoutJustifyContentSpaceBetween;
    return allSpec;
}

- (void)layout {
    [super layout];
    _avatarNode.cornerRadius = 20.0;
    _avatarNode.layer.masksToBounds = YES;
}

#pragma mark - lazy init



- (ASImageNode *)avatarNode {
    if (!_avatarNode) {
        _avatarNode = [[ASImageNode alloc] init];
        _avatarNode.preferredFrameSize = CGSizeMake(40.0, 40.0);
    }
    return _avatarNode;
}

- (ASTextNode *)nameNode {
    if (!_nameNode) {
        _nameNode = [[ASTextNode alloc] init];
    }
    return _nameNode;
}

- (ASTextNode *)phoneNode {
    if (!_phoneNode) {
        _phoneNode = [[ASTextNode alloc] init];
    }
    return _phoneNode;
}

- (ASButtonNode *)phoneButtonNode {
    if (!_phoneButtonNode) {
        _phoneButtonNode = [[ASButtonNode alloc]init];
        [_phoneButtonNode setImage:[UIImage imageNamed:@"phone-icon"] forState:ASControlStateNormal];
    }
    return _phoneButtonNode;
}


- (ASButtonNode *)messageButtonNode {
    if (!_messageButtonNode) {
        _messageButtonNode = [[ASButtonNode alloc]init];
        [_messageButtonNode setImage:[UIImage imageNamed:@"message-icon"] forState:ASControlStateNormal];
    }
    return _messageButtonNode;
}

@end
