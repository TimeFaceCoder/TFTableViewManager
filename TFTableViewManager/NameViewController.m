//
//  NameViewController.m
//  TFTableViewManager
//
//  Created by zguanyu on 16/9/13.
//  Copyright © 2016年 Summer. All rights reserved.
//

#import "NameViewController.h"
#import "TFTableViewManager.h"
#import "TFTableViewSection.h"
#import "NameItem.h"
#import "NameModel.h"
@interface NameViewController ()
@property (nonatomic, strong) TFTableViewManager *manager;
@property (nonatomic, strong)UITableView* tableView;
@end

@implementation NameViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.manager = [[TFTableViewManager alloc] initWithTableView:self.tableView];
    [self.view addSubview:self.tableView];
//    self.tableView register
    
    TFTableViewSection * section = [TFTableViewSection section];
    for (int i = 0; i < 10; i++) {
        NameItem* item = [[NameItem alloc]init];
        NameModel* model = [[NameModel alloc]init];
        item.model = model;
        [section addItem:item];
    }
    
    [self.manager addSection:section];
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _tableView.estimatedRowHeight = 10.0;
    }
    return _tableView;
}



@end
