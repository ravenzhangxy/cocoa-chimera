//
//  CCWebView.h
//  Chimera
//
//  Created by raven on 10/28/15.
//  Copyright © 2015 raven. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CCWebViewProvider.h"
#import "CCWebViewDelegate.h"

@interface CCWebView : UIView

@property (nonatomic, assign) id <CCWebViewDelegate>delegate;

//properties from WKWebkit
@property (nonatomic, readonly, copy) NSString *title;
@property (nonatomic, readonly, copy) NSURL *URL;
@property (nonatomic, readonly) double estimatedProgress;
@property (nonatomic, readonly) BOOL hasOnlySecureContent;

//wrap method
- (BOOL) canGoBack;
- (BOOL) canGoForward;
- (BOOL) isLoading;
- (id)goBack;
- (id)goForward;
- (id)reload;
- (id)reloadFromOrigin;
- (void)stopLoading;

- (void) evaluateJavaScript: (NSString *) javaScriptString completionHandler: (void (^)(id, NSError *)) completionHandler;

@end
