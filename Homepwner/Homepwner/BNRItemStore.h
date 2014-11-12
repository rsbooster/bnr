//
//  BNRItemStore.h
//  Homepwner
//
//  Created by Roman Solyakh on 11.11.14.
//  Copyright (c) 2014 Big Nerd Ranch. All rights reserved.
//

#import <Foundation/Foundation.h>

@class BNRItem;

@interface BNRItemStore : NSObject

@property (nonatomic, readonly) NSArray *allItems;

+(instancetype)sharedStore;
-(BNRItem *)createItem;
-(BNRItem *)itemInSection:(NSInteger)section withIndex:(NSInteger)index;
-(NSInteger)itemsCountInSection:(NSInteger)section;

@end
