//
//  TFTableViewManager.h
//  TFTableViewManagerDemo
//
//  Created by Summer on 16/8/24.
//  Copyright © 2016年 Summer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <AsyncDisplayKit.h>

#import "TFTableViewSection.h"
#import "TFTableViewItem.h"

@protocol TFTableViewManagerDelegate;

/**
 *  Base table view manager.
 */
@interface TFTableViewManager : NSObject

///-----------------------------
/// @name Properties.
///-----------------------------

/**
 *  @brief The 'ASTableNode' that needs to be managed using this 'TFTableViewManager'.
 */
@property (weak, nonatomic) ASTableNode *tableNode;

/**
 *  @brief The `UITableView` that needs to be managed using this `TFTableViewManager`.
 */
@property (weak, nonatomic) UITableView *tableView;

/**
 *  @brief The object that acts as the delegate of the receiving table view.
 */
@property (weak, nonatomic) id<TFTableViewManagerDelegate> delegate;

/**
 *  @brief The array of sections. See TFTableViewSection reference for details.
 */
@property (strong, readonly, nonatomic) NSArray *sections;

/**
 *  @brief The array of pairs of items / cell classes.
 */
@property (strong, nonatomic) NSMutableDictionary *registeredClasses;

///-----------------------------
/// @name Creating and Initializing a TFTableViewManager.
///-----------------------------

/**
 *  Initialize a table view manager object for a specific `UITableView`.
 *
 *  @param tableView The ASTableView or UITableView that needs to be managed.
 *
 *  @return The pointer to the instance, or `nil` if initialization failed.
 */
- (instancetype)initWithTableView:(UITableView *)tableView;

/**
 *  Initialize a table view manager object for a specific `ASTableView`.
 *
 *  @param tableView The ASTableView that needs to be managed.
 *
 *  @return The pointer to the instance, or `nil` if initialization failed.
 */
- (instancetype)initWithTableNode:(ASTableNode *)tableNode;

/**
 *  Get the item at index path.
 *
 *  @param indexPath the item index path.
 */
- (TFTableViewItem *)itemAtIndexPath:(NSIndexPath *)indexPath;

///-----------------------------
/// @name Register Custom Cells
///-----------------------------

/**
 *  For each custom item class that the manager will use, register a cell class.
 *
 *  @param itemClass The item class to be associated with a cell class.
 *  @param cellClass The cell class.
 *  @warning the cell class string must be the same with cell reuseIdentifier.
 */
- (void)registerWithItemClass:(NSString *)itemClass cellClass:(NSString *)cellClass;

/**
 *  Returns cell class at the keyed subscript.
 *
 *  @param key The keyed subscript.
 *
 *  @return The cell class the keyed subscript.
 */
- (id)objectAtKeyedSubscript:(id <NSCopying>)key;

/**
 *  Sets a cell class for the keyed subscript.
 *
 *  @param obj The cell class to set for the keyed subscript.
 *  @param key The keyed subscript.
 */
- (void)setObject:(id)obj forKeyedSubscript:(id <NSCopying>)key;

/**
 *  Returns cell class at specified index path.
 *
 *  @param indexPath The index path of cell.
 *
 *  @return The cell class at index path.
 */
- (Class)classForCellAtIndexPath:(NSIndexPath *)indexPath;

///-----------------------------
/// @name Add and insert sections.
///-----------------------------

/**
 Inserts a given section at the end of the table view.
 
 @param section The section to add to the end of the table view. This value must not be `nil`.
 */
- (void)addSection:(TFTableViewSection *)section;

/**
 *  Adds the sections contained in another given sections array to the end of the table view.
 *
 *  @param array An array of sections to add to the end of the table view.
 */
- (void)addSectionsFromArray:(NSArray *)array;

/**
 *  Inserts a given section into the table view at a given index.
 *
 *  @param section The section to add to the table view. This value must not be nil.
 *  @param index   The index in the sections array at which to insert section. This value must not be greater than the count of sections in the table view.
 */
- (void)insertSection:(TFTableViewSection *)section atIndex:(NSUInteger)index;

/**
 *  Inserts the sections in the provided array into the table view at the specified indexes.
 *
 *  @param sections An array of sections to insert into the table view.
 *  @param indexes  The indexes at which the sections in sections should be inserted. The count of locations in indexes must equal the count of sections.
 */
- (void)insertSections:(NSArray *)sections atIndexes:(NSIndexSet *)indexes;

///-----------------------------
/// @name Remove Sections
///-----------------------------

