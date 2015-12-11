//
//  ViewController.m
//  Javascript-master
//
//  Created by pearl on 15/12/11.
//  Copyright © 2015年 pearl. All rights reserved.
//

#import "ViewController.h"
#import <JavaScriptCore/JavaScriptCore.h>
@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIWebView *webview;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    NSString *htmlPath = [[NSBundle mainBundle]pathForResource:@"index" ofType:@"html"];
    NSString *htmlString = [[NSString alloc] initWithContentsOfFile:htmlPath encoding:NSUTF8StringEncoding error:nil];
    [self.webview loadHTMLString:htmlString baseURL:nil];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    JSContext *context=[webView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
    context[@"local"] = ^ (){
        NSArray *args = [JSContext currentArguments];
        JSValue *jsObject = [args firstObject];
        id objcObject = [jsObject toObject];
        NSLog(@" %@",objcObject);
        
    };
    NSString *collectionShare = @"var js2java = new Object();\
    js2java.showShare = function(args){\
    local(args)\
    }";
    [context evaluateScript:collectionShare];
}

@end
