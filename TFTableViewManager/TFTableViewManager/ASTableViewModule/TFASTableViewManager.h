//
//  TFASTableViewManager.h
//  PFTableViewManagerDemo
//
//  Created by Summer on 16/8/26.
//  Copyright © 2016年 Summer. All rights reserved.
//

#import "TFTableViewManager.h"
#import <AsyncDisplayKit.h>

@protocol TFASTableViewManagerDelegate;

/**
 *  `PFTableViewManager` allows to manage the content of any `ASTableView` with ease, both forms and lists. `TFASTableViewManager` is built on top of reusable cells technique and provides
 APIs for mapping any object class to any custom cell subclass.
 
 The general idea is to allow developers to use their own `ASTableView` and instances (and even subclasses), providing a layer that synchronizes data with the cell appereance.
 It fully implements `ASTableViewDataSource` and `ASTableViewDelegate` protocols so you don't have to.
 */
@interface TFASTableViewManager : TFTableViewManager <ASTableDataSource,ASTableDelegate>

@property (weak, nonatomic) ASTableNode *tableNode;

/**
 *  @brief The object that acts as the delegate of the receiving table view.
 */
@property (weak, nonatomic) id<TFASTableViewManagerDelegate> delegate;

///-----------------------------
/// @name Creating and Initializing a PFTableViewManager
///-----------------------------

/**
 *  Initialize a table view manager object for a specific `ASTableView`.
 *
 *  @param tableView The ASTableView that needs to be managed.
 *
 *  @return The pointer to the instance, or `nil` if initialization failed.
 */
- (instancetype)initWithTableNode:(ASTableNode *)tableNode;

@end

/**
 *  The delegate of a `TFASTableViewManager` object can adopt the `TFASTableViewManagerDelegate` protocol. Optional methods of the protocol allow the delegate to manage nodes.
 */
@protocol TFASTableViewManagerDelegate <ASTableDelegate>

/**
 * Receive a message that the tableView is near the end of its data set and more data should be fetched if necessary.
 *
 * @param tableView The sender.
 * @param context A context object that must be notified when the batch fetch is completed.
 *
 * @discussion You must eventually call -completeBatchFetching: with an argument of YES in order to receive future
 * notifications to do batch fetches. This method is called on a background queue.
 *
 * ASTableView currently only supports batch events for tail loads. If you require a head load, consider implementing a
 * UIRefreshControl.
 */
- (void)tableView:(ASTableView *)tableView willBeginBatchFetchWithContext:(ASBatchContext *)context;

/**
 * Tell the tableView if batch fetching should begin.
 *
 * @param tableView The sender.
 *
 * @discussion Use this method to conditionally fetch batches. Example use cases are: limiting the total number of
 * objects that can be fetched or no network connection.
 *
 * If not implemented, the tableView assumes that it should notify its asyncDelegate when batch fetching
 * should occur.
 */
- (BOOL)shouldBatchFetchForTableView:(ASTableView *)tableView;

/**
 *  Informs the delegate that the table view will display the provided node from the view hierarchy.
 *
 *  @param tableView The sender.
 *  @param indexPath The index path at which the node was located before the removal.
 */
- (void)tableView:(ASTableView *)tableView willDisplayNodeForRowAtIndexPath:(NSIndexPath *)indexPath;

/**
 * Informs the delegate that the table view did remove the provided node from the view hierarchy.
 * This may be caused by the node scrolling out of view, or by deleting the row
 * or its containing section with @c deleteRowsAtIndexPaths:withRowAnimation: or @c deleteSections:withRowAnimation: .
 *
 * @param tableView The sender.
 * @param node The node which was removed from the view hierarchy.
 * @param indexPath The index path at which the node was located before the removal.
 */
- (void)tableView:(ASTableView *)tableView didEndDisplayingNode:(ASCellNode *)node forRowAtIndexPath:(NSIndexPath *)indexPath;

@end