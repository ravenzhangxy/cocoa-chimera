//
//  WKWebView+CCWebView.m
//  Chimera
//
//  Created by triplex on 10/28/15.
//  Copyright © 2015 raven. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "WKWebView+CCWKWebView.h"
#import <objc/runtime.h>

@implementation WKWebView (FLWKWebView)

- (void) setDelegateViews: (id <WKNavigationDelegate, WKUIDelegate>) delegateView
{
    [self setNavigationDelegate: delegateView];
    [self setUIDelegate: delegateView];
}

- (NSURLRequest *) request
{
    return objc_getAssociatedObject(self, @selector(request));
}

- (void) setRequest: (NSURLRequest *) request
{
    objc_setAssociatedObject(self, @selector(request), request, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void) altLoadRequest: (NSURLRequest *) request
{
    [self setRequest: request];
    
    [self altLoadRequest: request];
}

- (void) loadRequestFromString: (NSString *) urlNameAsString
{
    [self loadRequest: [NSURLRequest requestWithURL:[NSURL URLWithString: urlNameAsString]]];
}

- (void) setScalesPagesToFit: (BOOL) setPages
{
    return;
}

+ (void) load
{
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        Class class = [self class];
        
        SEL originalSelector = @selector(loadRequest:);
        SEL swizzledSelector = @selector(altLoadRequest:);
        
        Method originalMethod = class_getInstanceMethod(class, originalSelector);
        Method swizzledMethod = class_getInstanceMethod(class, swizzledSelector);
        
        BOOL didAddMethod = class_addMethod(class, originalSelector, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod));
        
        if (didAddMethod) {
            class_replaceMethod(class, swizzledSelector, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod));
        } else {
            method_exchangeImplementations(originalMethod, swizzledMethod);
        }
    });
}

@end