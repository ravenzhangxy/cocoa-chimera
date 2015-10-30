//
//  CCWebViewDelegate.h
//  Chimera
//
//  Created by Raven on 15/10/30.
//  Copyright © 2015年 raven. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol CCWebViewDelegate <NSObject>

- (BOOL) shouldStartDecidePolicy: (NSURLRequest *) request;

/*
 * This is called whenever the web view has started navigating.
 */
// Update things like loading indicators here.
- (void) didStartNavigation;

/*
 * This is called when navigation failed.
 */
// Notify the user that navigation failed, provide information on the error, and so on.
- (void) failLoadOrNavigation: (NSURLRequest *) request withError: (NSError *) error;

/*
 * This is called when navigation succeeds and is complete.
 */
// Remove the loading indicator, maybe update the navigation bar's title if you have one.
- (void) finishLoadOrNavigation: (NSURLRequest *) request;

@end
