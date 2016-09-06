//
//  PFUITableViewManager.m
//  PFTableViewManagerDemo
//
//  Created by Summer on 16/8/26.
//  Copyright © 2016年 Summer. All rights reserved.
//

#import "TFUITableViewManager.h"

@interface TFUITableViewManager ()

@property (strong, nonatomic) NSMutableDictionary *registeredXIBs;// The array of pairs of items / cell classes.


@end

@implementation TFUITableViewManager

#pragma mark - Creating and Initializing a PFUITableViewManager

- (id)initWithTableView:(UITableView *)tableView
{
    self = [super init];
    if (self)
    {
        tableView.delegate     = self;
        tableView.dataSource   = self;
        self.tableView         = tableView;
        self.registeredClasses = [[NSMutableDictionary alloc] init];
        self.registeredXIBs    = [[NSMutableDictionary alloc] init];
    }
    return self;
}

// overwrite super method to support xib.
- (void)registerClass:(NSString *)objectClass forCellWithReuseIdentifier:(NSString *)identifier {
    [super registerClass:objectClass forCellWithReuseIdentifier:identifier];
    if ([[NSBundle mainBundle] pathForResource:identifier ofType:@"nib"]) {
        //XIB exists with the same name as the cell class
        self.registeredXIBs[identifier] = objectClass;
        [self.tableView registerNib:[UINib nibWithNibName:identifier bundle:[NSBundle mainBundle]] forCellReuseIdentifier:objectClass];
    }
}

#pragma mark - Table view data source.

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.mutableSections.count;
}

-  (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    TFTableViewSection *tableViewSection = self.mutableSections[section];
    return tableViewSection.items.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TFTableViewItem *item = [self itemAtIndexPath:indexPath];
    Class cellClass = [self classForCellAtIndexPath:indexPath];
    NSString *identifier = NSStringFromClass(cellClass);
    TFUITableViewItemCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[cellClass alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        // PFUITableViewManagerDelegate
        if ([self.delegate respondsToSelector:@selector(tableView:didLoadCellSubViews:forRowAtIndexPath:)]) {
            [self.delegate tableView:tableView didLoadCellSubViews:cell forRowAtIndexPath:indexPath];
        }
        cell.tableViewItem = item;
        [cell cellLoadSubViews];
    }
    cell.tableViewManager = self;
    cell.tableViewItem = item;
    [cell cellWillAppear];
    return cell;
    
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    TFTableViewSection *tableViewSection = self.mutableSections[section];
    return tableViewSection.headerTitle;
}

- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section
{
    TFTableViewSection *tableViewSection = self.mutableSections[section];
    return tableViewSection.footerTitle;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    TFTableViewItem *item = [self itemAtIndexPath:indexPath];
    BOOL edit = ((item.editingStyle != UITableViewCellEditingStyleNone) | (item.editActions.count!=0));
    return edit;
}

- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    TFTableViewItem *item = [self itemAtIndexPath:indexPath];
    return item.moveHandler != nil;
}

- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    NSMutableArray *titles = [NSMutableArray array];
    for (TFTableViewSection *section in self.mutableSections) {
        if (section.indexTitle.length) {
            [titles addObject:section.indexTitle];
        }
    }
    return titles.count ? titles:nil;
}

- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index {
    TFTableViewSection *tableViewSection = self.mutableSections[index];
    if (tableViewSection.sectionIndex!=-1) {
        return tableViewSection.sectionIndex;
    }
    return index;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (editingStyle) {
        case UITableViewCellEditingStyleNone:
        {
            
        }
            break;
        case UITableViewCellEditingStyleDelete: {
            TFTableViewItem *item = [self itemAtIndexPath:indexPath];
            if (item.deletionHandler) {
                item.deletionHandler(item,indexPath);
            }

        }
            break;
        case UITableViewCellEditingStyleInsert: {
            TFTableViewItem *item = [self itemAtIndexPath:indexPath];
            if (item.insertionHandler) {
                item.insertionHandler(item,indexPath);
            }
        }
            break;
        default:
            break;
    }
}

- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath {
    TFTableViewSection *sourceSection = self.mutableSections[sourceIndexPath.section];
    TFTableViewItem *sourceItem = sourceSection.items[sourceIndexPath.row];
    [sourceSection removeItem:sourceItem];
    TFTableViewSection *destinationSection = self.mutableSections[destinationIndexPath.section];
    [destinationSection insertItem:sourceItem atIndex:destinationIndexPath.row];
    if (sourceItem.moveCompletionHandler) {
        sourceItem.moveCompletionHandler (sourceItem,sourceIndexPath,destinationIndexPath);
    }
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
   

    if ([self.delegate respondsToSelector:@selector(tableView:willDisplayCell:forRowAtIndexPath:)]) {
        [self.delegate tableView:tableView willDisplayCell:cell forRowAtIndexPath:indexPath];
    }
}

