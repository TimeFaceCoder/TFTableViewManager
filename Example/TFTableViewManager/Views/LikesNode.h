//
//  LikesNode.h
//  TableNodeDataManager_Example
//
//  Created by Melvin on 2018/8/8.
//  Copyright © 2018 melvin7. All rights reserved.
//

#import <AsyncDisplayKit/AsyncDisplayKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface LikesNode : ASControlNode {
    ASImageNode *_iconNode;
    ASTextNode *_countNode;
    
    NSInteger _likesCount;
    BOOL _liked;
}


- (instancetype)initWithLikesCount:(NSInteger)likesCount;

+ (BOOL) getYesOrNo;

@end

NS_ASSUME_NONNULL_END
