//
//  ViewController.m
//  TFTableViewManager
//
//  Created by TFAppleWork-Summer on 2017/9/26.
//  Copyright © 2017年 TFAppleWork-Summer. All rights reserved.
//

#import "TMRootViewController.h"
#import <TFTableViewManager/TFTableViewManager.h>
#import <TFTableViewManager/TFDefaultTableViewItem.h>
//vc
#import "TestUIDefaultViewController.h"
#import "TestASDefaultItemViewController.h"
#import "TestUITableVIewManagerViewController.h"
#import "TestASTableVIewManagerViewController.h"
#import "TestTimelineViewController.h"

@interface TMRootViewController ()

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) TFTableViewManager *manager;

@end

@implementation TMRootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.title = @"TFTableViewManager";
    [self.view addSubview:self.tableView];
    self.manager = [[TFTableViewManager alloc] initWithTableView:self.tableView];
    
    NSArray *contentArr = @[@"TFUITableViewManager",@"TFASTableViewManager",@"ASDefaultItem",@"UIDefaultItem",@"TimeLineItem"];
    TFTableViewSection *section = [TFTableViewSection section];
    typeof(self) __weak weakVC = self;
    for (NSString *content in contentArr) {
        TFDefaultTableViewItem *item = [TFDefaultTableViewItem item];
        item.text = content;
        item.cellStyle = UITableViewCellStyleValue1;
        item.selectionStyle = UITableViewCellSelectionStyleDefault;
        item.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        item.cellHeight = 44.0;
        item.selectionHandler = ^(TFDefaultTableViewItem *item, NSIndexPath *indexPath){
            [weakVC dealCellSelectionActionWithItem:item indexPath:indexPath];
            
        };
        [section addItem:item];
    }
    [self.manager addSection:section];
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    self.tableView.frame = self.view.bounds;
}

- (void)dealCellSelectionActionWithItem:(TFDefaultTableViewItem *)item indexPath:(NSIndexPath *)indexPath {
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
    else if (indexPath.row==2) {
        TestASDefaultItemViewController *nextVC = [[TestASDefaultItemViewController alloc] init];
        nextVC.title = @"TestASDefault";
        [self.navigationController pushViewController:nextVC animated:YES];
    }
    else if (indexPath.row==3) {
        TestUIDefaultViewController *nextVC = [[TestUIDefaultViewController alloc] init];
        nextVC.title =@"TestUIDefault";
        [self.navigationController pushViewController:nextVC animated:YES];
    }
    else if(indexPath.row == 4) {
        //timeline demo
        TestTimelineViewController *nextVC = [[TestTimelineViewController alloc] init];
        nextVC.title = @"TimeLine";
        [self.navigationController pushViewController:nextVC animated:YES];
    }
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _tableView.tableFooterView = [UIView new];
        _tableView.separatorColor = [UIColor cyanColor];
    }
    return _tableView;
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
