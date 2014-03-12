//
//  ViewController.m
//  MySafari
//
//  Created by Aaron Dufall on 12/03/2014.
//  Copyright (c) 2014 Aaron Dufall. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIWebView *myWebView;
@property (weak, nonatomic) IBOutlet UITextField *myURLTextField;
@property (weak, nonatomic) IBOutlet UIButton *backButton;
@property (weak, nonatomic) IBOutlet UIButton *forwardButton;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    NSString *urlString = [textField text];
    NSURL *url = [[NSURL alloc]initWithString:urlString];
    NSURLRequest *request = [[NSURLRequest alloc]initWithURL:url];
    [self.myWebView loadRequest:request];
    [textField resignFirstResponder];
    return YES;
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    if ([webView canGoBack]){
        NSLog(@"Can Go back");
        self.backButton.enabled = YES;
    } else {
        self.backButton.enabled = NO;
    }
    
    if ([webView canGoForward]) {
        self.forwardButton.enabled = YES;
    } else {
        self.backButton.enabled = NO;
    }
}

#pragma mark UIWebView controllers
- (IBAction)onBackButtonPressed:(id)sender {
    [self.myWebView goBack];
}
- (IBAction)onForwardButtonPressed:(id)sender {
    [self.myWebView goForward];
}
- (IBAction)onStopButtonPressed:(id)sender {
    [self.myWebView stopLoading];
}
- (IBAction)onReloadButtonPressed:(id)sender {
    [self.myWebView reload];
}

@end