- (void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section {
    if ([self.delegate respondsToSelector:@selector(tableView:willDisplayHeaderView:forSection:)]) {
        [self.delegate tableView:tableView willDisplayHeaderView:view forSection:section];
    }
}

- (void)tableView:(UITableView *)tableView willDisplayFooterView:(UIView *)view forSection:(NSInteger)section {
    if ([self.delegate respondsToSelector:@selector(tableView:willDisplayFooterView:forSection:)]) {
        [self.delegate tableView:tableView willDisplayFooterView:view forSection:section];
    }
}

- (void)tableView:(UITableView *)tableView didEndDisplayingCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    [(TFUITableViewItemCell *)cell cellDidDisappear];
    if ([self.delegate respondsToSelector:@selector(tableView:didEndDisplayingCell:forRowAtIndexPath:)]) {
        [self.delegate tableView:tableView didEndDisplayingCell:cell forRowAtIndexPath:indexPath];
    }
}

- (void)tableView:(UITableView *)tableView didEndDisplayingHeaderView:(UIView *)view forSection:(NSInteger)section {
    if ([self.delegate respondsToSelector:@selector(tableView:didEndDisplayingHeaderView:forSection:)]) {
        [self.delegate tableView:tableView didEndDisplayingHeaderView:view forSection:section];
    }
}

