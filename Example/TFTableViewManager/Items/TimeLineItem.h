//
//  TimeLineItem.h
//  TableNodeDataManager_Example
//
//  Created by Melvin on 2018/8/8.
//  Copyright © 2018 melvin7. All rights reserved.
//
#import "TFTableViewItem.h"


NS_ASSUME_NONNULL_BEGIN

@interface TimeLineItem : TFTableViewItem

@property (nonatomic, strong) NSDictionary  *data;

@property (nonatomic, assign) NSInteger     index;

+ (TimeLineItem *)itemWithModel:(NSDictionary *)data;

+ (TimeLineItem *)itemWithMock;

@end

NS_ASSUME_NONNULL_END
