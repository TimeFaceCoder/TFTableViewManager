//
//  DemoCollectionItem.m
//  TFTableViewManager
//
//  Created by Melvin on 2018/11/29.
//  Copyright © 2018 TFAppleWork-Summer. All rights reserved.
//

#import "DemoCollectionItem.h"

@implementation DemoCollectionItem

+ (DemoCollectionItem *)itemWithImageName:(NSString *)imageName {
    DemoCollectionItem *item = [[DemoCollectionItem alloc] init];
    item.imageName = imageName;
    return item;
}

@end
