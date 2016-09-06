//
//  PFUITableViewItemCell.h
//  PFTableViewManagerDemo
//
//  Created by Summer on 16/8/26.
//  Copyright © 2016年 Summer. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TFUITableViewManager;
@class TFTableViewItem;

@interface TFUITableViewItemCell : UITableViewCell

///-----------------------------
/// @name Properties.
///-----------------------------

/**
 *  @brief The `PFUITableViewManager` that needs to be managed using this `PFUITableViewItemCell`.
 */
@property (weak, nonatomic) TFUITableViewManager *tableViewManager;

/**
 *  @brief the item of the cell.
 */
@property (strong, nonatomic) TFTableViewItem *tableViewItem;

///-----------------------------
/// @name Handling Cell Events.
///-----------------------------

/**
 *  height for the item
 *
 *  @param item             a PFTableViewItem.
 *  @param tableViewManager handle items.
 *
 *  @return a CGFloat value of cell height.
 */
+ (CGFloat)heightWithItem:(TFTableViewItem *)item tableViewManager:(TFUITableViewManager *)tableViewManager;

///-----------------------------
/// @name Cell life cycle.
///-----------------------------

/**
 *  add cell subviews in this method.
 */
- (void)cellLoadSubViews;

/**
 *  cell will appear, deal with the display values of subviews in this method.
 */
- (void)cellWillAppear;

/**
 *  cell did disappear.
 */
- (void)cellDidDisappear;



@end
