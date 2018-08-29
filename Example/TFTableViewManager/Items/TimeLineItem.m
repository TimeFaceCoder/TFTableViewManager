//
//  TimeLineItem.m
//  TableNodeDataManager_Example
//
//  Created by Melvin on 2018/8/8.
//  Copyright © 2018 melvin7. All rights reserved.
//

#import "TimeLineItem.h"

@implementation TimeLineItem

+ (TimeLineItem *)itemWithModel:(NSDictionary *)data {
    TimeLineItem *item = [[TimeLineItem alloc] init];
    item.data = data;
    item.selectionStyle = UITableViewCellSelectionStyleNone;
    return item;
}


+ (TimeLineItem *)itemWithMock {
    TimeLineItem *item = [[TimeLineItem alloc] init];
    item.data = @{};
    item.selectionStyle = UITableViewCellSelectionStyleNone;
    return item;

}

@end
