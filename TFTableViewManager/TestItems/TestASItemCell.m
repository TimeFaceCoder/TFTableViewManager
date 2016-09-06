//
//  TestASItemCell.m
//  PFTableViewManagerDemo
//
//  Created by Summer on 16/9/5.
//  Copyright © 2016年 Summer. All rights reserved.
//

#import "TestASItemCell.h"

@interface TestASItemCell ()

@property (nonatomic, strong) ASButtonNode *selectNode;

@property (nonatomic, strong) ASImageNode *avatarNode;

@property (nonatomic, strong) ASTextNode *nameNode;

@property (nonatomic, strong) ASTextNode *phoneNode;

@end

@implementation TestASItemCell

@dynamic tableViewItem;

- (void)cellLoadSubNodes {
    [super cellLoadSubNodes];
    [self addSubnode:self.selectNode];
    [self addSubnode:self.avatarNode];
    [self addSubnode:self.nameNode];
    [self addSubnode:self.phoneNode];
    
    _nameNode.attributedText = [[NSAttributedString alloc] initWithString:self.tableViewItem.model.userName attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15],NSForegroundColorAttributeName:[UIColor blackColor]}];
    _phoneNode.attributedText = [[NSAttributedString alloc] initWithString:self.tableViewItem.model.userPhone attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13],NSForegroundColorAttributeName:[UIColor lightGrayColor]}];
    _selectNode.selected = self.tableViewItem.model.selected;
    _avatarNode.image = [UIImage imageNamed:self.tableViewItem.model.userPhoto];
}

- (ASLayoutSpec *)layoutSpecThatFits:(ASSizeRange)constrainedSize {
    
    ASStackLayoutSpec *infoSpec = [ASStackLayoutSpec verticalStackLayoutSpec];
    infoSpec.children = @[_nameNode,_phoneNode];
    infoSpec.spacing = 8.0;
    ASStackLayoutSpec *contentSpec = [ASStackLayoutSpec horizontalStackLayoutSpec];
    contentSpec.children = @[_selectNode,_avatarNode,infoSpec];
    contentSpec.spacing = 8.0;
    contentSpec.alignItems = ASStackLayoutAlignItemsCenter;
    ASInsetLayoutSpec *insetSpec = [ASInsetLayoutSpec insetLayoutSpecWithInsets:UIEdgeInsetsMake(10.0, 15.0, 10.0, 15.0) child:contentSpec];
    return insetSpec;
}

- (void)layout {
    [super layout];
    _avatarNode.cornerRadius = 20.0;
    _avatarNode.layer.masksToBounds = YES;
}

#pragma mark - lazy init

- (ASButtonNode *)selectNode {
    if (!_selectNode) {
        _selectNode = [[ASButtonNode alloc] init];
        [_selectNode setImage:[UIImage imageNamed:@"contactNotSelect"] forState:ASControlStateNormal];
        [_selectNode setImage:[UIImage imageNamed:@"contactSelected"] forState:ASControlStateSelected];
        _selectNode.userInteractionEnabled = NO;
    }
    return _selectNode;
}

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


@end
