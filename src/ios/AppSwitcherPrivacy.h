#import <Cordova/CDV.h>

@interface ScreenPrivacy : CDVPlugin

- (void)unblock:(CDVInvokedUrlCommand*)command;
- (void)block:(CDVInvokedUrlCommand*)command;

@end
