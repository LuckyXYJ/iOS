//
//  CustomWKWebVC.m
//  BaseProject
//
//  Created by ios on 2019/1/11.
//  Copyright © 2019 ios. All rights reserved.
//

#import "CustomWKWebVC.h"
#import <WebKit/WebKit.h>
@interface CustomWKWebVC ()<WKScriptMessageHandler,WKNavigationDelegate>
@property (nonatomic,strong) WKWebView *webView;
@end

@implementation CustomWKWebVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"JS交互";
    [self initUI];
}

- (void)leftBarBtnClicked
{
    if ([self.webView canGoBack]) {
        [self.webView goBack];
    }else {
        [super leftBarBtnClicked];
    }
    
}

- (void)initUI {
    WKWebViewConfiguration *configuration = [[WKWebViewConfiguration alloc] init];
    WKUserContentController *userController = [[WKUserContentController alloc] init];
    
    [userController addScriptMessageHandler:self name:@"jsCalledObjectC"];
    configuration.userContentController = userController;
    
    self.webView = [[WKWebView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight) configuration:configuration];
    self.webView.navigationDelegate = self;

    NSString * htmlPath = [[NSBundle mainBundle] pathForResource:@"test" ofType:@"html"];
    NSString * htmlCont = [NSString stringWithContentsOfFile:htmlPath encoding:NSUTF8StringEncoding error:nil];
    [self.webView loadHTMLString:htmlCont baseURL:nil];
    
//    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"https://www.baidu.com"]]];
    
    [self.view addSubview:self.webView];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(kScreenWidth/2.0 - 100, kScreenHeight - 200, 200, 40);
    [btn setTitle:@"调用js" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(callJSAction) forControlEvents:UIControlEventTouchUpInside];
    btn.backgroundColor = [UIColor blueColor];
    [self.view addSubview:btn];
}

-(void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler
{
    //如果是跳转一个新页面
//    if (navigationAction.targetFrame == nil) {
//        [webView loadRequest:navigationAction.request];
//    }
    
    decisionHandler(WKNavigationActionPolicyAllow);
}


#pragma mark -- WKUIDelegate
// 显示一个按钮。点击后调用completionHandler回调
- (void)webView:(WKWebView *)webView runJavaScriptAlertPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(void))completionHandler{
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:message message:nil preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
        completionHandler();
    }]];
    [self presentViewController:alertController animated:YES completion:nil];
}

// 显示两个按钮，通过completionHandler回调判断用户点击的确定还是取消按钮
- (void)webView:(WKWebView *)webView runJavaScriptConfirmPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(BOOL))completionHandler{
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:message message:nil preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        completionHandler(YES);
    }]];
    [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
        completionHandler(NO);
    }]];
    [self presentViewController:alertController animated:YES completion:nil];
    
}

// 显示一个带有输入框和一个确定按钮的，通过completionHandler回调用户输入的内容
- (void)webView:(WKWebView *)webView runJavaScriptTextInputPanelWithPrompt:(NSString *)prompt defaultText:(NSString *)defaultText initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(NSString * _Nullable))completionHandler{
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"" message:nil preferredStyle:UIAlertControllerStyleAlert];
    [alertController addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        
    }];
    [alertController addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        completionHandler(alertController.textFields.lastObject.text);
    }]];
    [self presentViewController:alertController animated:YES completion:nil];
}

//JS调用的OC回调方法
- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message{
    
    if ([message.name isEqualToString:@"jsCalledObjectC"]) {
        NSLog(@"%@",message.body);
    }
}

-(void)callJSAction {
    [self.webView evaluateJavaScript:@"ocCallJS('OC调用JS警告窗方法')" completionHandler:^(id _Nullable item, NSError * _Nullable error) {
        NSLog(@"alert");
    }];
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
