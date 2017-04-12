//
//  AppDelegate.m
//  mrenApp
//
//  Created by zhouen on 16/12/1.
//  Copyright © 2016年 zhouen. All rights reserved.
//

#import "AppDelegate.h"
#import "MEUser.h"
#import <SMS_SDK/SMSSDK.h>
#import <Bugly/Bugly.h>
#import <UMSocialCore/UMSocialCore.h>
#import "MEBaseNavigationController.h"
#import "TabBarViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [self p_setupWindow];
    [self p_registerApp];
    [self p_firstRequest];
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

// 支持所有iOS系统
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    BOOL result = [[UMSocialManager defaultManager] handleOpenURL:url];
    if (!result) {
        // 其他如支付等SDK的回调
    }
    return result;
}


-(UIInterfaceOrientationMask)application:(UIApplication *)application supportedInterfaceOrientationsForWindow:(UIWindow *)window {
    if (_allowRotation) {
        return UIInterfaceOrientationMaskAllButUpsideDown;
    }
    //竖屏
    return UIInterfaceOrientationMaskPortrait;
}



#pragma mark Window
- (void)p_setupWindow {
    _window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    _window.backgroundColor = [UIColor whiteColor];
    TabBarViewController *rootVc = [[TabBarViewController alloc] init];
    _window.rootViewController = rootVc;
    [_window makeKeyAndVisible];
}

#pragma mark 注册第三方 appKey
- (void)p_registerApp {
    //mob短信
    [SMSSDK registerApp:kMobSMSAppKey withSecret:kMobSMSAppSecret];
    
    //bugly
    [Bugly startWithAppId:kBuglyAppID];
    
    //友盟
    [[UMSocialManager defaultManager] setUmSocialAppkey:kUMAppKey];
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_Sina appKey:kSinaAppKey  appSecret:kSinaAppSecret redirectURL:kSinaRedirectURL];
    
    
}

#pragma mark 启动需要的网络请求
- (void)p_firstRequest {
    //监听网络
    [HttpRequest shareInstance];
    
    //请求用户版本信息
    [MEAppVersion requestAppVersion];
}



@end

