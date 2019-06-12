//
//  HomePageVC.m
//  BaseProject
//
//  Created by ios on 2018/12/19.
//  Copyright © 2018 ios. All rights reserved.
//

#import "HomePageVC.h"
#import "TestVC.h"

@interface HomePageVC ()

@end

@implementation HomePageVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"首页";
    [self creatContentView];
}

- (void)creatContentView {
    
    UIButton *btn = [[UIButton alloc]init];
    btn.frame = CGRectMake(kScreenWidth/2.0 - 100 , 200, 200, 50);
    btn.backgroundColor = [UIColor blueColor];
    [btn setTitle:@"点我" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(clickButton) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
    
    UILabel *phoneLbl = [[UILabel alloc] initWithFrame:CGRectMake(18, 270, kScreenWidth - 36, 40)];
    phoneLbl.font = [UIFont systemFontOfSize:14];
    phoneLbl.userInteractionEnabled = YES;
    NSMutableAttributedString *phoneStr = [[NSMutableAttributedString alloc] initWithString:@"客服电话： 4000-717-100"];
    [phoneStr addAttribute:NSForegroundColorAttributeName value:[UIColor blueColor] range:NSMakeRange(5,phoneStr.length-5)];
    [phoneStr addAttribute:NSForegroundColorAttributeName value:[UIColor blueColor] range:NSMakeRange(0,5)];
    
    NSTextAttachment *attchImage = [[NSTextAttachment alloc] init];
    // 表情图片
    attchImage.image = [UIImage imageNamed:@"login_phone_call"];
    // 设置图片大小
    attchImage.bounds = CGRectMake(0, 0, 12.25, 13);
    NSAttributedString *stringImage = [NSAttributedString attributedStringWithAttachment:attchImage];
    [phoneStr insertAttributedString:stringImage atIndex:0];
    
    phoneLbl.attributedText = phoneStr;
    phoneLbl.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:phoneLbl];
    [phoneLbl addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(phoneSelected)]];
}

- (void)phoneSelected {
    
}

-(void)clickButton {
    TestVC *testVC = [[TestVC alloc]init];
    [self.navigationController pushViewController:testVC animated:YES];
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
