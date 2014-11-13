//
//  BNRItem.m
//  Homepwner
//
//  Created by Roman Solyakh on 11.11.14.
//  Copyright (c) 2014 Big Nerd Ranch. All rights reserved.
//

#import "BNRItem.h"

@implementation BNRItem

-(instancetype)initWithInfo:(NSString *)info andPrice:(NSInteger)price
{
    self = [super init];
    if(self)
    {
        self.info = info;
        self.price = price;
        
        NSUUID *uuid = [[NSUUID alloc] init];
        self.serialNumber = [uuid UUIDString];
        
        self.dateCreated = [NSDate date];
    }
    return self;
}

-(instancetype)init
{
    return [self initWithInfo:@"" andPrice:0];
}

@end
