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
#import "TestUIModel.h"
#import "TestUIItem.h"
#import "TodoFooterNode.h"
@interface ToDoListViewController ()<TodoHeaderNodeDelegate, TodoFooterNodeeDelegate>
@property (nonatomic, strong)TodoHeaderNode* headerNode;
@property (nonatomic, strong) ASTableNode *tableNode;
@property (nonatomic, strong) TFTableViewManager *manager;
@property (nonatomic, strong)TodoFooterNode* footerNode;
@end

@implementation ToDoListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.edgesForExtendedLayout = UIRectEdgeNone;

    [self.view addSubnode:self.headerNode];
    [self.view addSubnode:self.footerNode];
    
    [self.view addSubnode:self.tableNode];
    self.manager = [[TFTableViewManager alloc] initWithTableNode:self.tableNode];
    
    self.manager[@"TestUIItem"] = @"TodoItemCell";
    
    TFTableViewSection *section = [TFTableViewSection section];
    
    for (NSInteger i = 1; i <= 15; i++)
    {
        TestUIModel *model = [[TestUIModel alloc] init];
        model.userName = [NSString stringWithFormat:@"王田%ld",(long)i-1];
        model.userPhoto = [NSString stringWithFormat:@"userpic%ld.jpg",(long)i];
        model.userPhone = [NSString stringWithFormat:@"15665414141"];
        model.selected = NO;
        
        TestUIItem *item = [TestUIItem itemWithModel:model selectionHandler:^(TestUIItem *item, NSIndexPath *indexPath) {
            if (item.model.editing) {
                item.model.selected = !item.model.selected;
//                [self.manager.sections.firstObject reloadSectionWithAnimation:UITableViewRowAnimationNone];
                [item reloadRowWithAnimation:UITableViewRowAnimationFade];
            }
        }];
        item.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
//        item.editingStyle = UITableViewCellEditingStyleDelete;
//        item.titleForDelete = @"删除";
        [section addItem:item];
    }
    
    [self.manager addSection:section];
}

- (void)todoHeaderNode:(TodoHeaderNode *)node didClickButtonIndex:(NSInteger)index {
    if (index == 0) {
        TestUIModel *model = [[TestUIModel alloc] init];
        int i = 1;
        model.userName = [NSString stringWithFormat:@"王田%ld",(long)i-1];
        model.userPhoto = [NSString stringWithFormat:@"userpic%ld.jpg",(long)i];
        model.userPhone = [NSString stringWithFormat:@"15665414141"];
        model.selected = NO;
        
        TestUIItem *item = [TestUIItem itemWithModel:model selectionHandler:^(TestUIItem *item, NSIndexPath *indexPath) {
            //处理cell点击动作
            //                [weakVC dealCellSelectionActionWithItem:item];
            
        }];
        item.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
    }
    else {
        if (node.editing) {
            for (TestUIItem* item in self.manager.sections.firstObject.items) {
                item.model.selected = YES;
            }
            [self.manager.sections.firstObject reloadSectionWithAnimation:UITableViewRowAnimationFade];
        }
        else {
            for (TestUIItem* item in self.manager.sections.firstObject.items) {
                item.model.editing = YES;
            }
            [self.manager.sections.firstObject reloadSectionWithAnimation:UITableViewRowAnimationFade];
            
            
            [self.tableNode measureWithSizeRange:ASSizeRangeMakeExactSize(CGSizeMake(CGRectGetWidth(self.tableNode.frame), CGRectGetHeight(self.view.bounds) - CGRectGetHeight(self.footerNode.frame) - CGRectGetHeight(self.headerNode.frame)))];
            
            [UIView animateWithDuration:0.3f animations:^{
                self.footerNode.frame = CGRectMake(0, CGRectGetHeight(self.view.bounds) - CGRectGetHeight(self.footerNode.frame), CGRectGetWidth(self.footerNode.frame), CGRectGetHeight(self.footerNode.frame));
                self.tableNode.frame = CGRectMake(0, CGRectGetHeight(self.headerNode.frame), CGRectGetWidth(self.tableNode.frame), CGRectGetHeight(self.view.bounds) - CGRectGetHeight(self.footerNode.frame)- CGRectGetHeight(self.headerNode.frame));
            }];
        }
    }
}