/**
 *  Removes all occurrences in the table view of a given section.
 *
 *  @param section The section to remove from the table view.
 */
- (void)removeSection:(TFTableViewSection *)section;

/**
 *  Removes the section at index.
 *
 *  @param index The index from which to remove the section in the table view. The value must not exceed the bounds of the table view sections.
 */
- (void)removeSectionAtIndex:(NSUInteger)index;

/**
 *  Removes the section with the highest-valued index in the table view.
 */
- (void)removeLastSection;

/**
 *  Empties the table view of all its sections.
 */
- (void)removeAllSections;

/**
 *  Removes from the table view the sections in another given array.
 *
 *  @param array An array containing the sections to be removed from the table view.
 */
- (void)removeSectionsInArray:(NSArray *)array;

/**
 *  Removes from the table view each of the sections within a given range.
 *
 *  @param range The range of the sections to remove from the table view.
 */
- (void)removeSectionsInRange:(NSRange)range;

/**
 *  Removes all occurrences within a specified range in the table view of a given section.
 *
 *  @param section The section to remove from the table view.
 *  @param range   The range from which to remove section.
 */
- (void)removeSection:(TFTableViewSection *)section inRange:(NSRange)range;

/**
 *  Removes the sections at the specified indexes from the table view.
 *
 *  @param indexes The indexes of the sections to remove from the table view. The locations specified by indexes must lie within the bounds of the table view sections.
 */
- (void)removeSectionsAtIndexes:(NSIndexSet *)indexes;

///-----------------------------
/// @name Replace Sections.
///-----------------------------

/**
 *  Replaces the section at index with `section`.
 *
 *  @param index   The index of the section to be replaced. This value must not exceed the bounds of the table view sections.
 *  @param section The section with which to replace the section at index `index` in the sections array. This value must not be `nil`.
 */
- (void)replaceSectionAtIndex:(NSUInteger)index withSection:(TFTableViewSection *)section;

/**
 *  Replaces the sections in the table view with all of the sections from a given array.
 *
 *  @param array The array of sections from which to select replacements for the sections.
 */
- (void)replaceSectionsWithSectionsFromArray:(NSArray *)array;

/**
 *  Replaces the sections in the table view at specified locations specified with the sections from a given array.
 *
 *  @param indexes  The indexes of the sections to be replaced.
 *  @param sections The sections with which to replace the sections in the table view at the indexes specified by indexes. The count of locations in indexes must equal the count of sections.
 */
- (void)replaceSectionsAtIndexes:(NSIndexSet *)indexes withSections:(NSArray *)sections;

/**
 *  Replaces the sections in the table view specified by a given range with all of the sections from a given array.
 *
 *  @param range The range of sections to replace in (or remove from) the table view.
 *  @param array The array of sections from which to select replacements for the sections in range.
 */
- (void)replaceSectionsInRange:(NSRange)range withSectionsFromArray:(NSArray *)array;

///-----------------------------
/// @name Rearranging Sections.
///-----------------------------

/**
 *  Exchanges the sections in the table view at given indices.
 *
 *  @param idx1 The index of the section with which to replace the section at index idx2.
 *  @param idx2 The index of the section with which to replace the section at index idx1.
 */
- (void)exchangeSectionAtIndex:(NSUInteger)idx1 withSectionAtIndex:(NSUInteger)idx2;

/**
 *  Sorts the sections in ascending order as defined by the comparison function compare.
 *
 *  @param compare The comparison function to use to compare two sections at a time.
 *  @param context The context argument to pass to the compare function.
 */
- (void)sortSectionsUsingFunction:(NSInteger (*)(id, id, void *))compare context:(void *)context;

/**
 *  Sorts the sections in ascending order, as determined by the comparison method specified by a given selector.
 *
 *  @param comparator A selector that specifies the comparison method to use to compare sections in the table view.
 */
- (void)sortSectionsUsingSelector:(SEL)comparator;


@end

@protocol TFTableViewManagerDelegate <UITableViewDelegate,ASTableDelegate>

@optional;

/**
 *  Tells the delegate the table view has created a cell for a particular row and made it reusable.
 *
 *  @param tableView The table-view object informing the delegate of this impending event.
 *  @param cell       A table-view cell object that tableView is going to use when drawing the row.
 *  @param indexPath  An index path locating the row in tableView.
 *  @warning only UITableView support.
 */
- (void)tableView:(UITableView *)tableView didLoadCellSubViews:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath;


@end



