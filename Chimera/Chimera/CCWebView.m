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

@interface CCWebView () <UIWebViewDelegate, WKNavigationDelegate, WKUIDelegate>

@property (nonatomic, strong) UIView <CCWebViewProvider> *webView;

//@property (nonatomic, strong) UIView <CCWebViewJsBridge> *bridge;

@property (nonatomic) BOOL useWkWebView;

@end

@implementation CCWebView


- (instancetype)init
{
    self = [super init];
    if (self) {
        [self initWebkitWithFrame:[self bounds]];
    }
    return self;
}

- (instancetype) initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initWebkitWithFrame:frame];
    }
    return self;
}

- (void)initWebkitWithFrame: (CGRect) bounds
{
    if (NSClassFromString(@"WKWebView")) {
        WKWebView *wkwebview = [[WKWebView alloc] initWithFrame: bounds];
        _webView = wkwebview;
        [self addSubview:_webView];
        _useWkWebView = YES;
        
        [wkwebview addObserver:self forKeyPath:@"title" options:NSKeyValueObservingOptionNew context: Nil];
        [wkwebview addObserver:self forKeyPath:@"URL" options:NSKeyValueObservingOptionNew context: Nil];
        [wkwebview addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew context: Nil];
        [wkwebview addObserver:self forKeyPath:@"hasOnlySecureContent" options:NSKeyValueObservingOptionNew context: Nil];
    } else {
        UIWebView *uiwebview = [[UIWebView alloc] initWithFrame: bounds];
        _webView = uiwebview;
        [self addSubview:_webView];
        _useWkWebView = NO;
        
        [uiwebview addObserver:self forKeyPath:@"URL" options:NSKeyValueObservingOptionNew context: Nil];
        //fake value
        _title = Nil;
        _estimatedProgress = 1.0;
        _hasOnlySecureContent = TRUE;
    }
    
}

- (void)dealloc
{
    if(_useWkWebView) {
        WKWebView *wkwebview = (WKWebView *)_webView;
        [wkwebview removeObserver:self forKeyPath:@"title"];
        [wkwebview removeObserver:self forKeyPath:@"URL"];
        [wkwebview removeObserver:self forKeyPath:@"estimatedProgress"];
        [wkwebview removeObserver:self forKeyPath:@"hasOnlySecureContent"];
    } else {
        UIWebView *uiwebview = (UIWebView *)_webView;
        [uiwebview removeObserver:self forKeyPath:@"URL"];
        
        //avoid memory leak
        [(UIWebView *)self.webView loadHTMLString:@"" baseURL:nil];
        [uiwebview stopLoading];
    }
    [_webView removeFromSuperview];
    _webView = nil;
}

- (void) evaluateJavaScript: (NSString *) javaScriptString completionHandler: (void (^)(id, NSError *)) completionHandler
{
    [_webView evaluateJavaScript:javaScriptString completionHandler:completionHandler];
}

#pragma mark Wrap Method
- (BOOL) canGoBack
{
    return [_webView canGoBack];
}

- (BOOL) canGoForward
{
    return [self canGoForward];
}

- (BOOL) isLoading
{
    return [self isLoading];
}

- (id)goBack;
{
    if(_useWkWebView) {
        [(WKWebView *)_webView goBack];
    } else {
        [(UIWebView *)_webView goBack];
    }
    
    return self;
}

- (id)goForward
{
    if(_useWkWebView) {
        [(WKWebView *)_webView goForward];
    } else {
        [(UIWebView *)_webView goForward];
    }
    
    return self;
}

- (id)reload
{
    if(_useWkWebView) {
        [(WKWebView *)_webView reload];
    } else {
        [(UIWebView *)_webView reload];
    }
    
    return self;
}

- (id)reloadFromOrigin
{
    if(_useWkWebView) {
        [(WKWebView *)_webView reloadFromOrigin];
    } else {
        //fake method
        [(UIWebView *)_webView reload];
    }
    
    return self;
}

- (void)stopLoading
{
    [self stopLoading];
}

#pragma mark Observe properties of webview
- (void) observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context
{
    if (object == _webView && [keyPath isEqual:@"title"]) {
        if(_useWkWebView) {
            WKWebView *wkwebview = (WKWebView *)_webView;
            _title = wkwebview.title;
        }
    }
    
    if (object == _webView && [keyPath isEqual:@"URL"]) {
        _URL = _webView.URL;
    }
    
    if (object == _webView && [keyPath isEqual:@"estimatedProgress"]) {
        if(_useWkWebView) {
            WKWebView *wkwebview = (WKWebView *)_webView;
            _estimatedProgress = wkwebview.estimatedProgress;
        }
    }
    
    if (object == _webView && [keyPath isEqual:@"hasOnlySecureContent"]) {
        if(_useWkWebView) {
            WKWebView *wkwebview = (WKWebView *)_webView;
            _hasOnlySecureContent = wkwebview.hasOnlySecureContent;
        }
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
    [self.delegate didStartNavigation];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [self.delegate finishLoadOrNavigation: webView.request];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    [self.delegate failLoadOrNavigation:webView.request withError:error];
}

#pragma mark - WKNavigationDelegate

- (void) webView: (WKWebView *) webView decidePolicyForNavigationAction: (WKNavigationAction *) navigationAction decisionHandler: (void (^)(WKNavigationActionPolicy)) decisionHandler
{
    decisionHandler([self.delegate shouldStartDecidePolicy: [navigationAction request]]);
}

- (void) webView: (WKWebView *) webView didStartProvisionalNavigation: (WKNavigation *) navigation
{
    [self.delegate didStartNavigation];
}

- (void) webView:(WKWebView *) webView didFailProvisionalNavigation: (WKNavigation *) navigation withError: (NSError *) error
{
    [self.delegate failLoadOrNavigation:webView.request withError:error];
}

- (void) webView: (WKWebView *) webView didCommitNavigation: (WKNavigation *) navigation
{
    [self.delegate didStartNavigation];
}

- (void) webView: (WKWebView *) webView didFailNavigation: (WKNavigation *) navigation withError: (NSError *) error
{
    [self.delegate failLoadOrNavigation:webView.request withError:error];
}

- (void) webView: (WKWebView *) webView didFinishNavigation: (WKNavigation *) navigation
{
    [self.delegate finishLoadOrNavigation: webView.request];
}

@end
