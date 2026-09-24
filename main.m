#import <UIKit/UIKit.h>

@interface DemoViewController : UIViewController
@property(nonatomic,strong) UIView *panel;
@property(nonatomic,strong) UIButton *bubble;
@end

@implementation DemoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithWhite:0.04 alpha:1.0];

    UILabel *backgroundTitle = [[UILabel alloc] initWithFrame:CGRectMake(20, 80, self.view.bounds.size.width - 40, 80)];
    backgroundTitle.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    backgroundTitle.text = @"LOCAL iOS DEMO";
    backgroundTitle.textColor = [UIColor colorWithWhite:1 alpha:0.18];
    backgroundTitle.textAlignment = NSTextAlignmentCenter;
    backgroundTitle.font = [UIFont boldSystemFontOfSize:28];
    [self.view addSubview:backgroundTitle];

    self.bubble = [UIButton buttonWithType:UIButtonTypeSystem];
    self.bubble.frame = CGRectMake(22, 180, 58, 58);
    self.bubble.backgroundColor = [UIColor colorWithRed:0.06 green:0.35 blue:0.95 alpha:1.0];
    self.bubble.layer.cornerRadius = 29;
    [self.bubble setTitle:@"EM" forState:UIControlStateNormal];
    [self.bubble setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
    self.bubble.titleLabel.font = [UIFont boldSystemFontOfSize:18];
    [self.bubble addTarget:self action:@selector(toggleMenu) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.bubble];

    [self.bubble addGestureRecognizer:[[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(dragBubble:)]];
    [self buildPanel];
}

- (void)buildPanel {
    CGFloat width = MIN(self.view.bounds.size.width - 34, 340.0);
    self.panel = [[UIView alloc] initWithFrame:CGRectMake(18, 260, width, 310)];
    self.panel.backgroundColor = [UIColor colorWithRed:0.025 green:0.03 blue:0.055 alpha:0.97];
    self.panel.layer.cornerRadius = 20;
    self.panel.layer.borderWidth = 1.0;
    self.panel.layer.borderColor = [UIColor colorWithRed:0.15 green:0.45 blue:1 alpha:0.8].CGColor;
    [self.panel addGestureRecognizer:[[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(dragPanel:)]];

    UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(16, 14, width - 32, 28)];
    title.text = @"👑 ENACHE MARIUS OFFICIAL";
    title.textColor = UIColor.whiteColor;
    title.textAlignment = NSTextAlignmentCenter;
    title.font = [UIFont boldSystemFontOfSize:17];
    [self.panel addSubview:title];

    UILabel *subtitle = [[UILabel alloc] initWithFrame:CGRectMake(16, 44, width - 32, 22)];
    subtitle.text = @"LOCAL MENU UI DEMO";
    subtitle.textColor = [UIColor colorWithRed:0.3 green:0.65 blue:1 alpha:1];
    subtitle.textAlignment = NSTextAlignmentCenter;
    subtitle.font = [UIFont boldSystemFontOfSize:12];
    [self.panel addSubview:subtitle];

    NSArray<NSString *> *features = @[@"Test Feature A", @"Test Feature B", @"Debug Overlay"];
    for (NSInteger i = 0; i < features.count; i++) {
        CGFloat y = 88 + i * 58;
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(20, y, width - 105, 36)];
        label.text = features[i];
        label.textColor = UIColor.whiteColor;
        label.font = [UIFont systemFontOfSize:15 weight:UIFontWeightMedium];
        [self.panel addSubview:label];

        UISwitch *sw = [[UISwitch alloc] initWithFrame:CGRectMake(width - 72, y + 2, 60, 34)];
        sw.tag = 100 + i;
        [sw addTarget:self action:@selector(toggleChanged:) forControlEvents:UIControlEventValueChanged];
        [self.panel addSubview:sw];
    }

    UILabel *status = [[UILabel alloc] initWithFrame:CGRectMake(20, 268, width - 40, 26)];
    status.tag = 777;
    status.text = @"🔴 OFF";
    status.textColor = UIColor.systemRedColor;
    status.textAlignment = NSTextAlignmentCenter;
    status.font = [UIFont boldSystemFontOfSize:15];
    [self.panel addSubview:status];

    [self.view addSubview:self.panel];
}

- (void)toggleMenu { self.panel.hidden = !self.panel.hidden; }

- (void)toggleChanged:(UISwitch *)sender {
    UILabel *status = [self.panel viewWithTag:777];
    BOOL anyOn = NO;
    for (NSInteger tag = 100; tag <= 102; tag++) {
        UISwitch *sw = [self.panel viewWithTag:tag];
        if (sw.isOn) { anyOn = YES; break; }
    }
    status.text = anyOn ? @"🟢 ON" : @"🔴 OFF";
    status.textColor = anyOn ? UIColor.systemGreenColor : UIColor.systemRedColor;
}

- (void)dragBubble:(UIPanGestureRecognizer *)pan {
    CGPoint d = [pan translationInView:self.view];
    pan.view.center = CGPointMake(pan.view.center.x + d.x, pan.view.center.y + d.y);
    [pan setTranslation:CGPointZero inView:self.view];
}

- (void)dragPanel:(UIPanGestureRecognizer *)pan {
    CGPoint d = [pan translationInView:self.view];
    pan.view.center = CGPointMake(pan.view.center.x + d.x, pan.view.center.y + d.y);
    [pan setTranslation:CGPointZero inView:self.view];
}
@end

@interface AppDelegate : UIResponder <UIApplicationDelegate>
@property(nonatomic,strong) UIWindow *window;
@end

@implementation AppDelegate
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:UIScreen.mainScreen.bounds];
    self.window.rootViewController = [DemoViewController new];
    [self.window makeKeyAndVisible];
    return YES;
}
@end

int main(int argc, char * argv[]) {
    @autoreleasepool {
        return UIApplicationMain(argc, argv, nil, NSStringFromClass([AppDelegate class]));
    }
}
