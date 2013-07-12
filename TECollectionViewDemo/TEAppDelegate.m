//
//  TEAppDelegate.m
//  TECollectionViewDemo
//
//  Created by Tim Ekl on 7/9/13.
//  Copyright (c) 2013 Tim Ekl. All rights reserved.
//

#import "TEAppDelegate.h"

#import "TECollectionViewController.h"
#import "TEColorList.h"
#import "TERandomSizeCollectionViewController.h"
#import "TEZigzagCollectionViewLayout.h"
#import "UIColor+TEExtensions.h"

#define DEBUG_COLOR_MULTIPLIER 10

@interface TEAppDelegate ()

@property (nonatomic, strong) UITabBarController *tabBarController;

@end

@interface TECollectionViewInformation : NSObject

@property (nonatomic, assign) Class controllerClass;
@property (nonatomic, assign) Class layoutClass;
@property (nonatomic, copy) NSString *title;

+ (instancetype)informationWithController:(Class)controllerClass layout:(Class)layoutClass title:(NSString *)title;
- (UINavigationController *)wrappedController;

@end

@implementation TEAppDelegate

- (NSArray *)controllerInfo;
{
    return @[ [TECollectionViewInformation informationWithController:[TECollectionViewController class] layout:[UICollectionViewFlowLayout class] title:@"Basic"],
              [TECollectionViewInformation informationWithController:[TERandomSizeCollectionViewController class] layout:[UICollectionViewFlowLayout class] title:@"Random"],
              [TECollectionViewInformation informationWithController:[TECollectionViewController class] layout:[TEZigzagCollectionViewLayout class] title:@"Zigzag"] ];
}

- (void)addRandomColor;
{
    for (NSUInteger i = 0; i < DEBUG_COLOR_MULTIPLIER; i++) {
        NSIndexPath *newIndexPath = [NSIndexPath indexPathForItem:[[[TEColorList sharedList] allColors] count] inSection:0];
        [[TEColorList sharedList] addColor:[UIColor randomOpaqueColor]];
        
        UINavigationController *navController = (UINavigationController *)[self.tabBarController selectedViewController];
        UICollectionViewController *collectionViewController = [navController childViewControllers][0];
        
        [[collectionViewController collectionView] insertItemsAtIndexPaths:@[ newIndexPath ]];
    }
}

#pragma mark - UIApplicationDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    NSMutableArray *controllers = [NSMutableArray arrayWithCapacity:[[self controllerInfo] count]];
    [[self controllerInfo] enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        NSParameterAssert([obj isKindOfClass:[TECollectionViewInformation class]]);
        [controllers addObject:[(TECollectionViewInformation *)obj wrappedController]];
    }];
    
    self.tabBarController = [[UITabBarController alloc] init];
    [self.tabBarController setViewControllers:controllers animated:NO];
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    self.window.rootViewController = self.tabBarController;
    [self.window makeKeyAndVisible];
    
    return YES;
}

@end

@implementation TECollectionViewInformation

+ (instancetype)informationWithController:(Class)controllerClass layout:(Class)layoutClass title:(NSString *)title;
{
    TECollectionViewInformation *result = [[self alloc] init];
    result.controllerClass = controllerClass;
    result.layoutClass = layoutClass;
    result.title = title;
    return result;
}

- (UINavigationController *)wrappedController;
{
    UICollectionViewController *collectionViewController = [[self.controllerClass alloc] initWithCollectionViewLayout:[[self.layoutClass alloc] init]];
    collectionViewController.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd
                                                                                                               target:(TEAppDelegate *)[[UIApplication sharedApplication] delegate]
                                                                                                               action:@selector(addRandomColor)];
    collectionViewController.title = self.title;
    
    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:collectionViewController];
    return navController;
}

@end
