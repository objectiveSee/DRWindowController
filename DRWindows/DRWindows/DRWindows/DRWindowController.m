//
//  DRWindowController.m
//  DRWindows
//
//  Created by Danny Ricciotti on 8/9/13.
//  Copyright (c) 2013 Danny Ricciotti. All rights reserved.
//

#import "DRWindowController.h"

@interface DRWindowController()
@property (nonatomic, strong) NSMutableSet *controllers;
@property (nonatomic, strong) NSMutableSet *completionHandlers;

@property (nonatomic, strong) UIImageView *alphaView;

@end

@implementation DRWindowController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.controllers = [NSMutableSet new];
        self.completionHandlers = [NSMutableSet new];
     }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor blackColor];
}


#pragma mark - Public

- (void)addWindowView:(UIView *)view atIndex:(NSInteger)index
{
    [self.view insertSubview:view atIndex:index];
}

- (void)addWindowController:(UIViewController *)controller atIndex:(NSInteger)index
{
    [self addWindowController:controller atIndex:index withCompletion:nil];
}

- (void)addWindowController:(UIViewController *)controller atIndex:(NSInteger)index withCompletion:(DRWindowCompletionBlock)handler;
{
    [self addWindowController:controller atIndex:index withCompletion:handler options:0];
}

- (void)addWindowController:(UIViewController *)controller atIndex:(NSInteger)index withCompletion:(DRWindowCompletionBlock)handler options:(NSInteger)options
{
    NSCAssert([NSThread isMainThread], @"Require main thread");
    NSParameterAssert(controller);
    
    // options
    // TODO: add more options
//    if ( options && index >= 1) {
//        // blur all background views
//        NSParameterAssert(self.alphaView == nil);
//        UIImage *backgroundImage = [UIView imageWithView:self.view];
//        self.alphaView = [[UIImageView alloc] initWithImage:backgroundImage];
//        [self addWindowView:self.alphaView atIndex:index-1];
//        
//        self.alphaView.alpha = 0.5;
//        [self _setViewsBelowIndexHidden:index-1];
//    }
    
    if ( self.controllers.count != 0 ) {
        [self presentViewController:controller animated:YES completion:^{
            if ( handler ) {
                handler();
            }
        }];
        
    } else {
        [self addChildViewController:controller];
        [self addWindowView:controller.view atIndex:index];
    }
    
//    [self addChildViewController:controller];
//    [self addWindowView:controller.view atIndex:index];
//
    [self.controllers addObject:controller];
//
//    [self _addCompletionHandler:handler forController:controller];
}

- (void)removeWindowView:(UIView *)view
{
    [view removeFromSuperview];
}

- (void)removeWindowController:(UIViewController *)controller
{
    if([self.controllers containsObject:controller]) {
        [controller removeFromParentViewController];
        [self.controllers removeObject:controller];
        
        [self removeWindowView:controller.view];
        
        DRWindowCompletionBlock handler = [self _consumeCompletionBlockForController:controller];
        if ( handler ) {
            handler();
        }
    }
    else {
        NSParameterAssert(nil);
        NSLog(@"WARNING: Shouldnt remove that which has not been added");
    }
}

#pragma mark - Private

- (void)_addCompletionHandler:(DRWindowCompletionBlock)handler forController:(UIViewController *)controller
{
    if ( handler ) {
        NSParameterAssert(controller);
        NSDictionary *dict = @{@"handler": handler, @"controller": controller};
        [self.completionHandlers addObject:dict];
    }
}

- (DRWindowCompletionBlock)_consumeCompletionBlockForController:(UIViewController *)controller
{
    __block NSDictionary *match = nil;
    [self.completionHandlers enumerateObjectsUsingBlock:^(NSDictionary *obj, BOOL *stop) {
        UIViewController *vc = [obj objectForKey:@"controller"];
        if ( [vc isEqual:controller])
        {
            match = obj;
            *stop = YES;
        }
    }];
    
    if ( match ) {
        [self.completionHandlers removeObject:match];
        return [match objectForKey:@"handler"];
    }
    return nil;
}

- (NSInteger)_highestSubviewIndex
{
    // todo: optimize
    __block NSInteger highest = 0;
    
    [self.view.subviews enumerateObjectsUsingBlock:^(UIView *obj, NSUInteger idx, BOOL *stop) {
        if ( idx > highest ) {
            highest = idx;
        }
    }];
    
    return highest;
}

- (void)_setViewsBelowIndexHidden:(NSInteger)index
{
    [self.view.subviews enumerateObjectsUsingBlock:^(UIView *obj, NSUInteger idx, BOOL *stop) {
        if ( idx < index ) {
            obj.hidden = YES;
        }
    }];
}

- (void)_setViewsVisible
{
    [self.view.subviews enumerateObjectsUsingBlock:^(UIView *obj, NSUInteger idx, BOOL *stop) {
        obj.hidden = NO;
    }];
}

@end
