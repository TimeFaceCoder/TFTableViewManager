//
//  ViewController.m
//  TFTableViewManager
//
//  Created by Summer on 16/9/6.
//  Copyright © 2016年 Summer. All rights reserved.
//

#import "ViewController.h"
#import "TFTableViewManager.h"
#import "TFDefaultTableViewItem.h"
#import "TFDefaultTableViewItemCell.h"
#import "TestUITableVIewManagerViewController.h"
#import "TestASTableVIewManagerViewController.h"
#import "TestASDefaultItemViewController.h"
#import "TestUIDefaultViewController.h"
#import "ToDoListViewController.h"
#import "NameViewController.h"
#import "ContactsViewController.h"
@interface ViewController ()

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) TFTableViewManager *manager;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.tableView];
    
    self.manager = [[TFTableViewManager alloc] initWithTableView:self.tableView];
    
    self.manager[@"TFDefaultTableViewItem"] = @"TFDefaultTableViewItemCell";
    NSArray *contentArr = @[@"TFUITableViewManager",@"TFASTableViewManager",@"ASDefaultItem",@"UIDefaultItem",@"ToDoList", @"NIB",@"ContactsViewController"];
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
    else if (indexPath.row==4) {
        ToDoListViewController *nextVC = [[ToDoListViewController alloc] init];
        nextVC.title =@"ToDoList";
        [self.navigationController pushViewController:nextVC animated:YES];
    }
    else if (indexPath.row == 5){
        NameViewController* vc = [[NameViewController alloc]init];
        vc.title = @"nib";
        [self.navigationController pushViewController:vc animated:YES];
    }
    else if (indexPath.row == 6) {
        ContactsViewController* vc = [[ContactsViewController alloc]init];
        vc.title = @"ContactsViewController";
        [self.navigationController pushViewController:vc animated:YES];
    }
}

- (UITableView *)tableView {
    if (!_tableView) {
        CGSize screenSize = [UIScreen mainScreen].bounds.size;
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, screenSize.width, screenSize.height) style:UITableViewStylePlain];
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
