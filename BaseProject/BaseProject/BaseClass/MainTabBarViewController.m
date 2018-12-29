//
//  MainTabBarViewController.m
//  BaseProject
//
//  Created by ios on 2018/12/18.
//  Copyright © 2018 ios. All rights reserved.
//

#import "MainTabBarViewController.h"
#import "BaseNavigationController.h"
#import "HomePageVC.h"
#import "secondPageVC.h"
#import "DiscoverPageVC.h"
#import "MainPageVC.h"

@interface MainTabBarViewController ()

@end

@implementation MainTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self makeSubController];
}

- (void)makeSubController {
    
    BaseNavigationController *homeNav = [[BaseNavigationController alloc]initWithRootViewController:[HomePageVC new]];
    homeNav.tabBarItem.title = @"首页";
    homeNav.tabBarItem.image = [[UIImage imageNamed:@"tabbar_home"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    homeNav.tabBarItem.selectedImage = [[UIImage imageNamed:@"tabbar_home_on"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    [homeNav.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:KMainColor} forState:UIControlStateSelected];
    
    BaseNavigationController *discoverNav = [[BaseNavigationController alloc]initWithRootViewController:[SecondPageVC new]];
    discoverNav.tabBarItem.title = @"好友";
    discoverNav.tabBarItem.image = [[UIImage imageNamed:@"tabbar_friends"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    discoverNav.tabBarItem.selectedImage = [[UIImage imageNamed:@"tabbar_friends_on"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    [discoverNav.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:KMainColor} forState:UIControlStateSelected];
    
    BaseNavigationController *orderNav = [[BaseNavigationController alloc]initWithRootViewController:[DiscoverPageVC new]];
    orderNav.tabBarItem.title = @"发现";
    orderNav.tabBarItem.image = [[UIImage imageNamed:@"tabbar_find"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    orderNav.tabBarItem.selectedImage = [[UIImage imageNamed:@"tabbar_find_on"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    [orderNav.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:KMainColor} forState:UIControlStateSelected];
    
    BaseNavigationController *mineNav = [[BaseNavigationController alloc]initWithRootViewController:[MainPageVC new]];
    mineNav.tabBarItem.title = @"我的";
    mineNav.tabBarItem.image = [[UIImage imageNamed:@"tabbar_my"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    mineNav.tabBarItem.selectedImage = [[UIImage imageNamed:@"tabbar_my_on"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    [mineNav.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:KMainColor} forState:UIControlStateSelected];
    
    self.viewControllers = @[homeNav, discoverNav, orderNav, mineNav];
}

- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item {
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
