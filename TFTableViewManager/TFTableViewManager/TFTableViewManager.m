//
//  PFTableViewManager.m
//  PFTableViewManagerDemo
//
//  Created by Summer on 16/8/24.
//  Copyright © 2016年 Summer. All rights reserved.
//

#import "TFTableViewManager.h"

@interface TFTableViewManager ()

@property (nonatomic, readwrite, strong) NSMutableArray *mutableSections;

@end

@implementation TFTableViewManager

#pragma mark - Properties.

- (NSArray *)sections
{
    return self.mutableSections;
}

- (NSMutableArray *)mutableSections {
    if (!_mutableSections) {
        _mutableSections = [NSMutableArray array];
    }
    return _mutableSections;
}

- (TFTableViewItem *)itemAtIndexPath:(NSIndexPath *)indexPath {
    return ((TFTableViewSection *)self.mutableSections[indexPath.section]).items[indexPath.row];
}

#pragma mark - Register Custom Cells

- (void)registerClass:(NSString *)objectClass forCellWithReuseIdentifier:(NSString *)identifier
{
    NSAssert(NSClassFromString(objectClass), ([NSString stringWithFormat:@"Item class '%@' does not exist.", objectClass]));
    NSAssert(NSClassFromString(identifier), ([NSString stringWithFormat:@"Cell class '%@' does not exist.", identifier]));
    self.registeredClasses[(id <NSCopying>)NSClassFromString(objectClass)] = NSClassFromString(identifier);
}

- (id)objectAtKeyedSubscript:(id <NSCopying>)key
{
    return [self.registeredClasses objectForKey:key];
}

- (void)setObject:(id)obj forKeyedSubscript:(id <NSCopying>)key
{
    [self registerClass:(NSString *)key forCellWithReuseIdentifier:obj];
}

- (Class)classForCellAtIndexPath:(NSIndexPath *)indexPath
{
    TFTableViewSection *section = self.mutableSections[indexPath.section];
    NSObject *item = section.items[indexPath.row];
    return self.registeredClasses[item.class];
}


#pragma mark Add and insert sections.

- (void)addSection:(TFTableViewSection *)section {
    section.tableViewManager = self;
    [self.mutableSections addObject:section];
}

- (void)addSectionsFromArray:(NSArray *)array {
    for (TFTableViewSection *section in array) {
        [self addSection:section];
    }
}

- (void)insertSection:(TFTableViewSection *)section atIndex:(NSUInteger)index {
    section.tableViewManager = self;
    [self.mutableSections insertObject:section atIndex:index];
}

- (void)insertSections:(NSArray *)sections atIndexes:(NSIndexSet *)indexes {
    for (TFTableViewSection *section in sections) {
        section.tableViewManager = self;
    }
    [self.mutableSections insertObjects:sections atIndexes:indexes];
}

#pragma mark - Remove Sections

- (void)removeSection:(TFTableViewSection *)section {
    [self.mutableSections removeObject:section];
}

- (void)removeSectionAtIndex:(NSUInteger)index {
    [self.mutableSections removeObjectAtIndex:index];
}

- (void)removeLastSection {
    [self.mutableSections removeLastObject];
}

- (void)removeAllSections {
    [self.mutableSections removeAllObjects];
}

- (void)removeSectionsInArray:(NSArray *)array {
    [self.mutableSections removeObjectsInArray:array];
}

- (void)removeSectionsInRange:(NSRange)range {
    [self.mutableSections removeObjectsInRange:range];
}

- (void)removeSection:(TFTableViewSection *)section inRange:(NSRange)range {
    [self.mutableSections removeObject:section inRange:range];
}

- (void)removeSectionsAtIndexes:(NSIndexSet *)indexes {
    [self.mutableSections removeObjectsAtIndexes:indexes];
}

#pragma mark - Replace Sections.

- (void)replaceSectionAtIndex:(NSUInteger)index withSection:(TFTableViewSection *)section {
    section.tableViewManager = self;
    [self.mutableSections replaceObjectAtIndex:index withObject:section];
}

- (void)replaceSectionsWithSectionsFromArray:(NSArray *)array {
    [self removeAllSections];
    [self addSectionsFromArray:array];
}

- (void)replaceSectionsAtIndexes:(NSIndexSet *)indexes withSections:(NSArray *)sections {
    for (TFTableViewSection *section in sections) {
        section.tableViewManager = self;
    }
    [self.mutableSections replaceObjectsAtIndexes:indexes withObjects:sections];
}

- (void)replaceSectionsInRange:(NSRange)range withSectionsFromArray:(NSArray *)array {
    for (TFTableViewSection *section in array) {
        section.tableViewManager = self;
    }
    [self.mutableSections replaceObjectsInRange:range withObjectsFromArray:array];
}

#pragma mark - Rearranging Sections

- (void)exchangeSectionAtIndex:(NSUInteger)idx1 withSectionAtIndex:(NSUInteger)idx2 {
    [self.mutableSections exchangeObjectAtIndex:idx1 withObjectAtIndex:idx2];
}

- (void)sortSectionsUsingFunction:(NSInteger (*)(id, id, void *))compare context:(void *)context
{
    [self.mutableSections sortUsingFunction:compare context:context];
}

- (void)sortSectionsUsingSelector:(SEL)comparator
{
    [self.mutableSections sortUsingSelector:comparator];
}




@end
