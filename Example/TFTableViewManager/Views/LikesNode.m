//
//  LikesNode.m
//  TableNodeDataManager_Example
//
//  Created by Melvin on 2018/8/8.
//  Copyright © 2018 melvin7. All rights reserved.
//

#import "LikesNode.h"
#import "TextStyle.h"

@implementation LikesNode

- (instancetype)initWithLikesCount:(NSInteger)likesCount {
    
    self = [super init];
    
    if(self) {
        
        _likesCount = likesCount;
        _liked = (_likesCount > 0) ? [LikesNode getYesOrNo] : NO;
        
        _iconNode = [[ASImageNode alloc] init];
        _iconNode.image = (_liked) ? [UIImage imageNamed:@"TimeLineLikeSelected.png"] : [UIImage imageNamed:@"TimeLineLike.png"];
        [self addSubnode:_iconNode];
        
        
        _countNode = [[ASTextNode alloc] init];
        if(_likesCount > 0) {
            if(_liked) {
                _countNode.attributedText = [[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"%ld", (long)_likesCount] attributes:[TextStyle cellControlColoredStyle]];
            }else {
                _countNode.attributedText = [[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"%ld", (long)_likesCount] attributes:[TextStyle cellControlStyle]];
            }
            
        }
        
        [self addSubnode:_countNode];
        
        // make it tappable easily
        self.hitTestSlop = UIEdgeInsetsMake(-10, -10, -10, -10);
    }
    
    return self;
    
}

+ (BOOL) getYesOrNo
{
    int tmp = (arc4random() % 30)+1;
    if(tmp % 5 == 0)
        return YES;
    return NO;
}

- (ASLayoutSpec *)layoutSpecThatFits:(ASSizeRange)constrainedSize {
    
    ASStackLayoutSpec *mainStack = [ASStackLayoutSpec stackLayoutSpecWithDirection:ASStackLayoutDirectionHorizontal spacing:6.0 justifyContent:ASStackLayoutJustifyContentStart alignItems:ASStackLayoutAlignItemsCenter children:@[_iconNode, _countNode]];
    
    // set sizeRange to make width fixed to 60
    
    return [ASInsetLayoutSpec insetLayoutSpecWithInsets:UIEdgeInsetsMake(0, 10, 0, 10) child:mainStack];
    
    
}


@end
