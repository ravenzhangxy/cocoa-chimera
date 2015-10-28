//
//  UIWebView+CCWebView.h
//  Chimera
//
//  Created by raven on 10/28/15.
//  Copyright © 2015 raven. All rights reserved.
//

#ifndef UIWebView_CCWebView_h
#define UIWebView_CCWebView_h

#import <UIKit/UIKit.h>
#import "CCWebViewProvider.h"

@interface UIWebView (CCUIWebView) <CCWebViewProvider>

- (void) setDelegateViews: (id <UIWebViewDelegate>) delegateView;

@end

#endif /* UIWebView_CCWebView_h */
