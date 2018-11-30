//
//  DemoCollectionItemCellNode.m
//  TFTableViewManager
//
//  Created by Melvin on 2018/11/29.
//  Copyright © 2018 TFAppleWork-Summer. All rights reserved.
//

#import "DemoCollectionItemCellNode.h"

@implementation DemoCollectionItemCellNode {
    ASImageNode *_imageNode;
    CGSize _imageSize;
}
@dynamic tableViewItem;

- (void)cellLoadSubNodes {
    [super cellLoadSubNodes];
    
    _imageNode = [[ASImageNode alloc] init];
    _imageNode.image = [UIImage imageNamed:self.tableViewItem.imageName];
    _imageSize = _imageNode.image.size;
    [self addSubnode:_imageNode];

}

- (ASLayoutSpec *)layoutSpecThatFits:(ASSizeRange)constrainedSize
{
    
    return [ASInsetLayoutSpec insetLayoutSpecWithInsets:UIEdgeInsetsZero
                                                  child:[ASRatioLayoutSpec ratioLayoutSpecWithRatio:_imageSize.height/_imageSize.width
                                                                                              child:_imageNode]];
}
@end
