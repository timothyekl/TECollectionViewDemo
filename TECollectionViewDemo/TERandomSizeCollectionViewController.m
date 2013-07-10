//
//  TERandomSizeCollectionViewController.m
//  TECollectionViewDemo
//
//  Created by Tim Ekl on 7/9/13.
//  Copyright (c) 2013 Tim Ekl. All rights reserved.
//

#import "TERandomSizeCollectionViewController.h"

@interface TERandomSizeCollectionViewController () <UICollectionViewDelegateFlowLayout>

@end

@implementation TERandomSizeCollectionViewController

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath;
{
    return (CGSize){.width = 50.0f + arc4random_uniform(50), .height = 50.0f + arc4random_uniform(50)};
}

@end
