//
//  ToDoListViewController.m
//  TFTableViewManager
//
//  Created by zguanyu on 16/9/9.
//  Copyright © 2016年 Summer. All rights reserved.
//

#import "ToDoListViewController.h"
#import "TodoHeaderNode.h"
#import "TFTableViewManager.h"
@interface ToDoListViewController ()
@property (nonatomic, strong)TodoHeaderNode* headerNode;
@property (nonatomic, strong) ASTableNode *tableNode;

@property (nonatomic, strong) TFTableViewManager *manager;
@end

@implementation ToDoListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view addSubnode:self.tableNode];
    self.manager = [[TFTableViewManager alloc] initWithTableNode:self.tableNode];
}

- (ASTableNode *)tableNode {
    if (!_tableNode) {
        CGSize screenSize = [UIScreen mainScreen].bounds.size;
        _tableNode = [[ASTableNode alloc] initWithStyle:UITableViewStylePlain];
        _tableNode.frame = CGRectMake(0, 0, screenSize.width, screenSize.height);
    }
    return _tableNode;
}
@end
