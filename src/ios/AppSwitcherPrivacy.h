#import <Cordova/CDV.h>

@interface AppSwitcherPrivacy : CDVPlugin {
    BOOL shouldBlock;
    BOOL featureEnabled;
}

- (void) unblock:(CDVInvokedUrlCommand*)command;
- (void) block:(CDVInvokedUrlCommand*)command;

@end
