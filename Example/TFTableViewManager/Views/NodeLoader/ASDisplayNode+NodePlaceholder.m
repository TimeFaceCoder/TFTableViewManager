//
//  ASDisplayNode+NodePlaceholder.m
//  TFTableViewManager
//
//  Created by Melvin on 2018/8/17.
//  Copyright © 2018 TFAppleWork-Summer. All rights reserved.
//

#import "ASDisplayNode+NodePlaceholder.h"


@implementation ASDisplayNode (NodePlaceholder)

- (void)showLoader {
    if (self.userInteractionEnabled) {
        self.userInteractionEnabled = NO;
    }
    if ([self isKindOfClass:[ASTableNode class]]) {
        //tablenode
    }
    if ([self isKindOfClass:[ASCollectionNode class]]) {
        //collectionnode
    }
}

- (void)hideLoader {
    self.userInteractionEnabled = YES;
}

@end
