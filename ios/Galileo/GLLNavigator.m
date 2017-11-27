#import "GLLNavigator.h"
#import <React/UIView+React.h>
#import <React/RCTDefines.h>

@interface GLLNavigator()

@property (nonatomic, strong) UINavigationController *navigatorController;

@end

@implementation GLLNavigator

- (instancetype)initWithFrame:(CGRect)frame
{
  if ((self = [super initWithFrame:frame])) {
    self.navigatorController = [[UINavigationController alloc] initWithNavigationBarClass:nil toolbarClass:nil];
    [self addSubview:self.navigatorController.view];
  }
  return self;
}

RCT_NOT_IMPLEMENTED(- (instancetype)initWithCoder:(NSCoder *)aDecoder)

- (UIViewController *)reactViewController
{
  return self.navigatorController;
}

- (void)layoutSubviews
{
  [super layoutSubviews];
  [self reactAddControllerToClosestParent:self.navigatorController];
  self.navigatorController.view.frame = self.bounds;
}

- (void)insertReactSubview:(UIView *)subview atIndex:(NSInteger)atIndex
{
  // This is the hook from children in to our UINavigationController
  [self.navigatorController setViewControllers:@[subview.reactViewController] animated:YES];
}

@end
