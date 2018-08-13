//
//  TextStyle.h
//  TableNodeDataManager_Example
//
//  Created by Melvin on 2018/8/8.
//  Copyright © 2018 melvin7. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface TextStyle : NSObject

+ (NSDictionary *)nameStyle;
+ (NSDictionary *)usernameStyle;
+ (NSDictionary *)timeStyle;
+ (NSDictionary *)postStyle;
+ (NSDictionary *)titleStyle;
+ (NSDictionary *)postLinkStyle;
+ (NSDictionary *)cellControlStyle;
+ (NSDictionary *)cellControlColoredStyle;

@end

NS_ASSUME_NONNULL_END
