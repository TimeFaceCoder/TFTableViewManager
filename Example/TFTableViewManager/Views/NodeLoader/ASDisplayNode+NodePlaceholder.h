//
//  ASDisplayNode+NodePlaceholder.h
//  TFTableViewManager
//
//  Created by Melvin on 2018/8/17.
//  Copyright © 2018 TFAppleWork-Summer. All rights reserved.
//

#import <AsyncDisplayKit/AsyncDisplayKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ASDisplayNode (NodePlaceholder)

- (void)showLoader;

- (void)hideLoader;

@end

NS_ASSUME_NONNULL_END
