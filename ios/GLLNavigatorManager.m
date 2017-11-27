#import <React/RCTBridgeModule.h>
#import "GLLNavigatorManager.h"
#import "GLLNavigator.h"

@implementation GLLNavigatorManager

RCT_EXPORT_MODULE()

- (UIView *)view
{
  return [[GLLNavigator alloc] init];
}

@end
