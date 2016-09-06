//
//  TestASTableVIewManagerViewController.m
//  PFTableViewManagerDemo
//
//  Created by Summer on 16/9/5.
//  Copyright © 2016年 Summer. All rights reserved.
//

#import "TestASTableVIewManagerViewController.h"
#import "TFASTableViewManager.h"
#import "TFASTableViewItemCell.h"
#import "TestASItemCell.h"

@interface TestASTableVIewManagerViewController ()

@property (nonatomic, strong) ASTableNode *tableNode;

@property (nonatomic, strong) TFASTableViewManager *manager;

@end

@implementation TestASTableVIewManagerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubnode:self.tableNode];
    self.manager = [[TFASTableViewManager alloc] initWithTableNode:self.tableNode];
    self.manager[@"TestUIItem"] = @"TestASItemCell";
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
            TestUIModel *model = [[TestUIModel alloc] init];
            model.userName = [NSString stringWithFormat:@"王田%@%ld",sectionTitle,(long)i-1];
            model.userPhoto = [NSString stringWithFormat:@"userpic%ld.jpg",(long)i];
            model.userPhone = [NSString stringWithFormat:@"15665414141"];
            model.selected = NO;
            TestUIItem *item = [TestUIItem itemWithModel:model selectionHandler:^(TestUIItem *item, NSIndexPath *indexPath) {
                //处理cell点击动作
                [weakVC dealCellSelectionActionWithItem:item];
            }];
            item.editingStyle = UITableViewCellEditingStyleDelete;
            item.deletionHandler = ^(TestUIItem *item,NSIndexPath *indexPath) {
                [item deleteRowWithAnimation:UITableViewRowAnimationAutomatic];
            };
            item.titleForDelete = @"取消";
            
            [section addItem:item];
        }
        
        [self.manager addSection:section];
    }

    // Do any additional setup after loading the view.
}

#pragma mark 处理cell点击动作
- (void)dealCellSelectionActionWithItem:(TestUIItem *)item {
    NSLog(@"%@",item.model.userName);
    item.model.selected = !item.model.selected;
    [item reloadRowWithAnimation:UITableViewRowAnimationNone];
}


#pragma mark - lazy init

- (ASTableNode *)tableNode {
    if (!_tableNode) {
        CGSize screenSize = [UIScreen mainScreen].bounds.size;
        _tableNode = [[ASTableNode alloc] initWithStyle:UITableViewStylePlain];
        _tableNode.frame = CGRectMake(0, 0, screenSize.width, screenSize.height);
    }
    return _tableNode;
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
