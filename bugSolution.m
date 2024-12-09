```objectivec
@interface MyViewController : UIViewController
@property (nonatomic, strong) MyModel *model;
@end

@implementation MyViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.model addObserver:self forKeyPath:@"someProperty" options:NSKeyValueObservingOptionNew context:NULL];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    // Handle changes here
}

- (void)dealloc {
    [self.model removeObserver:self forKeyPath:@"someProperty"]; // Correctly removing the observer
}
@end
```

This corrected version reliably removes the observer in `-dealloc`, preventing the memory management error.