//
//  UIWebView+CCWebView.m
//  Chimera
//
//  Created by raven on 10/28/15.
//  Copyright © 2015 raven. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "UIWebView+CCUIWebView.h"

@implementation UIWebView (CCUIWebView)

- (void) setDelegateViews: (id <UIWebViewDelegate>) delegateView
{
    [self setDelegate: delegateView];
}

- (void) loadRequestFromString: (NSString *) urlNameAsString
{
    [self loadRequest: [NSURLRequest requestWithURL:[NSURL URLWithString: urlNameAsString]]];
}

- (NSURL *) URL
{
    return [[self request] URL];
}

- (void) evaluateJavaScript: (NSString *) javaScriptString completionHandler: (void (^)(id, NSError *)) completionHandler
{
    NSString *string = [self stringByEvaluatingJavaScriptFromString: javaScriptString];
    
    if (completionHandler) {
        completionHandler(string, nil);
    }
}

- (void) setScalesPageToFit: (BOOL) setPages
{
    self.scalesPageToFit = setPages;
}

@end