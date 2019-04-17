//
//  AppDelegate.m
//  CloudLinkMeetingDemo
//
//  Created by zhangjianfang on 2019/2/22.
//  Copyright © 2019年 huawei. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    self.window = [[UIWindow alloc] init];
    ViewController *ctrl = [[ViewController alloc] init];
    UINavigationController *navCtrl = [[UINavigationController alloc] initWithRootViewController:ctrl];
    self.window.rootViewController = navCtrl;
    [self.window makeKeyAndVisible];
    
    
//    clm = [[CloudLinkMeeting alloc] init];
//    for (UIWindow *window in [UIApplication sharedApplication].windows)
//    {
//        NSLog(@"zhangjianfang window is:%@", window);
//        NSLog(@"zhangjianfang window level is:%f", window.windowLevel);
//    }
//    self.window = [[UIWindow alloc] init];
//    self.window.rootViewController = [[UIViewController alloc] init];
//    [clm clm_init_syn];
//    clmLoginParam *loginParam = [[clmLoginParam alloc] init];
//    loginParam.serverAddress = @"10.174.10.63";
//    loginParam.serverPort = 8443;
//    loginParam.account = @"zjf01@zqp.com";
//    loginParam.password = @"1qaz!QAZ";
//    [clm clm_runAndLogin:loginParam completionBlock:nil];
    //[UIApplication sharedApplication].keyWindow.hidden = YES;
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
