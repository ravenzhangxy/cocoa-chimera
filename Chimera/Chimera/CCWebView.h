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

- (void) evaluateJavaScript: (NSString *) javaScriptString completionHandler: (void (^)(id, NSError *)) completionHandler;

@end
