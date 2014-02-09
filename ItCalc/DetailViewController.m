//
//  DetailViewController.m
//  ItCal
//
//  Created by hiro on 2014/02/05.
//  Copyright (c) 2014年 hiro. All rights reserved.
//

#import "DetailViewController.h"

@interface DetailViewController ()
@property (weak, nonatomic) IBOutlet UIWebView *wv;

@end

@implementation DetailViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.wv.delegate = self;
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"detail" ofType:@"html" inDirectory:@"html"];
    NSURL *url = [NSURL fileURLWithPath:path];
    NSURLRequest *req = [NSURLRequest requestWithURL:url];
    [self.wv loadRequest:req];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/**
 *  WevView読み込み完了時に、JSを実行する
 *
 *  @param webView <#webView description#>
 */
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    // JS実行
    [self jsSetTitle:[self.detailData objectForKey:@"title"]];
    [self jsSetDescription:[self.detailData objectForKey:@"description"]];
    [self jsSetAddress:[self.detailData objectForKey:@"address"]];
    [self jsSetPlace:[self.detailData objectForKey:@"place"]];
    [self jsSetBegin:[self.detailData objectForKey:@"begin"]];
    [self jsSetEnd:[self.detailData objectForKey:@"end"]];
    [self jsSetCapacity:[self.detailData objectForKey:@"capacity"]];
    [self jsSetApplicant:[self.detailData objectForKey:@"applicant"]];
}

/**
 *  WebView内のクリックイベント処理
 *
 *  @param webView        <#webView description#>
 *  @param request        <#request description#>
 *  @param navigationType <#navigationType description#>
 *
 *  @return <#return value description#>
 */
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    static NSString* const callbackProtocol = @"app-callback://";
    
    NSString *url = [[request URL] absoluteString];
    if ([url hasPrefix:callbackProtocol]) {
        NSString *method = [url substringFromIndex:[callbackProtocol length]];
        if ([method isEqualToString:@"map"]) {
            NSString *map = [NSString stringWithFormat:@"http://maps.apple.com/maps?ll=%@,%@", [self.detailData objectForKey:@"lat"], [self.detailData objectForKey:@"lon"]];
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:map]];
        } else if ([method isEqualToString:@"safari"]) {
            NSURL *url = [NSURL URLWithString:[self.detailData objectForKey:@"url"]];
            [[UIApplication sharedApplication] openURL:url];
        }
        return NO;
    }
    
    return YES;
}

- (void)jsSetTitle:(NSString *)param
{
    NSString* script = [NSString stringWithFormat:@"window.setTitle('%@');", param];
    [self.wv stringByEvaluatingJavaScriptFromString:script];
}
- (void)jsSetDescription:(NSString *)param
{
    NSString* script = [NSString stringWithFormat:@"window.setDescription('%@');", param];
    [self.wv stringByEvaluatingJavaScriptFromString:script];
}
- (void)jsSetAddress:(NSString *)param
{
    NSString* script = [NSString stringWithFormat:@"window.setAddress('%@');", param];
    [self.wv stringByEvaluatingJavaScriptFromString:script];
}
- (void)jsSetPlace:(NSString *)param
{
    NSString* script = [NSString stringWithFormat:@"window.setPlace('%@');", param];
    [self.wv stringByEvaluatingJavaScriptFromString:script];
}
- (void)jsSetBegin:(NSString *)param
{
    NSString* script = [NSString stringWithFormat:@"window.setBegin('%@');", param];
    [self.wv stringByEvaluatingJavaScriptFromString:script];
}
- (void)jsSetEnd:(NSString *)param
{
    NSString* script = [NSString stringWithFormat:@"window.setEnd('%@');", param];
    [self.wv stringByEvaluatingJavaScriptFromString:script];
}
- (void)jsSetCapacity:(NSString *)param
{
    NSString* script = [NSString stringWithFormat:@"window.setCapacity('%@');", param];
    [self.wv stringByEvaluatingJavaScriptFromString:script];
}
- (void)jsSetApplicant:(NSString *)param
{
    NSString* script = [NSString stringWithFormat:@"window.setApplicant('%@');", param];
    [self.wv stringByEvaluatingJavaScriptFromString:script];
}
@end
