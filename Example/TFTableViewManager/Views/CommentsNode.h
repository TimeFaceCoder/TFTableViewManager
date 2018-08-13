//
//  CommentsNode.h
//  TableNodeDataManager_Example
//
//  Created by Melvin on 2018/8/8.
//  Copyright © 2018 melvin7. All rights reserved.
//

#import <AsyncDisplayKit/AsyncDisplayKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CommentsNode : ASControlNode {
    ASImageNode *_iconNode;
    ASTextNode *_countNode;
    
    NSInteger _comentsCount;
}
- (instancetype)initWithCommentsCount:(NSInteger)comentsCount;

@end

NS_ASSUME_NONNULL_END
