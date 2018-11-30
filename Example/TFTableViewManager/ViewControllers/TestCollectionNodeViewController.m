//
//  TestCollectionNodeViewController.m
//  TFTableViewManager
//
//  Created by Melvin on 2018/11/29.
//  Copyright © 2018 TFAppleWork-Summer. All rights reserved.
//

#import "TestCollectionNodeViewController.h"
#import "TFTableViewManager.h"
#import "TFTableViewItemCellNode.h"
#import "TimeLineItem.h"
#import "TFTableViewManager-Bridging-Header.h"
#import "TFTableViewManager-Swift.h"
#import "MosaicCollectionLayoutDelegate.h"
#import "ImageCellNode.h"
#import "ImageCollectionViewCell.h"
#import "DemoCollectionItem.h"

@interface TestCollectionNodeViewController ()

@property (nonatomic ,strong) ASCollectionNode *collectionNode;
@property (nonatomic ,strong) TFTableViewManager *manager;

@end

@implementation TestCollectionNodeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view addSubnode:self.collectionNode];
    
    self.manager = [[TFTableViewManager alloc] initWithCollectionNode:_collectionNode];

    TFTableViewSection *section = [TFTableViewSection section];

    for (NSUInteger idx = 0; idx < 14; idx++) {
        NSString *name = [NSString stringWithFormat:@"image_%lu.jpg", (unsigned long)idx];

        DemoCollectionItem *item = [DemoCollectionItem itemWithImageName:name];
        [section addItem:item];

    }

    [self.manager addSection:section];


    [self->_collectionNode reloadData];
    [self->_collectionNode showLoader];
//    [NSTimer scheduledTimerWithTimeInterval:5
//                                     target:self
//                                   selector:@selector(showLoader)
//                                   userInfo:nil
//                                    repeats:NO];
//
    
//    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^(void) {
//        @autoreleasepool {
//            NSArray *temp = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"data"
//                                                                                             ofType:@"plist"]];
//            TFTableViewSection *section = [TFTableViewSection section];
//            NSInteger index = 0;
//            NSDictionary *tempData = nil;
//            for (NSDictionary *entry in temp) {
//                if (index == 0) {
//                    tempData = entry;
//                }
//                [section addItem:[TimeLineItem itemWithModel:entry]];
//                index ++;
//            }
//            [self->_manager addSection:section];
//        }
//        dispatch_async(dispatch_get_main_queue(), ^{
//            [self->_collectionNode reloadData];
//            [self->_collectionNode showLoader];
//            [NSTimer scheduledTimerWithTimeInterval:5
//                                             target:self
//                                           selector:@selector(showLoader)
//                                           userInfo:nil
//                                            repeats:NO];
//        });
//    });
}


- (void)showLoader {
    [self.collectionNode showLoader];
    [NSTimer scheduledTimerWithTimeInterval:5 target:self selector:@selector(removeLoader) userInfo:nil repeats:NO];
    
}

- (void)removeLoader {
    [self.collectionNode hideLoader];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (ASCollectionNode *)collectionNode {
    
    if (!_collectionNode) {
        ASCollectionFlowLayoutDelegate *flowLayout = [[ASCollectionFlowLayoutDelegate alloc] initWithScrollableDirections:ASScrollDirectionVerticalDirections];
        MosaicCollectionLayoutDelegate *layoutDelegate = [[MosaicCollectionLayoutDelegate alloc] initWithNumberOfColumns:1 headerHeight:44.0];
        _collectionNode = [[ASCollectionNode alloc] initWithLayoutDelegate:layoutDelegate layoutFacilitator:nil];
        
        CGSize screenSize = [UIScreen mainScreen].bounds.size;
        _collectionNode.frame = CGRectMake(0, 0, screenSize.width, screenSize.height);
    }
    return _collectionNode;
    
}


@end
