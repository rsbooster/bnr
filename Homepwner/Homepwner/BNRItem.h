//
//  BNRItem.h
//  Homepwner
//
//  Created by Roman Solyakh on 11.11.14.
//  Copyright (c) 2014 Big Nerd Ranch. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BNRItem : NSObject

@property (nonatomic, copy) NSString *info;
@property (nonatomic, copy) NSString *serialNumber;
@property (nonatomic, assign) NSInteger price;
@property (nonatomic, strong) NSDate *dateCreated;

-(instancetype)initWithInfo:(NSString*)info andPrice:(NSInteger)price;

@end
