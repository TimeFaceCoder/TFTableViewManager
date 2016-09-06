//
//  PFTableViewItem.h
//  PFTableViewManagerDemo
//
//  Created by Summer on 16/8/24.
//  Copyright © 2016年 Summer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class TFTableViewSection;

@interface TFTableViewItem : NSObject

///-----------------------------
/// @name PFTableViewItem Properties.
///-----------------------------

/**
 *  @brief Section of the item.
 */
@property (weak, nonatomic) TFTableViewSection *section;

/**
 *  @brief Item cell editing style.
 */
@property (assign, nonatomic) UITableViewCellEditingStyle editingStyle;

/**
 *  @brief cell selection style, default is UITableViewCellSelectionStyleNone.
 */
@property (nonatomic, assign) UITableViewCellSelectionStyle selectionStyle;

/**
 *  @brief the separator line left space, default is zero.
 */
@property (nonatomic, assign) CGFloat separatorLineLeftSpace;

/**
 *  @brief cell accessory type.
 */
@property (nonatomic, assign) UITableViewCellAccessoryType accessoryType;

/**
 *  @brief cell accessory view.
 */
@property (nonatomic, strong) UIView *accessoryView;

/**
 *  @brief Item indexPath in UITableView.
 */
@property (strong, readonly, nonatomic) NSIndexPath *indexPath;

/**
 *  @brief when use UITableViewCell,must set it's cellIdentifier.
 */
@property (nonatomic, copy) NSString *cellIdentifier;

/**
 *  @brief the model of this item.
 */
@property (nonatomic, strong) id model;

/**
 *  @brief handle item inset action.
 */
@property (copy, nonatomic) void (^insertionHandler)(id item, NSIndexPath *indexPath);

/**
 *  @brief handle item delete action.you need delete the cell by yourself.
 */
@property (copy, nonatomic) void (^deletionHandler)(id item , NSIndexPath *indexPath);

/**
 *  @brief handle item when selected.
 */
@property (copy, nonatomic) void (^selectionHandler)(id item, NSIndexPath *indexPath);


/** 
 *  @brief title for delete confirmation button
 */
@property (nonatomic, strong) NSString *titleForDelete;

/**
 *  @brief edit actions for row.
 */
@property (nonatomic, strong) NSArray *editActions;

/**
 *  @brief handle item move action.
 *  @return move the item YES or NO.
 */
@property (copy, nonatomic) BOOL (^moveHandler)(id item, NSIndexPath *sourceIndexPath, NSIndexPath *destinationIndexPath);
/**
 *  @brief handle move completion action
 */
@property (copy, nonatomic) void (^moveCompletionHandler)(id item, NSIndexPath *sourceIndexPath, NSIndexPath *destinationIndexPath);

///-----------------------------
/// @name Creating and Initializing a PFTableViewItem.
///-----------------------------

/**
 *  Creates and returns a new item.
 *
 *  @return A new item.
 */
+ (instancetype)item;

/**
 *  Creates and returns a new item with model.
 *
 *  @param model the model of the item.
 *
 *  @return A new item.
 */
+ (instancetype)itemWithModel:(id)model;

/**
 *  Creates and returns a new item with model and selection handler.
 *
 *  @param model            the model of the item.
 *  @param selectionHandler the item selection handler.
 *
 *  @return A new item.
 */
+ (instancetype)itemWithModel:(id)model
             selectionHandler:(void(^)(id item, NSIndexPath *indexPath))selectionHandler;

///-----------------------------
/// @name reload and select table view item
///-----------------------------

/**
 *  select the row.
 *
 *  @param animated use animation or not.
 */
- (void)selectRowAnimated:(BOOL)animated;

/**
 *  select the row with scroll position.
 *
 *  @param animated       use animation or not.
 *  @param scrollPosition scroll postion when after selecting the row.
 */
- (void)selectRowAnimated:(BOOL)animated scrollPosition:(UITableViewScrollPosition)scrollPosition;

/**
 *  deselect the row.
 *
 *  @param animated use animation or not.
 */
- (void)deselectRowAnimated:(BOOL)animated;

/**
 *  reload the row with UITableViewRowAnimation type.
 *
 *  @param animation A constant that indicates how the reloading is to be animated.
 */
- (void)reloadRowWithAnimation:(UITableViewRowAnimation)animation;

/**
 *  delete the row with UITableViewRowAnimation type.
 *
 *  @param animation A constant that indicates how the reloading is to be animated.
 */
- (void)deleteRowWithAnimation:(UITableViewRowAnimation)animation;


@end
