//
//  BNRItemStore.m
//  Homepwner
//
//  Created by Roman Solyakh on 11.11.14.
//  Copyright (c) 2014 Big Nerd Ranch. All rights reserved.
//

#import "BNRItemStore.h"
#import "BNRItem.h"

@interface BNRItemStore ()

@property (nonatomic) NSMutableArray *privateItems;

@end

@implementation BNRItemStore

+(instancetype)sharedStore
{
    static BNRItemStore *sharedInstance = nil;
    static dispatch_once_t token;
    dispatch_once(&token, ^{
        sharedInstance = [[BNRItemStore alloc] initPrivate];
    });
    
    return sharedInstance;
}

-(instancetype)initPrivate
{
    self = [super init];
    if(self)
    {
        _privateItems = [[NSMutableArray alloc] init];
    }
    return self;
}

-(NSArray *)allItems
{
    return self.privateItems;
}

-(BNRItem *)createItem
{
    NSInteger itemNumber = [self.privateItems count] + 1;
    NSString *info = [NSString stringWithFormat:@"Item %d", itemNumber];
    BNRItem *item = [[BNRItem alloc] initWithInfo:info andPrice:itemNumber * 10];
    [self.privateItems addObject:item];
    return item;
}

-(BNRItem *)itemInSection:(NSInteger)section withIndex:(NSInteger)index
{
    for (BNRItem *item in self.allItems)
    {
        if([self sectionForItem:item] == section)
        {
            if(index==0)
                return item;
            else
                index--;
        }
    }
    
    return nil;
}

-(NSInteger)itemsCountInSection:(NSInteger)section
{
    NSInteger count = 0;
    for (BNRItem *item in self.allItems)
    {
        if([self sectionForItem:item] == section)
            count++;
    }
    return count;
}

-(NSInteger)sectionForItem:(BNRItem *)item
{
    return 0;
}

@end
