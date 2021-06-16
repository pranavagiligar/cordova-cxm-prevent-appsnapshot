#import <Cordova/CDV.h>
#import <Cordova/CDVPlugin.h>

@interface AppSwitcherPrivacy : CDVPlugin

- (void)unblock:(CDVInvokedUrlCommand*)command;
- (void)block:(CDVInvokedUrlCommand*)command;

@end
