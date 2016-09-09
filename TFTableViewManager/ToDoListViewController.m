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
    self.edgesForExtendedLayout = UIRectEdgeNone;
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    

    [self.view addSubnode:self.headerNode];
    [self.view addSubnode:self.footerNode];
    
    [self.view addSubnode:self.tableNode];
    self.manager = [[TFTableViewManager alloc] initWithTableNode:self.tableNode];
    
    self.manager[@"TestUIItem"] = @"TodoItemCellNode";
    
    
    
    for (NSInteger i = 1; i <= 15; i++)
    {
        TFTableViewSection *section = [TFTableViewSection section];
        TestUIModel *model = [[TestUIModel alloc] init];
        model.userName = [NSString stringWithFormat:@"王田%ld",(long)i-1];
        model.userPhoto = [NSString stringWithFormat:@"userpic%ld.jpg",(long)i];
        model.userPhone = [NSString stringWithFormat:@"15665414141"];
        model.selected = NO;
        
        TestUIItem *item = [TestUIItem itemWithModel:model selectionHandler:^(TestUIItem *item, NSIndexPath *indexPath) {
            if (item.model.editing) {
                item.model.selected = !item.model.selected;
                [item reloadRowWithAnimation:UITableViewRowAnimationFade];
            }
        }];
        item.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        [section addItem:item];
        [self.manager addSection:section];
        section.headerHeight = 8.0f;
        section.footerHeight = 8.0f;
    }
    
    
}

- (void)todoHeaderNode:(TodoHeaderNode *)node didClickButtonIndex:(NSInteger)index {
    if (index == 0) {
        NSMutableArray* sections = [NSMutableArray arrayWithCapacity:15];
        for (NSInteger i = 1; i <= 15; i++)
        {
            TFTableViewSection *section = [TFTableViewSection section];
            TestUIModel *model = [[TestUIModel alloc] init];
            model.userName = [NSString stringWithFormat:@"王田%ld",(long)i-1];
            model.userPhoto = [NSString stringWithFormat:@"userpic%ld.jpg",(long)i];
            model.userPhone = [NSString stringWithFormat:@"15665414141"];
            model.selected = NO;
            
            TestUIItem *item = [TestUIItem itemWithModel:model selectionHandler:^(TestUIItem *item, NSIndexPath *indexPath) {
                if (item.model.editing) {
                    item.model.selected = !item.model.selected;
                    [item reloadRowWithAnimation:UITableViewRowAnimationFade];
                }
            }];
            item.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            [section addItem:item];
            section.headerHeight = 8.0f;
            section.footerHeight = 8.0f;
            [sections addObject:section];
        }
        [self.manager addSections:sections withRowAnimation:UITableViewRowAnimationTop];
    }
    else {
        if (node.editing) {
            for (TFTableViewSection* section in self.manager.sections) {
                TestUIItem* item = (TestUIItem*)section.items.firstObject;
                item.model.selected = YES;
            }
            [self.manager reloadAllSectionsWithRowAnimation:UITableViewRowAnimationFade];
        }
        else {
            for (TFTableViewSection* section in self.manager.sections) {
                TestUIItem* item = (TestUIItem*)section.items.firstObject;
                item.model.editing = YES;
            }
            [self.manager reloadAllSectionsWithRowAnimation:UITableViewRowAnimationFade];
            
            
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
        for (TFTableViewSection* section in self.manager.sections) {
            TestUIItem* item = (TestUIItem*)section.items.firstObject;
            item.model.editing = NO;
        }
        self.headerNode.editing = NO;
        [self.headerNode setNeedsLayout];
        [self.manager reloadAllSectionsWithRowAnimation:UITableViewRowAnimationFade];
//        [self.manager.sections.firstObject reloadSectionWithAnimation:UITableViewRowAnimationFade];
    }
    else {
        NSMutableArray* itemsToDelete = [NSMutableArray array];
        for (TFTableViewSection* section in self.manager.sections) {
            TestUIItem* item = (TestUIItem*)section.items.firstObject;
            if (item.model.selected) {
                [itemsToDelete addObject:section];
            }
        }
        
        if (itemsToDelete.count > 0) {

            self.headerNode.editing = NO;
            [self.headerNode setNeedsLayout];
            [self.tableNode measureWithSizeRange:ASSizeRangeMakeExactSize(CGSizeMake(CGRectGetWidth(self.tableNode.frame), CGRectGetHeight(self.view.bounds) - CGRectGetHeight(self.headerNode.frame)))];
            [UIView animateWithDuration:0.3f animations:^{
                self.footerNode.frame = CGRectMake(0, CGRectGetHeight(self.view.bounds), CGRectGetWidth(self.footerNode.frame), CGRectGetHeight(self.footerNode.frame));
                self.tableNode.frame = CGRectMake(0, CGRectGetHeight(self.headerNode.frame), CGRectGetWidth(self.tableNode.frame), CGRectGetHeight(self.view.bounds) - CGRectGetHeight(self.headerNode.frame));
            } completion:^(BOOL finished) {
//                [self.manager.sections.firstObject deleteRows:itemsToDelete withAnimation:UITableViewRowAnimationFade];
                [self.manager deleteSections:itemsToDelete withRowAnimation:UITableViewRowAnimationFade];
                
                for (TFTableViewSection* section in self.manager.sections) {
                    TestUIItem* item = (TestUIItem*)section.items.firstObject;
                    item.model.editing = NO;
                }
                [self.manager reloadAllSectionsWithRowAnimation:UITableViewRowAnimationFade];
//                [self.manager.sections.firstObject reloadSectionWithAnimation:UITableViewRowAnimationFade];
            }];
        }
    }
}
-(void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    if (self.headerNode.editing) {
        [self.tableNode measureWithSizeRange:ASSizeRangeMakeExactSize(CGSizeMake(CGRectGetWidth(self.tableNode.frame), CGRectGetHeight(self.view.bounds) - CGRectGetHeight(self.footerNode.frame) - CGRectGetHeight(self.headerNode.frame)))];
        self.tableNode.frame = CGRectMake(0, CGRectGetHeight(self.headerNode.frame), CGRectGetWidth(self.tableNode.frame), CGRectGetHeight(self.view.bounds) - CGRectGetHeight(self.footerNode.frame)- CGRectGetHeight(self.headerNode.frame));
    }
    else {
        [_tableNode measureWithSizeRange:ASSizeRangeMakeExactSize(CGSizeMake(CGRectGetWidth(self.tableNode.frame), CGRectGetHeight(self.view.bounds) - CGRectGetHeight(self.headerNode.frame)))];
        _tableNode.frame = CGRectMake(0, CGRectGetHeight(self.headerNode.frame), CGRectGetWidth(self.view.bounds), CGRectGetHeight(self.view.bounds) - CGRectGetHeight(self.headerNode.frame));
    }
}
- (ASTableNode *)tableNode {
    if (!_tableNode) {
        CGSize screenSize = [UIScreen mainScreen].bounds.size;
        _tableNode = [[ASTableNode alloc] initWithStyle:UITableViewStyleGrouped];
        [_tableNode measureWithSizeRange:ASSizeRangeMakeExactSize(CGSizeMake(CGRectGetWidth(self.tableNode.frame), CGRectGetHeight(self.view.bounds) - CGRectGetHeight(self.headerNode.frame)))];
        _tableNode.frame = CGRectMake(0, CGRectGetHeight(self.headerNode.frame), screenSize.width, CGRectGetHeight(self.view.bounds) - CGRectGetHeight(self.headerNode.frame));
    }
    return _tableNode;
}
@end
