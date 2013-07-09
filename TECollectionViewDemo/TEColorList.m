//
//  TEColorList.m
//  TECollectionViewDemo
//
//  Created by Tim Ekl on 7/9/13.
//  Copyright (c) 2013 Tim Ekl. All rights reserved.
//

#import "TEColorList.h"

@interface TEColorList ()

@property (nonatomic, strong) NSMutableArray *colors;

@end

@implementation TEColorList

+ (instancetype)sharedList;
{
    static TEColorList *_sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedInstance = [[TEColorList alloc] init];
    });
    return _sharedInstance;
}

- (id)init;
{
    if (!(self = [super init]))
        return nil;
    
    _colors = [[NSMutableArray alloc] init];
    
    return self;
}

- (NSArray *)allColors;
{
    return [self.colors copy];
}

- (UIColor *)colorAtIndex:(NSUInteger)index;
{
    return self.colors[index];
}

- (void)addColor:(UIColor *)color;
{
    [self.colors addObject:color];
}

@end
