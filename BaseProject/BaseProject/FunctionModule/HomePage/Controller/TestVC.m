//
//  TestVC.m
//  BaseProject
//
//  Created by ios on 2018/12/20.
//  Copyright © 2018 ios. All rights reserved.
//

#import "TestVC.h"

@interface TestVC ()

@end

@implementation TestVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"测试";
}

-(BOOL)navigationShouldPopOnBackButton {
    
    return NO;
}

- (void)leftBarBtnClicked {
    NSLog(@"返回了啊");
    [super leftBarBtnClicked];
    
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
