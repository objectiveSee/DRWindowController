DRWindowController
=========

*sometimes you just want to put things on top of things*

An Objective-C / Cocoa Touch class for managing a vertical "stack" of UIViews and UIViewControllers. This is a useful alternative to adding additional UIWindows to an application or having an unorganized approach to adding subviews to the main UIWindow. The Z-position of views can be specified to let you arrange which views are in front of others.


## Example ##

### Setting your root view controller
```objective-C
DRWindowController *windowController = [[DRWindowController alloc] initWithNibName:nil bundle:nil];
self.window.rootViewController = windowController;
[self.window makeKeyAndVisible];

// Add root controller to window manager
UIViewController *mainViewController = /* your main controller */
[windowController addWindowController:familyController atIndex:1];
```

### Adding custom UI above main UI
```objective-C

// add newcontroller to window controller
UIViewController *partialScreenModalController = /* whatever */
[windowController addWindowController:partialScreenModalController atIndex:2 withCompletion:nil];


// add new UIView to the window
UIView *customAlertView = /* as you will */
[windowController addWindowView:customAlertView atIndex:100];

```

## Interface ##

```objective-C
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
- (void)removeAllControllers;

@end
```

See https://github.com/objectiveSee/DRWindowController/blob/master/DRWindows/DRWindows/DRWindows/DRWindowController.h
