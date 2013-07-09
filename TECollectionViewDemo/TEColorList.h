//
//  TEColorList.h
//  TECollectionViewDemo
//
//  Created by Tim Ekl on 7/9/13.
//  Copyright (c) 2013 Tim Ekl. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TEColorList : NSObject

+ (instancetype)sharedList;

- (NSArray *)allColors;
- (UIColor *)colorAtIndex:(NSUInteger)index;
- (void)addColor:(UIColor *)color;

@end
