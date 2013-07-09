//
//  TEZigzagCollectionViewLayout.m
//  TECollectionViewDemo
//
//  Created by Tim Ekl on 7/9/13.
//  Copyright (c) 2013 Tim Ekl. All rights reserved.
//

#import "TEZigzagCollectionViewLayout.h"

#define SIZE 50.0f
#define OFFSET 10.0f

@implementation TEZigzagCollectionViewLayout

- (CGSize)collectionViewContentSize;
{
    return (CGSize){.width = self.collectionView.bounds.size.width, .height = [self.collectionView numberOfItemsInSection:0] * OFFSET};
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath;
{
    UICollectionViewLayoutAttributes *attributes = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    attributes.frame = [self frameForItemAtItemIndex:indexPath.item];
    attributes.zIndex = indexPath.item;
    return attributes;
}

- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect;
{
    NSMutableArray *result = [NSMutableArray array];
    
    for (NSInteger itemIndex = 0; itemIndex < [self.collectionView numberOfItemsInSection:0]; itemIndex++) {
        if (CGRectIntersectsRect(rect, [self frameForItemAtItemIndex:itemIndex])) {
            [result addObject:[self layoutAttributesForItemAtIndexPath:[NSIndexPath indexPathForItem:itemIndex inSection:0]]];
        }
    }
    
    return result;
}

- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds;
{
    return YES;
}

- (UICollectionViewLayoutAttributes *)initialLayoutAttributesForAppearingItemAtIndexPath:(NSIndexPath *)itemIndexPath;
{
    return [self layoutAttributesForItemAtIndexPath:itemIndexPath];
}

- (UICollectionViewLayoutAttributes *)finalLayoutAttributesForDisappearingItemAtIndexPath:(NSIndexPath *)itemIndexPath;
{
    return [self layoutAttributesForItemAtIndexPath:itemIndexPath];
}

#pragma mark - Private

- (CGRect)frameForItemAtItemIndex:(NSInteger)itemIndex;
{
    BOOL reversed = ((itemIndex / [self _itemsFittingAcrossCollectionView]) % 2) == 1;
    NSInteger adjustedIndex = itemIndex % [self _itemsFittingAcrossCollectionView];
    CGFloat x = adjustedIndex * OFFSET;
    if (reversed)
        x = [self collectionViewContentSize].width - x - SIZE;
    
    return (CGRect){
        .origin = (CGPoint){.x = x, .y = itemIndex * OFFSET},
        .size = (CGSize){.width = SIZE, .height = SIZE}
    };
}

- (NSUInteger)_itemsFittingAcrossCollectionView;
{
    return ([self collectionViewContentSize].width - SIZE) / OFFSET + 1;
}

@end
