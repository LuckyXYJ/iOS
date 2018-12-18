//
//  AppDelegate+AppService.m
//  BaseProject
//
//  Created by ios on 2018/12/18.
//  Copyright © 2018 ios. All rights reserved.
//

#import "AppDelegate+AppService.h"
#import "LoginViewController.h"

@implementation AppDelegate (AppService)

#pragma mark ————— 初始化服务 —————
-(void)initService{
    //注册登录状态监听
//    [[NSNotificationCenter defaultCenter] addObserver:self
//                                             selector:@selector(loginStateChange:)
//                                                 name:KNotificationLoginStateChange
//                                               object:nil];
//
//    //网络状态监听
//    [[NSNotificationCenter defaultCenter] addObserver:self
//                                             selector:@selector(netWorkStateChange:)
//                                                 name:KNotificationNetWorkStateChange
//                                               object:nil];
}

#pragma mark ————— 初始化window —————
-(void)initWindow{
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    [[UIButton appearance] setExclusiveTouch:YES];

    if (@available(iOS 11.0, *)){
        [[UIScrollView appearance] setContentInsetAdjustmentBehavior:UIScrollViewContentInsetAdjustmentNever];
    }
}


#pragma mark ————— 初始化用户系统 —————
-(void)initUserManager{

    self.mainTabBar = [MainTabBarViewController new];
    self.window.rootViewController = self.mainTabBar;
}

+ (AppDelegate *)shareAppDelegate{
    return (AppDelegate *)[[UIApplication sharedApplication] delegate];
}


-(UIViewController *)getCurrentVC{
    
    UIViewController *result = nil;
    
    UIWindow * window = [[UIApplication sharedApplication] keyWindow];
    if (window.windowLevel != UIWindowLevelNormal)
    {
        NSArray *windows = [[UIApplication sharedApplication] windows];
        for(UIWindow * tmpWin in windows)
        {
            if (tmpWin.windowLevel == UIWindowLevelNormal)
            {
                window = tmpWin;
                break;
            }
        }
    }
    
    UIView *frontView = [[window subviews] objectAtIndex:0];
    id nextResponder = [frontView nextResponder];
    
    if ([nextResponder isKindOfClass:[UIViewController class]])
        result = nextResponder;
    else
        result = window.rootViewController;
    
    return result;
}

-(UIViewController *)getCurrentUIVC
{
    UIViewController  *superVC = [self getCurrentVC];
    
    if ([superVC isKindOfClass:[UITabBarController class]]) {
        
        UIViewController  *tabSelectVC = ((UITabBarController*)superVC).selectedViewController;
        
        if ([tabSelectVC isKindOfClass:[UINavigationController class]]) {
            
            return ((UINavigationController*)tabSelectVC).viewControllers.lastObject;
        }
        return tabSelectVC;
    }else
        if ([superVC isKindOfClass:[UINavigationController class]]) {
            
            return ((UINavigationController*)superVC).viewControllers.lastObject;
        }
    return superVC;
}

@end
