//
//  TestUITableVIewManagerViewController.m
//  TFTableViewManagerDemo
//
//  Created by Summer on 16/9/5.
//  Copyright © 2016年 Summer. All rights reserved.
//

#import "TestUITableVIewManagerViewController.h"
#import "TFTableViewManager.h"
#import "TestItemCell.h"
#import "TestItem.h"

@interface TestUITableVIewManagerViewController ()<TFTableViewManagerDelegate>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) TFTableViewManager *manager;


@end

@implementation TestUITableVIewManagerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.tableView];
    self.manager = [[TFTableViewManager alloc]initWithTableView:self.tableView];
    self.manager[@"TestItem"] = @"TestItemCell";
    NSArray *sectionTitles = @[@"A", @"B", @"C", @"D", @"E", @"F", @"G", @"H", @"I", @"J", @"K", @"L", @"M",
                               @"N", @"O", @"P", @"Q", @"R", @"S", @"T", @"U", @"V", @"W", @"X", @"Y", @"Z"];
    
    typeof(self) __weak weakVC = self;
    for (NSString *sectionTitle in sectionTitles) {
        TFTableViewSection *section = [TFTableViewSection sectionWithHeaderTitle:sectionTitle];
        section.headerHeight = 25.0;
        section.indexTitle = sectionTitle; // assign index title
        // Add 5 items with name `section title + item index`
        //
        for (NSInteger i = 1; i <= 5; i++)
        {
            TestModel *model = [[TestModel alloc] init];
            model.userName = [NSString stringWithFormat:@"王田%@%ld",sectionTitle,(long)i-1];
            model.userPhoto = [NSString stringWithFormat:@"userpic%ld.jpg",(long)i];
            model.userPhone = [NSString stringWithFormat:@"15665414141"];
            model.selected = NO;
            TestItem *item = [TestItem itemWithModel:model selectionHandler:^(TestItem *item, NSIndexPath *indexPath) {
                //处理cell点击动作
                [weakVC dealCellSelectionActionWithItem:item];
            }];
            item.editingStyle = UITableViewCellEditingStyleDelete;
            item.titleForDelete = @"取消";
            item.deletionHandler = ^(TestItem *item, NSIndexPath *indexPath) {
                [item deleteRowWithAnimation:UITableViewRowAnimationAutomatic];
                
            };

            [section addItem:item];
        }
        
        [self.manager addSection:section];
    }

    // Do any additional setup after loading the view.
}

#pragma mark 处理cell点击动作
- (void)dealCellSelectionActionWithItem:(TestItem *)item {
    NSLog(@"%@",item.model.userName);
    item.model.selected = !item.model.selected;
    [item reloadRowWithAnimation:UITableViewRowAnimationNone];
}

- (UITableView *)tableView {
    if (!_tableView) {
        CGSize screenSize = [UIScreen mainScreen].bounds.size;
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, screenSize.width, screenSize.height) style:UITableViewStyleGrouped];
        _tableView.rowHeight = UITableViewAutomaticDimension;
        _tableView.estimatedRowHeight = 44.0;
        _tableView.tableFooterView = [UIView new];
    }
    return _tableView;
}

- (void)dealloc {
    NSLog(@"dealloc:%@",NSStringFromClass([self class]));
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
