//
//  ViewController.m
//  TFTableViewManager
//
//  Created by Summer on 16/9/6.
//  Copyright © 2016年 Summer. All rights reserved.
//

#import "ViewController.h"
#import "TFUITableViewManager.h"
#import "TFUIBaseTableViewItem.h"
#import "TFUIBaseTableViewItemCell.h"
#import "TestUITableVIewManagerViewController.h"
#import "TestASTableVIewManagerViewController.h"

@interface ViewController ()

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) TFUITableViewManager *manager;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.tableView];
    
    self.manager = [[TFUITableViewManager alloc] initWithTableView:self.tableView];
    
    self.manager[@"TFUIBaseTableViewItem"] = @"TFUIBaseTableViewItemCell";
    NSArray *contentArr = @[@"TFUITableViewManager",@"TFASTableViewManager"];
    TFTableViewSection *section = [TFTableViewSection section];
    typeof(self) __weak weakVC = self;
    for (NSString *content in contentArr) {
        TFUIBaseTableViewItem *item = [TFUIBaseTableViewItem item];
        item.text = content;
        item.selectionStyle = UITableViewCellSelectionStyleDefault;
        item.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        item.cellHeight = 60.0;
        
        item.selectionHandler = ^(TFUIBaseTableViewItem *item, NSIndexPath *indexPath){
            [weakVC dealCellSelectionActionWithItem:item indexPath:indexPath];
            
        };
        [section addItem:item];
    }
    [self.manager addSection:section];
    
}

- (void)dealCellSelectionActionWithItem:(TFUIBaseTableViewItem *)item indexPath:(NSIndexPath *)indexPath {
    if (indexPath.row==0) {
        TestUITableVIewManagerViewController *nextVC = [[TestUITableVIewManagerViewController alloc] init];
        nextVC.title = @"TestUI";
        [self.navigationController pushViewController:nextVC animated:YES];
    }
    
    else if (indexPath.row==1) {
        TestASTableVIewManagerViewController *nextVC = [[TestASTableVIewManagerViewController alloc] init];
        nextVC.title = @"TestAS";
        [self.navigationController pushViewController:nextVC animated:YES];
    }
}

- (UITableView *)tableView {
    if (!_tableView) {
        CGSize screenSize = [UIScreen mainScreen].bounds.size;
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, screenSize.width, screenSize.height) style:UITableViewStylePlain];
        _tableView.tableFooterView = [UIView new];
    }
    return _tableView;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
