In Objective-C, a subtle bug can arise from the interaction between KVO (Key-Value Observing) and memory management.  If an observer is not removed properly when it's no longer needed (e.g., when a view controller is deallocated), it can lead to crashes or unexpected behavior.  Specifically, if the observed object deallocates before the observer is removed, the observer will try to access deallocated memory when the KVO notification is triggered, resulting in a crash. This is often insidious because it might not manifest consistently during development due to the timing of events. 

Example:  

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
    [self.model removeObserver:self forKeyPath:@"someProperty"]; // Missing removal!
}
@end
```

In this example, if `-dealloc` is not correctly implemented to remove the observer, the `removeObserver` method will never get called, leading to issues. 