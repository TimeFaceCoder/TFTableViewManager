//
//  TFTableViewItem.m
//  TFTableViewManagerDemo
//
//  Created by Summer on 16/8/24.
//  Copyright © 2016年 Summer. All rights reserved.
//

#import "TFTableViewItem.h"
#import "TFTableViewSection.h"
#import "TFTableViewManager.h"

@implementation TFTableViewItem

#pragma mark - TFTableViewItem Properties.

- (NSIndexPath *)indexPath {
    return [NSIndexPath indexPathForRow:[self.section.items indexOfObject:self] inSection:self.section.index];
}


#pragma mark - Creating and Initializing a TFTableViewItem.

+ (instancetype)item {
    return [[self alloc] init];
}

+ (instancetype)itemWithModel:(id)model {
    TFTableViewItem *item = [[self alloc] init];
    item.model = model;
    return item;
}

+ (instancetype)itemWithModel:(id)model selectionHandler:(void (^)(id, NSIndexPath *))selectionHandler {
    TFTableViewItem *item = [[self alloc] init];
    item.model = model;
    item.selectionHandler = selectionHandler;
    return item;
}

#pragma mark - reload and select table view item

- (void)selectRowAnimated:(BOOL)animated {
    [self selectRowAnimated:animated scrollPosition:UITableViewScrollPositionNone];
}

- (void)selectRowAnimated:(BOOL)animated scrollPosition:(UITableViewScrollPosition)scrollPosition {
    if (self.section.tableViewManager.tableView) {
        [self.section.tableViewManager.tableView selectRowAtIndexPath:self.indexPath animated:animated scrollPosition:scrollPosition];
    }
    else if (self.section.tableViewManager.tableNode) {
        [self.section.tableViewManager.tableNode.view selectRowAtIndexPath:self.indexPath animated:animated scrollPosition:scrollPosition];
    }
}

- (void)deselectRowAnimated:(BOOL)animated
{
    if (self.section.tableViewManager.tableView) {
        [self.section.tableViewManager.tableView deselectRowAtIndexPath:self.indexPath animated:animated];
    }
    else if (self.section.tableViewManager.tableNode) {
        [self.section.tableViewManager.tableNode.view deselectRowAtIndexPath:self.indexPath animated:animated];
    }
}

- (void)reloadRowWithAnimation:(UITableViewRowAnimation)animation
{
    if (self.section.tableViewManager.tableView) {
        [self.section.tableViewManager.tableView reloadRowsAtIndexPaths:@[self.indexPath] withRowAnimation:animation];
    }
    else if (self.section.tableViewManager.tableNode) {
        [self.section.tableViewManager.tableNode.view reloadRowsAtIndexPaths:@[self.indexPath] withRowAnimation:animation];
    }
}

- (void)deleteRowWithAnimation:(UITableViewRowAnimation)animation
{
    TFTableViewSection *section = self.section;
    NSIndexPath *currentIndexPath = self.indexPath;
    //remove the item in section.
    [section removeItemAtIndex:currentIndexPath.row];
    //remove the cell in tableView.
    if (self.section.tableViewManager.tableView) {
        [self.section.tableViewManager.tableView deleteRowsAtIndexPaths:@[currentIndexPath] withRowAnimation:animation];
    }
    else if (self.section.tableViewManager.tableNode) {
        [self.section.tableViewManager.tableNode.view deleteRowsAtIndexPaths:@[currentIndexPath] withRowAnimation:animation];
    }
}



@end
