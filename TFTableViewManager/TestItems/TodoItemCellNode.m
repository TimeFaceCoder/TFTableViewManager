//
//  TodoItemCell.m
//  TFTableViewManager
//
//  Created by zguanyu on 16/9/9.
//  Copyright © 2016年 Summer. All rights reserved.
//

#import "TodoItemCellNode.h"
#import "TestItem.h"
#import "TestModel.h"
@interface TodoItemCellNode ()
@property (nonatomic, strong)ASImageNode* imageNode;
@property (nonatomic, strong)ASTextNode* titleNode;
@property (nonatomic, strong)ASTextNode* startDateNode;
@property (nonatomic, strong)ASTextNode* endDateNode;
@property (nonatomic, strong)ASButtonNode* selectButton;
@end

@implementation TodoItemCellNode

- (ASImageNode *)imageNode {
    if (!_imageNode) {
        _imageNode = [[ASImageNode alloc]init];
        _imageNode.image = [UIImage imageNamed:@"calendar-icon-3"];
    }
    return _imageNode;
}

- (ASTextNode *)titleNode {
    if (!_titleNode) {
        _titleNode = [[ASTextNode alloc]init];
        _titleNode.attributedText = [[NSAttributedString alloc]initWithString:@"今天晚上去吃饭"];
    }
    return _titleNode;
}

- (ASTextNode *)startDateNode {
    if (!_startDateNode) {
        _startDateNode = [[ASTextNode alloc]init];
        _startDateNode.attributedText = [[NSAttributedString alloc]initWithString:@"开始时间:2014-12-14 12:23" attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12], NSForegroundColorAttributeName:[UIColor blueColor]}];
    }
    return _startDateNode;
}

- (ASTextNode *)endDateNode {
    if (!_endDateNode) {
        _endDateNode = [[ASTextNode alloc]init];
        _endDateNode.attributedText = [[NSAttributedString alloc]initWithString:@"开始时间:2014-12-14 12:23" attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12], NSForegroundColorAttributeName:[UIColor blueColor]}];
    }
    return _endDateNode;
}

- (ASButtonNode *)selectButton {
    if (!_selectButton) {
        _selectButton = [[ASButtonNode alloc]init];
        
        [_selectButton setImage:[UIImage imageNamed:@"contactNotSelect"] forState:ASControlStateNormal];
        [_selectButton setImage:[UIImage imageNamed:@"contactSelected"] forState:ASControlStateSelected];
        [_selectButton addTarget:self action:@selector(onSelectButtonClicked:) forControlEvents:ASControlNodeEventTouchUpInside];
    }
    return _selectButton;
}

- (void)onSelectButtonClicked:(id)sender {
    self.selectButton.selected = !self.selectButton.selected;
    [self.tableViewItem.model setSelected:self.selectButton.selected];// = self.selectButton.selected;
}

- (void)layout {
    [super layout];
    self.selectButton.selected = [self.tableViewItem.model selected];
}

-(void)cellLoadSubNodes {
    [super cellLoadSubNodes];
    [self addSubnode:self.selectButton];
    self.selectButton.hidden = YES;
    [self addSubnode:self.imageNode];
    [self addSubnode:self.titleNode];
    [self addSubnode:self.startDateNode];
    [self addSubnode:self.endDateNode];
    
    self.titleNode.attributedText = [[NSAttributedString alloc] initWithString:[self.tableViewItem.model userName] attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15],NSForegroundColorAttributeName:[UIColor blackColor]}];
}

- (ASLayoutSpec *)layoutSpecThatFits:(ASSizeRange)constrainedSize {
    
    ASStackLayoutSpec *infoSpec = [ASStackLayoutSpec verticalStackLayoutSpec];
    
    infoSpec.children = @[self.titleNode,self.startDateNode,self.endDateNode];
//    self.titleNode.spacingBefore = 8;
    self.titleNode.spacingAfter = 8;
    infoSpec.spacing = 0;
    infoSpec.justifyContent = ASStackLayoutJustifyContentStart;
    infoSpec.alignItems = ASStackLayoutAlignItemsStart;
    ASStackLayoutSpec *contentSpec = [ASStackLayoutSpec horizontalStackLayoutSpec];
    if ([self.tableViewItem.model editing]) {
        self.selectButton.hidden = NO;
        contentSpec.children = @[self.selectButton,self.imageNode,infoSpec];
    }
    else {
        self.selectButton.hidden = YES;
        contentSpec.children = @[self.imageNode,infoSpec];
    }
    contentSpec.spacing = 8.0;
    contentSpec.alignItems = ASStackLayoutAlignItemsCenter;
    ASInsetLayoutSpec *insetSpec = [ASInsetLayoutSpec insetLayoutSpecWithInsets:UIEdgeInsetsMake(10.0, 15.0, 10.0, 15.0) child:contentSpec];
    return insetSpec;
}

@end
