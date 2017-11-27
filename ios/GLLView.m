#import <React/UIView+React.h>
#import "GLLView.h"

@interface GLLView ()

@property (nonatomic, strong) UIViewController *viewController;

@end

@implementation GLLView

- (instancetype)initWithFrame:(CGRect)frame
{
  if ((self = [super initWithFrame:frame])) {
    self.viewController = [[UIViewController alloc] initWithNibName:nil bundle:nil];
    [self addSubview:self.viewController.view];
  }
  return self;
}

- (UIViewController *)reactViewController
{
  return self.viewController;
}

- (void)dealloc
{
  [self.viewController removeFromParentViewController];
}

- (void)layoutSubviews
{
  [super layoutSubviews];
  [self reactAddControllerToClosestParent:self.viewController];
  self.viewController.view.frame = self.bounds;
}

@end
