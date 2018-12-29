//
//  CommonMacros.h
//  BaseProject
//
//  Created by ios on 2018/12/18.
//  Copyright © 2018 ios. All rights reserved.
//

#ifndef CommonMacros_h
#define CommonMacros_h

#pragma mark - ——————— 用户相关 ————————
//登录状态改变通知
#define KNotificationLoginStateChange @"loginStateChange"

//自动登录成功
#define KNotificationAutoLoginSuccess @"KNotificationAutoLoginSuccess"

//被踢下线
#define KNotificationOnKick @"KNotificationOnKick"

//用户信息缓存 名称
#define KUserCacheName @"KUserCacheName"

//用户model缓存
#define KUserModelCache @"KUserModelCache"



#pragma mark - ——————— 网络状态相关 ————————

//网络状态变化
#define KNotificationNetWorkStateChange @"KNotificationNetWorkStateChange"


#define KMainColor  [UIColor colorWithHexRGB:@"71cde6"]
#define KBackGroundColor  [UIColor colorWithHexRGB:@"F2F4F5"]

#pragma mark --------界面常量--------------------

#define kStatusBarHeight [[UIApplication sharedApplication] statusBarFrame].size.height
#define kNavBarHeight 44.0
#define kTabBarHeight ([[UIApplication sharedApplication] statusBarFrame].size.height>20?83:49)
#define kTopHeight (kStatusBarHeight + kNavBarHeight)
#define kBotHeight ([[UIApplication sharedApplication] statusBarFrame].size.height>20?34:0)

#define kScreenWidth    [UIScreen mainScreen].bounds.size.width
#define kScreenHeight   [UIScreen mainScreen].bounds.size.height

#endif /* CommonMacros_h */
