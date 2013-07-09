//
//  UIColor+TEExtensions.m
//  TECollectionViewDemo
//
//  Created by Tim Ekl on 7/9/13.
//  Copyright (c) 2013 Tim Ekl. All rights reserved.
//

#import "UIColor+TEExtensions.h"

@implementation UIColor (TEExtensions)

+ (UIColor *)randomOpaqueColor;
{
    CGFloat red = (float)arc4random_uniform(256) / 256.0f;
    CGFloat green = (float)arc4random_uniform(256) / 256.0f;
    CGFloat blue = (float)arc4random_uniform(256) / 256.0f;
    return [UIColor colorWithRed:red green:green blue:blue alpha:1.0f];
}

+ (UIColor *)opaqueColorForObject:(id)anObject;
{
    CGFloat red = (float)((((NSUInteger)anObject) >> 0) & 0xff) / 256.0f;
    CGFloat green = (float)((((NSUInteger)anObject) >> 8) & 0xff) / 256.0f;
    CGFloat blue = (float)((((NSUInteger)anObject) >> 16) & 0xff) / 256.0f;
    return [UIColor colorWithRed:red green:green blue:blue alpha:1.0f];
}

@end
