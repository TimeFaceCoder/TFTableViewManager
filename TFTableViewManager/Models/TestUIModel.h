//
//  TestUIModel.h
//  TFTableViewManagerDemo
//
//  Created by Summer on 16/9/5.
//  Copyright © 2016年 Summer. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TestUIModel : NSObject

@property (nonatomic,strong) NSString *userPhoto;///<用户头像

@property (nonatomic,strong) NSString *userName;///<用户名称

@property (nonatomic,strong) NSString *userPhone;///<用户电话

@property (nonatomic,assign) BOOL selected;///<是否选中
@property (nonatomic,assign) BOOL editing;//<是否可选
@end
