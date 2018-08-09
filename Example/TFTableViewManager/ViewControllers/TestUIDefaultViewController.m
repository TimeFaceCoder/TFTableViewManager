//
//  TestUIDefaultViewController.m
//  TFTableViewManager
//
//  Created by Summer on 16/9/7.
//  Copyright © 2016年 Summer. All rights reserved.
//

#import "TestUIDefaultViewController.h"
#import "TFTableViewManager.h"
#import "TFDefaultTableViewItem.h"
#import "TFDefaultTableViewItemCell.h"

@interface TestUIDefaultViewController ()


@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) TFTableViewManager *manager;


@end

@implementation TestUIDefaultViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self.view addSubview:self.tableView];
    self.manager = [[TFTableViewManager alloc]initWithTableView:self.tableView];
    NSArray *sections = @[@{@"title":@"UITableViewCellStyleDefault",@"contents":@[@{@"text":@"shortText",@"style":@(UITableViewCellStyleDefault)},
                                                                                  @{@"text":@"shortTextWithImage",@"style":@(UITableViewCellStyleDefault),@"image":@"calendar-icon-1"},
                                                                                  @{@"text":@"longText:的玩家爱豆我我就掉网的骄傲为大家我ID阿瓦的骄傲文件",@"style":@(UITableViewCellStyleDefault)},
                                                                                  @{@"text":@"longTextWithImage:的玩家爱豆我我就掉网的骄傲为大家我ID阿瓦的骄傲文件",@"style":@(UITableViewCellStyleDefault),@"image":@"contactSelected"}]},
                          @{@"title":@"UITableViewCellStyleValue1",@"contents":@[  @{@"text":@"shortText",@"style":@(UITableViewCellStyleValue1),@"detail":@"shortDetail"},
                                                                                   @{@"text":@"shortTextWithImage",@"style":@(UITableViewCellStyleValue1),@"detail":@"shortDetail",@"image":@"userpic1"},
                                                                                   @{@"text":@"shortText",@"style":@(UITableViewCellStyleValue1),@"detail":@"longDetail:文件迪欧挖掘鲷玩文件迪欧挖掘鲷玩文件迪欧挖掘鲷玩文件迪欧挖掘鲷玩文件迪欧挖掘鲷玩"},
                                                                                   @{@"text":@"shortTextWithImage",@"style":@(UITableViewCellStyleValue1),@"detail":@"longDetail:文件迪欧挖掘鲷玩家胸襟带我Joi阿吉豆我爱Joi大Joi我的骄傲IDJoi爱我多久我我安静的哦啊及等级哦",@"image":@"contactSelected"},
                                                                                   @{@"text":@"longText:的玩家爱豆我我就掉网的骄傲为大家我ID阿瓦的骄傲文件",@"style":@(UITableViewCellStyleValue1),@"detail":@"shortDetail"},
                                                                                   @{@"text":@"longTextWithImage:的玩家爱豆我我就掉网的骄傲为大家我ID阿瓦的骄傲文件",@"style":@(UITableViewCellStyleValue1),@"detail":@"shortDetail",@"image":@"contactSelected"}]},
                          @{@"title":@"UITableViewCellStyleSubtitle",@"contents":@[ @{@"text":@"shortText",@"style":@(UITableViewCellStyleSubtitle),@"detail":@"longDetail:文件迪欧挖掘鲷玩家胸襟带我Joi阿吉豆我爱Joi大Joi我的骄傲IDJoi爱我多久我我安静的哦啊及等级哦"},
                                                                                    @{@"text":@"shortTextWithImage",@"style":@(UITableViewCellStyleSubtitle),@"detail":@"longDetail:文件迪欧挖掘鲷玩家胸襟带我Joi阿吉豆我爱Joi大Joi我的骄傲IDJoi爱我多久我我安静的哦啊及等级哦",@"image":@"userpic2"},
                                                                                    @{@"text":@"longText:的玩家爱豆我我就掉网的骄傲为大家我ID阿瓦的骄傲文件",@"style":@(UITableViewCellStyleSubtitle),@"detail":@"shortDetail"},
                                                                                    @{@"text":@"longTextWithImage:的玩家爱豆我我就掉网的骄傲为大家我ID阿瓦的骄傲文件",@"style":@(UITableViewCellStyleSubtitle),@"detail":@"shortDetail",@"image":@"contactSelected"}
                                                                                    
                                                                                    ]}];
    
    for (NSDictionary *sectionDic in sections) {
        TFTableViewSection *section = [TFTableViewSection sectionWithHeaderTitle:sectionDic[@"title"]];
        NSArray *contentArr = sectionDic[@"contents"];
        
        for (NSDictionary *contentDic in contentArr) {
            TFDefaultTableViewItem *item = [TFDefaultTableViewItem item];
            item.text = contentDic[@"text"];
            item.cellStyle = [contentDic[@"style"] integerValue];
            item.cellIdentifier = [NSString stringWithFormat:@"Cell%zd",item.cellStyle];
            item.image = [UIImage imageNamed:contentDic[@"image"]];
            item.detail = contentDic[@"detail"];
            item.selectionStyle = UITableViewCellSelectionStyleDefault;
            item.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            item.cellHeight = 80.0;
            [section addItem:item];
            
        }
        section.footerHeight = 0.1f;
        [self.manager addSection:section];
        
    }

}

- (UITableView *)tableView {
    if (!_tableView) {
        CGSize screenSize = [UIScreen mainScreen].bounds.size;
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, screenSize.width, screenSize.height) style:UITableViewStyleGrouped];
        _tableView.backgroundColor = [UIColor cyanColor];
    }
    return _tableView;
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
