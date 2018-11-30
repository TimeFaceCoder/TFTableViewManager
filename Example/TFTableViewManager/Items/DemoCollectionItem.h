//
//  DemoCollectionItem.h
//  TFTableViewManager
//
//  Created by Melvin on 2018/11/29.
//  Copyright © 2018 TFAppleWork-Summer. All rights reserved.
//

#import "TFTableViewItem.h"

NS_ASSUME_NONNULL_BEGIN

@interface DemoCollectionItem : TFTableViewItem

@property (nonatomic ,strong) NSString *imageName;

+ (DemoCollectionItem *)itemWithImageName:(NSString *)imageName;


@end

NS_ASSUME_NONNULL_END
