//
//  ViewController.m
//  Chimera
//
//  Created by Raven on 15/10/28.
//  Copyright © 2015年 raven. All rights reserved.
//

#import "ViewController.h"
#import "CCWebView.h"

@interface ViewController ()<CCWebViewDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    CCWebView *webView = [[CCWebView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:webView];
    webView.delegate = self;
}

- (BOOL)shouldStartDecidePolicy:(NSURLRequest *)request
{
    return YES;
}

- (void)didStartNavigation
{
    
}

- (void)finishLoadOrNavigation:(NSURLRequest *)request
{
    
}

- (void)failLoadOrNavigation:(NSURLRequest *)request withError:(NSError *)error
{
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
