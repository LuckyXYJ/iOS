//
//  BaseViewController.m
//  BaseProject
//
//  Created by ios on 2018/12/18.
//  Copyright © 2018 ios. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

- (instancetype)init {
    
    //必须要先调用父类的 init方法，初始化父类 ,且必须要返回给当前的 self对象，表示初始化 self对象
    if(self = [super init]){
        
        
        Class class = [self class];
        if (class == NSClassFromString(@"HomePageVC") || class == NSClassFromString(@"MainPageVC") || class == NSClassFromString(@"SecondPageVC") || class == NSClassFromString(@"DiscoverPageVC")) {
            self.hidesBottomBarWhenPushed = NO;
        }else{
            self.hidesBottomBarWhenPushed = YES;
        }
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = KBackGroundColor;
    
//    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
//    self.navigationController.navigationBar.tintColor = [UIColor blackColor];
    
    [self showLeftBackButton];
//    self.navigationController.interactivePopGestureRecognizer.enabled = YES;
//    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)])
//    {
//        self.navigationController.interactivePopGestureRecognizer.delegate = nil;
//    }
}



- (void)showLeftBackButton {
    
    if (self.navigationController.viewControllers.count > 1) {
//        UIButton * leftBtn = [UIButton buttonWithType:UIButtonTypeSystem];
//        leftBtn.frame = CGRectMake(0, 0, 12,44);
//        UIImage *img = [[UIImage imageNamed:@"nav_back_black"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
//        [leftBtn setImage:img forState:UIControlStateNormal];
//        [leftBtn addTarget:self action:@selector(leftBarBtnClicked) forControlEvents:UIControlEventTouchUpInside];
//        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:leftBtn];
        
        UIImage *img = [[UIImage imageNamed:@"nav_back_black"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        UIBarButtonItem * leftItem = [[UIBarButtonItem alloc] initWithImage:img style:UIBarButtonItemStyleDone target:self action:@selector(leftBarBtnClicked)];
        self.navigationItem.leftBarButtonItem = leftItem;
    }
}


- (void)leftBarBtnClicked
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark --收起键盘
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
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
