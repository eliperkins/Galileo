#import <React/RCTBridgeModule.h>
#import <React/RCTUIManager.h>

#import "GLLViewManager.h"
#import "GLLView.h"

@interface GLLViewManager()

@property (nonatomic, strong) UIViewController *viewController;

@end

@implementation GLLViewManager

- (instancetype)init
{
  self = [super init];
  if (self) {
    self.viewController = [[UIViewController alloc] init];
  }
  return self;
}

RCT_EXPORT_MODULE()

- (UIView *)view
{
  return self.viewController.view;
}

RCT_EXPORT_METHOD(pushOnViewWithTag:(nonnull NSNumber *)reactTag
                  nextViewTag:(nonnull NSNumber *)nextViewTag
                  callback:(RCTResponseSenderBlock)callback)
{
  [self.bridge.uiManager addUIBlock:
   ^(__unused RCTUIManager *uiManager, NSDictionary<NSNumber *, UIView *> *viewRegistry) {

     UIView *view = viewRegistry[reactTag];
     UIView *nextView = viewRegistry[nextViewTag];
     UIViewController *viewController = view.reactViewController;
     UIViewController *nextViewController = nextView.reactViewController;
     [viewController.navigationController pushViewController:nextViewController animated:YES];
     callback(@[]);
   }];
}



@end