- (TodoFooterNode *)footerNode {
    if (!_footerNode) {
        _footerNode = [[TodoFooterNode alloc]init];
        _footerNode.delegate = self;
        
        [_footerNode measureWithSizeRange:ASSizeRangeMake(CGSizeMake(CGRectGetWidth(self.view.bounds), 0), CGSizeMake(CGRectGetWidth(self.view.bounds), CGFLOAT_MAX))];
        _footerNode.frame = CGRectMake(0, CGRectGetHeight(self.view.bounds), _footerNode.calculatedSize.width, _footerNode.calculatedSize.height);
    }
    return _footerNode;
}

- (TodoHeaderNode *)headerNode {
    if (!_headerNode) {
        _headerNode = [[TodoHeaderNode alloc]init];
        _headerNode.delegate = self;
        
        [_headerNode measureWithSizeRange:ASSizeRangeMake(CGSizeMake(CGRectGetWidth(self.view.bounds), 0), CGSizeMake(CGRectGetWidth(self.view.bounds), CGFLOAT_MAX))];
        _headerNode.frame = CGRectMake(0, 0, _headerNode.calculatedSize.width, _headerNode.calculatedSize.height);
    }
    return _headerNode;
}

- (void)todoFooterNode:(TodoFooterNode *)node didClickButtonIndex:(NSInteger)index {
    if (index == 0) {
        [self.tableNode measureWithSizeRange:ASSizeRangeMakeExactSize(CGSizeMake(CGRectGetWidth(self.tableNode.frame), CGRectGetHeight(self.view.bounds) - CGRectGetHeight(self.headerNode.frame)))];
        [UIView animateWithDuration:0.3f animations:^{
            self.footerNode.frame = CGRectMake(0, CGRectGetHeight(self.view.bounds), CGRectGetWidth(self.footerNode.frame), CGRectGetHeight(self.footerNode.frame));
            self.tableNode.frame = CGRectMake(0, CGRectGetHeight(self.headerNode.frame), CGRectGetWidth(self.tableNode.frame), CGRectGetHeight(self.view.bounds) - CGRectGetHeight(self.headerNode.frame));
        }];
        for (TestUIItem* item in self.manager.sections.firstObject.items) {
            item.model.editing = NO;
        }
        self.headerNode.editing = NO;
        [self.headerNode setNeedsDisplay];
        [self.manager.sections.firstObject reloadSectionWithAnimation:UITableViewRowAnimationFade];
    }
    else {
        NSMutableArray* itemsToDelete = [NSMutableArray array];
        for (TestUIItem* item in self.manager.sections.firstObject.items) {
            if (item.model.selected) {
                [itemsToDelete addObject:item];
            }
        }
        [self.tableNode.view beginUpdates];
        if (itemsToDelete.count > 0) {
            for (TestUIItem* item in itemsToDelete) {
                [item deleteRowWithAnimation:UITableViewRowAnimationBottom];
            }
            
            for (TestUIItem* item in self.manager.sections.firstObject.items) {
                item.model.editing = NO;
            }
            self.headerNode.editing = NO;
            [self.headerNode setNeedsDisplay];
            [self.manager.sections.firstObject reloadSectionWithAnimation:UITableViewRowAnimationFade];
            
            [self.tableNode measureWithSizeRange:ASSizeRangeMakeExactSize(CGSizeMake(CGRectGetWidth(self.tableNode.frame), CGRectGetHeight(self.view.bounds) - CGRectGetHeight(self.headerNode.frame)))];
            [UIView animateWithDuration:0.3f animations:^{
                self.footerNode.frame = CGRectMake(0, CGRectGetHeight(self.view.bounds), CGRectGetWidth(self.footerNode.frame), CGRectGetHeight(self.footerNode.frame));
                self.tableNode.frame = CGRectMake(0, CGRectGetHeight(self.headerNode.frame), CGRectGetWidth(self.tableNode.frame), CGRectGetHeight(self.view.bounds) - CGRectGetHeight(self.headerNode.frame));
            }];
        }
        [self.tableNode.view endUpdates];
    }
}

- (ASTableNode *)tableNode {
    if (!_tableNode) {
        CGSize screenSize = [UIScreen mainScreen].bounds.size;
        _tableNode = [[ASTableNode alloc] initWithStyle:UITableViewStylePlain];
        [_tableNode measureWithSizeRange:ASSizeRangeMakeExactSize(CGSizeMake(CGRectGetWidth(self.tableNode.frame), CGRectGetHeight(self.view.bounds) - CGRectGetHeight(self.headerNode.frame)))];
        _tableNode.frame = CGRectMake(0, CGRectGetHeight(self.headerNode.frame), screenSize.width, CGRectGetHeight(self.view.bounds) - CGRectGetHeight(self.headerNode.frame));
    }
    return _tableNode;
}
@end