- (void)tableView:(UITableView *)tableView didEndDisplayingFooterView:(UIView *)view forSection:(NSInteger)section {
    if ([self.delegate respondsToSelector:@selector(tableView:didEndDisplayingFooterView:forSection:)]) {
        [self.delegate tableView:tableView didEndDisplayingFooterView:view forSection:section];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([self.delegate respondsToSelector:@selector(tableView:heightForRowAtIndexPath:)]) {
        return [self.delegate tableView:tableView heightForRowAtIndexPath:indexPath];
    }
    TFTableViewItem *item = [self itemAtIndexPath:indexPath];
    return [[self classForCellAtIndexPath:indexPath] heightWithItem:item tableViewManager:self];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if ([self.delegate respondsToSelector:@selector(tableView:heightForHeaderInSection:)]) {
        return [self.delegate tableView:tableView heightForHeaderInSection:section];
    }
    TFTableViewSection *tableViewSection = self.mutableSections[section];
    if (tableViewSection.headerHeight!=0.0) {
        return tableViewSection.headerHeight;
    }
    if (tableViewSection.headerView) {
        return CGRectGetHeight(tableViewSection.headerView.frame);
    }
    if (tableViewSection.headerTitle) {
        CGFloat headerHeight = 0;
        CGFloat headerWidth = CGRectGetWidth(CGRectIntegral(tableView.bounds)) - 40.0f; // 40 = 20pt horizontal padding on each side
        
        CGSize headerRect = CGSizeMake(headerWidth, CGFLOAT_MAX);
        
        CGRect headerFrame = [tableViewSection.headerTitle boundingRectWithSize:headerRect
                                                               options:(NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading)
                                                            attributes:@{ NSFontAttributeName: [UIFont preferredFontForTextStyle:UIFontTextStyleHeadline] }
                                                               context:nil];
        
        headerHeight = headerFrame.size.height;
        
        return headerHeight + 20.0f;
    }
    
    return UITableViewAutomaticDimension;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    if ([self.delegate respondsToSelector:@selector(tableView:heightForFooterInSection:)]) {
        return [self.delegate tableView:tableView heightForFooterInSection:section];
    }
    TFTableViewSection *tableViewSection = self.mutableSections[section];
    if (tableViewSection.footerHeight!=0.0) {
        return tableViewSection.footerHeight;
    }
    if (tableViewSection.footerView) {
        return CGRectGetHeight(tableViewSection.footerView.frame);
    }
    if (tableViewSection.footerTitle) {
        CGFloat footerHeight = 0;
        CGFloat footerWidth = CGRectGetWidth(CGRectIntegral(tableView.bounds)) - 40.0f; // 40 = 20pt horizontal padding on each side
        
        CGSize footerRect = CGSizeMake(footerWidth, CGFLOAT_MAX);
        
        CGRect footerFrame = [tableViewSection.footerTitle boundingRectWithSize:footerRect
                                                               options:(NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading)
                                                            attributes:@{ NSFontAttributeName: [UIFont preferredFontForTextStyle:UIFontTextStyleFootnote] }
                                                               context:nil];
        
        footerHeight = footerFrame.size.height;
        
        return footerHeight + 10.0f;
    }
    return UITableViewAutomaticDimension;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if ([self.delegate respondsToSelector:@selector(tableView:viewForHeaderInSection:)]) {
        return [self.delegate tableView:tableView viewForHeaderInSection:section];
    }
    TFTableViewSection *tableViewSection = self.mutableSections[section];
    if (!tableViewSection.headerReuseIdentifier.length) {
        return tableViewSection.headerView;
    }
    else {
        UITableViewHeaderFooterView *headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:tableViewSection.headerReuseIdentifier];
        if (!headerView) {
            if ([tableViewSection.headerView isKindOfClass:[UITableViewHeaderFooterView class]]) {
                headerView = (UITableViewHeaderFooterView *)tableViewSection.headerView;
            }
            else {
                NSAssert(headerView, @"headerView is not a UITableViewHeaderFooterView class, can not use as reuse view.");
            }
            headerView = (UITableViewHeaderFooterView *)tableViewSection.headerView;
        }
        return headerView;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    if ([self.delegate respondsToSelector:@selector(tableView:viewForFooterInSection:)]) {
        return [self.delegate tableView:tableView viewForFooterInSection:section];
    }
    TFTableViewSection *tableViewSection = self.mutableSections[section];
    if (!tableViewSection.footerReuseIdentifier.length) {
        return tableViewSection.footerView;
    }
    else {
        UITableViewHeaderFooterView *footerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:tableViewSection.footerReuseIdentifier];
        if (!footerView) {
            if ([tableViewSection.footerView isKindOfClass:[UITableViewHeaderFooterView class]]) {
                footerView = (UITableViewHeaderFooterView *)tableViewSection.footerView;
            }
            else {
                NSAssert(footerView, @"footView is not a UITableViewHeaderFooterView class, can not use as reuse view.");
            }
        }
        return footerView;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([self.delegate respondsToSelector:@selector(tableView:didSelectRowAtIndexPath:)]) {
        [self.delegate tableView:tableView didSelectRowAtIndexPath:indexPath];
    }
    TFTableViewItem *item = [self itemAtIndexPath:indexPath];
    if (item.selectionHandler) {
        item.selectionHandler (item,indexPath);
    }
}

- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([self.delegate respondsToSelector:@selector(tableView:didDeselectRowAtIndexPath:)]) {
        [self.delegate tableView:tableView didDeselectRowAtIndexPath:indexPath];
    }
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([self.delegate respondsToSelector:@selector(tableView:editingStyleForRowAtIndexPath:)]) {
        return [self.delegate tableView:tableView editingStyleForRowAtIndexPath:indexPath];
    }
    TFTableViewItem *item = [self itemAtIndexPath:indexPath];
    if (item.editActions) {
        return UITableViewCellEditingStyleDelete;
    }
    return item.editingStyle;
}

- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([self.delegate respondsToSelector:@selector(tableView:titleForDeleteConfirmationButtonForRowAtIndexPath:)]) {
        return [self.delegate tableView:tableView titleForDeleteConfirmationButtonForRowAtIndexPath:indexPath];
    }
    TFTableViewItem *item = [self itemAtIndexPath:indexPath];
    return item.titleForDelete;
}

- (NSArray<UITableViewRowAction *> *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([self.delegate respondsToSelector:@selector(tableView:editActionsForRowAtIndexPath:)]) {
        return [self.delegate tableView:tableView editActionsForRowAtIndexPath:indexPath];
    }
    TFTableViewItem *item = [self itemAtIndexPath:indexPath];
    return item.editActions;
}

- (NSIndexPath *)tableView:(UITableView *)tableView targetIndexPathForMoveFromRowAtIndexPath:(NSIndexPath *)sourceIndexPath toProposedIndexPath:(NSIndexPath *)proposedDestinationIndexPath {
    if ([self.delegate respondsToSelector:@selector(tableView:targetIndexPathForMoveFromRowAtIndexPath:toProposedIndexPath:)]) {
       return [self.delegate tableView:tableView targetIndexPathForMoveFromRowAtIndexPath:sourceIndexPath toProposedIndexPath:proposedDestinationIndexPath];
    }
    return proposedDestinationIndexPath;
}

@end
