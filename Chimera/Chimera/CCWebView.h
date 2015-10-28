//
//  CCWebView.h
//  Chimera
//
//  Created by raven on 10/28/15.
//  Copyright © 2015 raven. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CCWebViewProvider.h"

@interface CCWebView : UIView

@property (nonatomic, strong) UIView <CCWebViewProvider> *webView;

@end
