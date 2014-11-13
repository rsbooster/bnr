//
//  BNRImageStore.m
//  Homepwner
//
//  Created by Роман Солях on 13.11.14.
//  Copyright (c) 2014 Big Nerd Ranch. All rights reserved.
//

#import "BNRImageStore.h"

@interface BNRImageStore ()

@property (nonatomic, strong) NSMutableDictionary *dictionary;

@end

@implementation BNRImageStore

+(instancetype)sharedStore
{
    static BNRImageStore *sharedInstance = nil;
    static dispatch_once_t token;
    dispatch_once(&token, ^{
        sharedInstance = [[BNRImageStore alloc] initPrivate];
    });
    
    return sharedInstance;
}

-(instancetype)initPrivate
{
    self = [super init];
    if(self)
    {
        _dictionary = [[NSMutableDictionary alloc] init];
    }
    return self;
}

-(void)setImage:(UIImage *)image forKey:(NSString *)key
{
    self.dictionary[key] = image;
}

-(UIImage *)imageForKey:(NSString *)key
{
    return self.dictionary[key];
}

-(void)deleteImageForKey:(NSString *)key
{
    [self.dictionary removeObjectForKey:key];
}

@end
