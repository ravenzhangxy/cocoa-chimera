//
//  CCWebViewProvider.h
//  Chimera
//
//  Created by raven on 10/28/15.
//  Copyright © 2015 raven. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol CCWebViewProvider <NSObject>

@property (nonatomic, strong) NSURLRequest *request;

@property (nonatomic, strong) NSURL *URL;

- (void) setDelegateViews: (id) delegateView;

- (void) loadRequest: (NSURLRequest *) request;

- (void) loadRequestFromString: (NSString *) urlNameAsString;

- (BOOL) canGoBack;

- (void) evaluateJavaScript: (NSString *) javaScriptString completionHandler: (void (^)(id, NSError *)) completionHandler;

@end
