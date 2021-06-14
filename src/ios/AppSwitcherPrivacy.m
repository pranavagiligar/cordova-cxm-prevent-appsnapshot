#import "AppSwitcherPrivacy.h"
#import "AppDelegate.h"

@interface AppSwitcherPrivacy() {
    CDVInvokedUrlCommand * _eventCommand;
}
@end

@interface AppDelegate (AppSwitcherPrivacy) {}

@end

@implementation AppDelegate (AppSwitcherPrivacy)
BOOL shouldBlock = NO;
BOOL featureEnabled = NO;

- (void)applicationWillResignActive:(UIApplication *)application {
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

- (void)applicationDidBecomeActive:(UIApplication *)application {
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
    CDVPluginResult* pluginResult = nil;
}

- (void)block:(CDVInvokedUrlCommand *)command
{
    shouldBlock = YES;
    CDVPluginResult* pluginResult = nil;
}

@end
