//
//  CCWebView.m
//  Chimera
//
//  Created by raven on 10/28/15.
//  Copyright © 2015 raven. All rights reserved.
//

#import "CCWebView.h"
#import "UIWebView+CCUIWebView.h"
#import "WKWebView+CCWKWebView.h"
#import "CCWebViewDelegate.h"

@interface CCWebView () <UIWebViewDelegate, WKNavigationDelegate, WKUIDelegate>

@property (nonatomic, strong) UIView <CCWebViewProvider> *webView;
@property (nonatomic, strong) UIView <WKNavigationDelegate> *navigationDelegate;
@property (nonatomic, strong) UIView <WKUIDelegate> *UIDelegate;
@property (nonatomic, assign) id <CCWebViewDelegate>delegate;

//@property (nonatomic, strong) UIView <CCWebViewJsBridge> *bridge;

@property (nonatomic) BOOL useWkWebKit;

@end

@implementation CCWebView


- (instancetype)init
{
    self = [super init];
    if (self) {
        [self initWebkit];
    }
    return self;
}

- (void)initWebkit
{
    if (NSClassFromString(@"WKWebView")) {
        _webView = [[WKWebView alloc] init];
        _useWkWebKit = YES;
    } else {
        _webView = [[UIWebView alloc] init];
        _useWkWebKit = NO;
    }
}

- (void)initWebkitWithFrame: (CGRect) bounds
{
    if (NSClassFromString(@"WKWebView")) {
        _webView = [[WKWebView alloc] initWithFrame: [self bounds]];
        _useWkWebKit = YES;
    } else {
        _webView = [[UIWebView alloc] initWithFrame: [self bounds]];
        _useWkWebKit = NO;
    }
}

#pragma mark UIWebView Delegate Methods

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    [self.delegate shouldStartDecidePolicy:request];
    return YES;
}

- (void)webViewDidStartLoad:(UIWebView *)webView
{
    
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    return;
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    return;
}

#pragma mark - WKNavigationDelegate

- (void) webView: (WKWebView *) webView decidePolicyForNavigationAction: (WKNavigationAction *) navigationAction decisionHandler: (void (^)(WKNavigationActionPolicy)) decisionHandler
{
    decisionHandler([self.delegate shouldStartDecidePolicy: [navigationAction request]]);
}

- (void) webView: (WKWebView *) webView didStartProvisionalNavigation: (WKNavigation *) navigation
{

}

- (void) webView:(WKWebView *) webView didFailProvisionalNavigation: (WKNavigation *) navigation withError: (NSError *) error
{

}

- (void) webView: (WKWebView *) webView didCommitNavigation: (WKNavigation *) navigation
{
    
}

- (void) webView: (WKWebView *) webView didFailNavigation: (WKNavigation *) navigation withError: (NSError *) error
{
    
}

- (void) webView: (WKWebView *) webView didFinishNavigation: (WKNavigation *) navigation
{
    
}

#pragma mark - WKUIDelegate

- (void)webViewDidClose:(WKWebView *)webView
{
    
}


- (void)webView:(WKWebView *)webView runJavaScriptAlertPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(void))completionHandler
{
    
}

- (void)webView:(WKWebView *)webView runJavaScriptConfirmPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(BOOL result))completionHandler
{
    
}

- (void)webView:(WKWebView *)webView runJavaScriptTextInputPanelWithPrompt:(NSString *)prompt defaultText:(nullable NSString *)defaultText initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(NSString * __nullable result))completionHandler
{
    
}

@end
