//
//  DRWindowController.h
//  DRWindows
//
//  Created by Danny Ricciotti on 8/9/13.
//  Copyright (c) 2013 Danny Ricciotti. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^DRWindowCompletionBlock)();

@interface DRWindowController : UIViewController

// Adding new views
- (void)addWindowView:(UIView *)view atIndex:(NSInteger)index;
- (void)addWindowController:(UIViewController *)controller atIndex:(NSInteger)index;
- (void)addWindowController:(UIViewController *)controller atIndex:(NSInteger)index withCompletion:(DRWindowCompletionBlock)handler options:(NSInteger)options; // todo:make a typedef
- (void)addWindowController:(UIViewController *)controller atIndex:(NSInteger)index withCompletion:(DRWindowCompletionBlock)handler;

// Removing views
- (void)removeWindowView:(UIView *)view;
- (void)removeWindowController:(UIViewController *)controller;

@end
