//
//  ContactsViewController.m
//  TFTableViewManager
//
//  Created by zguanyu on 16/9/14.
//  Copyright © 2016年 Summer. All rights reserved.
//

#import "ContactsViewController.h"
#import "Person.h"
#import "BMChineseSort.h"
#import "TFTableViewManager.h"
#import "PersonItem.h"
@interface ContactsViewController ()
@property (nonatomic, strong)NSMutableArray<Person *> *dataArray;
//排序后的出现过的拼音首字母数组
@property(nonatomic,strong)NSMutableArray *indexArray;
//排序好的结果数组
@property(nonatomic,strong)NSMutableArray *letterResultArr;

@property (nonatomic, strong) ASTableNode *tableNode;

@property (nonatomic, strong) TFTableViewManager *manager;
@end

@implementation ContactsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self loadData];
    //根据Person对象的 name 属性 按中文 对 Person数组 排序
    self.indexArray = [BMChineseSort IndexWithArray:self.dataArray Key:@"name"];
    self.letterResultArr = [BMChineseSort sortObjectArray:self.dataArray Key:@"name"];
    
    [self.view addSubnode:self.tableNode];
    self.manager = [[TFTableViewManager alloc] initWithTableNode:self.tableNode];
    self.manager[@"PersonItem"] = @"PersonItemCellNode";

    for (int i = 0; i < self.indexArray.count; ++i) {
        TFTableViewSection* section = [TFTableViewSection sectionWithHeaderTitle:[self.indexArray objectAtIndex:i]];
        section.headerHeight = 25.0f;
        NSArray* data = [self.letterResultArr objectAtIndex:i];
        for (Person* p in data) {
            PersonItem* item = [PersonItem itemWithModel:p];
            [section addItem:item];
        }
        section.indexTitle = [self.indexArray objectAtIndex:i];
        [self.manager addSection:section];
    }
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
//加载模拟数据
-(void)loadData{
    NSArray *stringsToSort=[NSArray arrayWithObjects:
                            @"李白",@"张三",
                            @"黄晓明",@"成龙",@"斑马",@"盖伦",
                            @"幻刺",@"暗影猎手",@"小白",@"小明",@"千珏",
                            @"黄家驹", @"鼠标",@"hello",@"多美丽",@"肯德基",@"##",
                            nil];
    
    //模拟网络请求接收到的数组对象
    self.dataArray = [[NSMutableArray alloc] initWithCapacity:0];
    for (int i = 0; i<[stringsToSort count]; i++) {
        Person *p = [[Person alloc] init];
        p.name = [stringsToSort objectAtIndex:i];
        p.number = i;
        p.phone = @"13813861032";
        p.avatar = @"userpic1";
        [self.dataArray addObject:p];
    }
}
@end
