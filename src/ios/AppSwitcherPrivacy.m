#import "AppSwitcherPrivacy.h"
@interface AppSwitcherPrivacy() {
    CDVInvokedUrlCommand * _eventCommand;
}
@end

@implementation AppSwitcherPrivacy
- (void)pluginInitialize
{
    featureEnabled = NO;
    shouldBlock = NO;
    [[NSNotificationCenter defaultCenter]addObserver:self
                                            selector:@selector(appDidBecomeActive:)
                                                name:UIApplicationDidBecomeActiveNotification
                                              object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self
                                            selector:@selector(applicationWillResignActive:)
                                                name:UIApplicationWillResignActiveNotification
                                              object:nil];
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    if (shouldBlock) {
        self.window.backgroundColor = [UIColor clearColor];

        UIBlurEffect *blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleExtraLight];
        UIVisualEffectView *blurEffectView = [[UIVisualEffectView alloc] initWithEffect:blurEffect];
        blurEffectView.frame = self.window.bounds;
        blurEffectView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;

        blurEffectView.tag = 1234;
        blurEffectView.alpha = 0;
        [self.window addSubview:blurEffectView];
        [self.window bringSubviewToFront:blurEffectView];

        // fade in the view
        [UIView animateWithDuration:0.5 animations:^{
            blurEffectView.alpha = 1;
        }];
        featureEnabled = YES;
    }
}

- (void)appDidBecomeActive:(UIApplication *)application 
{
    if (featureEnabled) {
        NSLog(@"Hiding blur");
        // grab a reference to our custom blur view
        UIView *blurEffectView = [self.window viewWithTag:1234];

        // fade away colour view from main view
        [UIView animateWithDuration:0.5 animations:^{
            blurEffectView.alpha = 0;
        } completion:^(BOOL finished) {
            // remove when finished fading
            [blurEffectView removeFromSuperview];
        }];
        featureEnabled = NO;
    }
}

- (void)unblock:(CDVInvokedUrlCommand *)command
{
    shouldBlock = NO;
}

- (void)block:(CDVInvokedUrlCommand *)command
{
    shouldBlock = YES;
}

@end
