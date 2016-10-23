//
//  LTWebViewController.m
//  BuDeJie
//
//  Created by Lenhulk on 16/10/23.
//  Copyright © 2016年 Lenhulk. All rights reserved.
//

#import "LTWebViewController.h"
#import <WebKit/WebKit.h>

@interface LTWebViewController ()
@property (weak, nonatomic) IBOutlet UIView *containerView;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *backItem;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *forwardItem;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *refreshItem;
@property (weak, nonatomic) IBOutlet UIProgressView *progressView;
@property (nonatomic, weak) WKWebView *webView;
@end

@implementation LTWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    WKWebView *webView = [[WKWebView alloc] initWithFrame:CGRectMake(0, 0, KScreenW, KScreenH)];
    self.webView = webView;
    [self.containerView addSubview:webView];
    
    //展示网页
    NSURLRequest *request = [NSURLRequest requestWithURL:_url];
    [webView loadRequest:request];
    
    //监听按钮是否可点击
    [webView addObserver:self forKeyPath:@"canGoBack" options:NSKeyValueObservingOptionNew context:nil];
    [webView addObserver:self forKeyPath:@"canGoForward" options:NSKeyValueObservingOptionNew context:nil];
    
    //监听进度条
    [webView addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew context:nil];
    
    //监听标题
    [webView addObserver:self forKeyPath:@"title" options:NSKeyValueObservingOptionNew context:nil];
}

// 只要监听属性有新值就会调用
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context{
    
    self.backItem.enabled = _webView.canGoBack;
    self.forwardItem.enabled = _webView.canGoForward;
    
    self.progressView.progress = _webView.estimatedProgress;
    self.progressView.hidden = _progressView.progress >= 1;
    
    self.title = _webView.title;
}

//界面跳转要销毁监听对象
- (void)dealloc{
    [_webView removeObserver:self forKeyPath:@"canGoBack"];
    [_webView removeObserver:self forKeyPath:@"canGoForward"];
    [_webView removeObserver:self forKeyPath:@"estimatedProgress"];
    [_webView removeObserver:self forKeyPath:@"title"];
}

#pragma mark - TabBar三个方法：前进 后退 刷新

- (IBAction)goBack:(id)sender {
    [_webView goBack];
}

- (IBAction)goForward:(id)sender {
    [_webView goForward];
}

- (IBAction)reload:(id)sender {
    [_webView reload];
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
