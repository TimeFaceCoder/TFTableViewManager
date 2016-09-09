//
//  TestASDefaultItemViewController.m
//  TFTableViewManager
//
//  Created by Summer on 16/9/6.
//  Copyright © 2016年 Summer. All rights reserved.
//

#import "TestASDefaultItemViewController.h"
#import "TFTableViewManager.h"
#import "TFDefaultTableViewItem.h"
#import "TFDefaultTableViewItemCellNode.h"
@interface TestASDefaultItemViewController ()

@property (nonatomic, strong) ASTableNode *tableNode;

@property (nonatomic, strong) TFTableViewManager *manager;

@end

@implementation TestASDefaultItemViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubnode:self.tableNode];
    self.manager = [[TFTableViewManager alloc] initWithTableNode:self.tableNode];
    self.manager[@"TFDefaultTableViewItem"] = @"TFDefaultTableViewItemCellNode";
    
    NSArray *sections = @[@{@"title":@"UITableViewCellStyleDefault",@"contents":@[@{@"text":@"shortText",@"style":@(UITableViewCellStyleDefault)},
                                                                                  @{@"text":@"shortTextWithImage",@"style":@(UITableViewCellStyleDefault),@"image":@"contactSelected"},
                                                                                  @{@"text":@"longText:的玩家爱豆我我就掉网的骄傲为大家我ID阿瓦的骄傲文件",@"style":@(UITableViewCellStyleDefault)},
                                                                                  @{@"text":@"longTextWithImage:的玩家爱豆我我就掉网的骄傲为大家我ID阿瓦的骄傲文件",@"style":@(UITableViewCellStyleDefault),@"image":@"userpic1"}]},
                          @{@"title":@"UITableViewCellStyleValue1",@"contents":@[  @{@"text":@"shortText",@"style":@(UITableViewCellStyleValue1),@"detail":@"shortDetail"},
                                                                                   @{@"text":@"shortTextWithImage",@"style":@(UITableViewCellStyleValue1),@"detail":@"shortDetail",@"image":@"contactSelected"},
                                                                                   @{@"text":@"shortText",@"style":@(UITableViewCellStyleValue1),@"detail":@"longDetail:文件迪欧挖掘鲷玩文件迪欧挖掘鲷玩文件迪欧挖掘鲷玩文件迪欧挖掘鲷玩文件迪欧挖掘鲷玩"},
                                                                                   @{@"text":@"shortTextWithImage",@"style":@(UITableViewCellStyleValue1),@"detail":@"longDetail:文件迪欧挖掘鲷玩家胸襟带我Joi阿吉豆我爱Joi大Joi我的骄傲IDJoi爱我多久我我安静的哦啊及等级哦",@"image":@"userpic2"},
                                                                                   @{@"text":@"longText:的玩家爱豆我我就掉网的骄傲为大家我ID阿瓦的骄傲文件",@"style":@(UITableViewCellStyleValue1),@"detail":@"shortDetail"},
                                                                                   @{@"text":@"longTextWithImage:的玩家爱豆我我就掉网的骄傲为大家我ID阿瓦的骄傲文件",@"style":@(UITableViewCellStyleValue1),@"detail":@"shortDetail",@"image":@"userpic2"}]},
                          @{@"title":@"UITableViewCellStyleSubtitle",@"contents":@[ @{@"text":@"shortText",@"style":@(UITableViewCellStyleSubtitle),@"detail":@"longDetail:文件迪欧挖掘鲷玩家胸襟带我Joi阿吉豆我爱Joi大Joi我的骄傲IDJoi爱我多久我我安静的哦啊及等级哦"},
                                                                                    @{@"text":@"shortTextWithImage",@"style":@(UITableViewCellStyleSubtitle),@"detail":@"longDetail:文件迪欧挖掘鲷玩家胸襟带我Joi阿吉豆我爱Joi大Joi我的骄傲IDJoi爱我多久我我安静的哦啊及等级哦",@"image":@"contactSelected"},
                                                                                    @{@"text":@"longText:的玩家爱豆我我就掉网的骄傲为大家我ID阿瓦的骄傲文件",@"style":@(UITableViewCellStyleSubtitle),@"detail":@"shortDetail"},
                                                                                    @{@"text":@"longTextWithImage:的玩家爱豆我我就掉网的骄傲为大家我ID阿瓦的骄傲文件",@"style":@(UITableViewCellStyleSubtitle),@"detail":@"shortDetail",@"image":@"userpic2"}
 
                                                                                    ]}];
                            
                            for (NSDictionary *sectionDic in sections) {
                                TFTableViewSection *section = [TFTableViewSection sectionWithHeaderTitle:sectionDic[@"title"]];
                                NSArray *contentArr = sectionDic[@"contents"];
                                
                                for (NSDictionary *contentDic in contentArr) {
                                    TFDefaultTableViewItem *item = [TFDefaultTableViewItem item];
                                    item.text = contentDic[@"text"];
                                    item.cellStyle = [contentDic[@"style"] integerValue];
                                    item.image = [UIImage imageNamed:contentDic[@"image"]];
                                    item.detail = contentDic[@"detail"];
                                    item.selectionStyle = UITableViewCellSelectionStyleDefault;
                                    item.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                                    item.cellHeight = 60.0;
                                    [section addItem:item];
                                }
                                [self.manager addSection:section];

                            }
    
}

#pragma mark - lazy init

- (ASTableNode *)tableNode {
    if (!_tableNode) {
        CGSize screenSize = [UIScreen mainScreen].bounds.size;
        _tableNode = [[ASTableNode alloc] initWithStyle:UITableViewStylePlain];
        _tableNode.frame = CGRectMake(0, 0, screenSize.width, screenSize.height);
        _tableNode.view.tableFooterView = [UIView new];
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
