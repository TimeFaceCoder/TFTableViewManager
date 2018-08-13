//
//  TestTimelineViewController.m
//  TFTableViewManager
//
//  Created by Melvin on 2018/8/13.
//  Copyright © 2018 TFAppleWork-Summer. All rights reserved.
//

#import "TestTimelineViewController.h"
#import "TFTableViewManager.h"
#import "TFTableViewItemCellNode.h"
#import "TimeLineItem.h"
#import "SkeletonView-Swift.h"

@interface TestTimelineViewController ()

@property (nonatomic, strong) ASTableNode *tableNode;

@property (nonatomic, strong) TFTableViewManager *manager;

@end

@implementation TestTimelineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view addSubnode:self.tableNode];
    self.manager = [[TFTableViewManager alloc] initWithTableNode:self.tableNode];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^(void) {
        @autoreleasepool {
            NSArray *temp = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"data"
                                                                                             ofType:@"plist"]];
            TFTableViewSection *section = [TFTableViewSection section];
            for (NSDictionary *entry in temp) {
                [section addItem:[TimeLineItem itemWithModel:entry]];
            }
            [self->_manager addSection:section];
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            [self->_tableNode reloadData];
        });
    });
    
}

#pragma mark - lazy init

- (ASTableNode *)tableNode {
    if (!_tableNode) {
        CGSize screenSize = [UIScreen mainScreen].bounds.size;
        _tableNode = [[ASTableNode alloc] initWithStyle:UITableViewStylePlain];
        _tableNode.frame = CGRectMake(0, 0, screenSize.width, screenSize.height);
    }
    return _tableNode;
}

- (void)dealloc {
    NSLog(@"dealloc:%@",NSStringFromClass([self class]));
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
