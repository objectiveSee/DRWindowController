<img src="https://raw.githubusercontent.com/objectiveSee/DRWindowController/master/GitHub%20Resources/splashimage.png" alt="DRWindowController" title="DRWindowController">

*sometimes you just want to put things on top of things*

An Objective-C / Cocoa Touch class for managing a vertical "stack" of UIViews and UIViewControllers in the Z-dimension. This is a useful alternative to adding additional UIWindows to an application or having an unorganized approach to adding subviews to the main UIWindow. The Z-position of views can be specified to let you arrange which views are in front of others.

`DRWindowController` takes care of everything under the hood for adding UIViewControllers by calling `addChildViewController:` and `addSubView:` for you. 

### Installation with CocoaPods

[CocoaPods](http://cocoapods.org) is a dependency manager for Objective-C, which automates and simplifies the process of using 3rd-party libraries like AFNetworking in your projects. See the ["Getting Started" guide for more information](https://github.com/AFNetworking/AFNetworking/wiki/Getting-Started-with-AFNetworking).

```ruby
pod 'DRWindowController', '~> 1.0.3'
```

## Show me what this magic is! ##

### Setting your root view controller

The easiest way to use this library is to set your app's rootViewController to be your own custom subclass of `DRWindowController`.  Then, it is very simple to add new view controllers or views.  You probably want to add your app's main controller in AppDidFinishLaunching.


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
