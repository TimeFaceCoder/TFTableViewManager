//
//  CommentsNode.m
//  TableNodeDataManager_Example
//
//  Created by Melvin on 2018/8/8.
//  Copyright © 2018 melvin7. All rights reserved.
//

#import "CommentsNode.h"
#import "TextStyle.h"


@implementation CommentsNode
- (instancetype)initWithCommentsCount:(NSInteger)comentsCount {
    
    self = [super init];
    
    if(self) {
        
        _comentsCount = comentsCount;
        
        _iconNode = [[ASImageNode alloc] init];
        _iconNode.image = [UIImage imageNamed:@"TimeLineComment.png"];
        [self addSubnode:_iconNode];
        
        _countNode = [[ASTextNode alloc] init];
        if(_comentsCount > 0) {
            
            _countNode.attributedText = [[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"%ld", (long)_comentsCount] attributes:[TextStyle cellControlStyle]];
            
        }
        
        [self addSubnode:_countNode];
        
        // make it tappable easily
        self.hitTestSlop = UIEdgeInsetsMake(-10, -10, -10, -10);
    }
    return self;
    
}

- (ASLayoutSpec *)layoutSpecThatFits:(ASSizeRange)constrainedSize {
    
    ASStackLayoutSpec *mainStack =  [ASStackLayoutSpec stackLayoutSpecWithDirection:ASStackLayoutDirectionHorizontal spacing:6.0 justifyContent:ASStackLayoutJustifyContentStart alignItems:ASStackLayoutAlignItemsCenter children:@[_iconNode, _countNode]];
    
    // set sizeRange to make width fixed to 60
    
    return [ASInsetLayoutSpec insetLayoutSpecWithInsets:UIEdgeInsetsMake(0, 10, 0, 10) child:mainStack];
    
    
}
@end
