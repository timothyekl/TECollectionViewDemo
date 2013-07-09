//
//  TECollectionViewController.m
//  TECollectionViewDemo
//
//  Created by Tim Ekl on 7/9/13.
//  Copyright (c) 2013 Tim Ekl. All rights reserved.
//

#import "TECollectionViewController.h"

#import "TEColorList.h"

static NSString * const TEDefaultCollectionViewCellIdentifier = @"Cell";

@interface TECollectionViewController ()

@end

@implementation TECollectionViewController

- (void)viewDidLoad;
{
    [super viewDidLoad];
    
    self.collectionView.backgroundColor = [UIColor whiteColor];
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:TEDefaultCollectionViewCellIdentifier];
}

- (void)viewWillAppear:(BOOL)animated;
{
    [super viewWillAppear:animated];
    
    [self.collectionView reloadData];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView;
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section;
{
    return [[[TEColorList sharedList] allColors] count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath;
{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:TEDefaultCollectionViewCellIdentifier forIndexPath:indexPath];
    cell.backgroundColor = [[TEColorList sharedList] colorAtIndex:indexPath.item];
    return cell;
}

@end
