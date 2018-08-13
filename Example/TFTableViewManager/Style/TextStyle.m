//
//  TextStyle.m
//  TableNodeDataManager_Example
//
//  Created by Melvin on 2018/8/8.
//  Copyright © 2018 melvin7. All rights reserved.
//

#import "TextStyle.h"

@implementation TextStyle

+ (NSDictionary *)nameStyle
{
    return @{
             NSFontAttributeName : [UIFont boldSystemFontOfSize:15.0],
             NSForegroundColorAttributeName: [UIColor blackColor]
             };
}

+ (NSDictionary *)usernameStyle
{
    return @{
             NSFontAttributeName : [UIFont systemFontOfSize:13.0],
             NSForegroundColorAttributeName: [UIColor lightGrayColor]
             };
}

+ (NSDictionary *)timeStyle
{
    return @{
             NSFontAttributeName : [UIFont systemFontOfSize:13.0],
             NSForegroundColorAttributeName: [UIColor grayColor]
             };
}

+ (NSDictionary *)postStyle
{
    return @{
             NSFontAttributeName : [UIFont systemFontOfSize:15.0],
             NSForegroundColorAttributeName: [UIColor blackColor]
             };
}

+ (NSDictionary *)titleStyle
{
    return @{
             NSFontAttributeName : [UIFont boldSystemFontOfSize:16],
             NSForegroundColorAttributeName: [UIColor blackColor]
             };
}

+ (NSDictionary *)postLinkStyle
{
    return @{
             NSFontAttributeName : [UIFont systemFontOfSize:15.0],
             NSForegroundColorAttributeName: [UIColor colorWithRed:59.0/255.0 green:89.0/255.0 blue:152.0/255.0 alpha:1.0],
             NSUnderlineStyleAttributeName: @(NSUnderlineStyleSingle)
             };
}

+ (NSDictionary *)cellControlStyle {
    
    return @{
             NSFontAttributeName : [UIFont systemFontOfSize:13.0],
             NSForegroundColorAttributeName: [UIColor lightGrayColor]
             };
}

+ (NSDictionary *)cellControlColoredStyle {
    
    return @{
             NSFontAttributeName : [UIFont systemFontOfSize:13.0],
             NSForegroundColorAttributeName: [UIColor colorWithRed:59.0/255.0 green:89.0/255.0 blue:152.0/255.0 alpha:1.0]
             };
}

@end
