#import <Cordova/CDV.h>
#import <Cordova/CDVPlugin.h>

@interface AppSwitcherPrivacy : CDVPlugin {
    BOOL shouldBlock;
    BOOL featureEnabled;
}

- (void)unblock:(CDVInvokedUrlCommand*)command;
- (void)block:(CDVInvokedUrlCommand*)command;

@end
