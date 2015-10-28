//
//  WKWebView+CCWebView.h
//  Chimera
//
//  Created by raven on 10/28/15.
//  Copyright © 2015 raven. All rights reserved.
//

#ifndef WKWebView_CCWebView_h
#define WKWebView_CCWebView_h

#import <WebKit/WebKit.h>
#import "CCWebViewProvider.h"

@interface WKWebView (CCWKWebView) <CCWebViewProvider>


- (void) setDelegateViews: (id <WKNavigationDelegate, WKUIDelegate>) delegateView;

@end

#endif /* WKWebView_CCWebView_h */
