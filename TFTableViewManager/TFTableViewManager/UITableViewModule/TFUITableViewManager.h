//
//  PFUITableViewManager.h
//  PFTableViewManagerDemo
//
//  Created by Summer on 16/8/26.
//  Copyright © 2016年 Summer. All rights reserved.
//

#import "TFTableViewManager.h"
#import "TFUITableViewItemCell.h"

@protocol PFUITableViewManagerDelegate;

@interface TFUITableViewManager : TFTableViewManager <UITableViewDataSource,UITableViewDelegate>

/**
 *  @brief The `UITableView` that needs to be managed using this `PFTableViewManager`.
 */
@property (weak, nonatomic) UITableView *tableView;

/**
 *  @brief The object that acts as the delegate of the receiving table view.
 */
@property (weak, nonatomic) id<PFUITableViewManagerDelegate> delegate;

///-----------------------------
/// @name Creating and Initializing a PFUITableViewManager
///-----------------------------

/**
 *  Initialize a table view manager object for a specific `UITableView`.
 *
 *  @param tableView The ASTableView or UITableView that needs to be managed.
 *
 *  @return The pointer to the instance, or `nil` if initialization failed.
 */
- (instancetype)initWithTableView:(UITableView *)tableView;

@end


@protocol PFUITableViewManagerDelegate <UITableViewDelegate>

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