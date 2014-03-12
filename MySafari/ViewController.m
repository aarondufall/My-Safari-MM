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

@property (nonatomic, assign) CGFloat lastContentOffset;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.myWebView.scrollView setDelegate:self];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{

    NSString *urlString = [NSString stringWithFormat:@"http://%@",[textField text]];
    NSURL *url = [[NSURL alloc]initWithString:urlString];
    NSURLRequest *request = [[NSURLRequest alloc]initWithURL:url];
    [self.myWebView loadRequest:request];
    
    self.myURLTextField.text = urlString;
    [textField resignFirstResponder];
    
    return YES;
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (self.lastContentOffset > scrollView.contentOffset.y) {
        //Scroll down
        NSLog(@"down");
        self.myURLTextField.hidden = NO;
        self.myWebView.frame = CGRectMake(0, 96, self.view.frame.size.width, 414);
    } else if (self.lastContentOffset < scrollView.contentOffset.y){
        //Scoll up
        NSLog(@"up");
        self.myURLTextField.hidden = YES;
        self.myWebView.frame = CGRectMake(0, 0, self.view.frame.size.width, 510);
      
    }
    self.lastContentOffset = scrollView.contentOffset.y;
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    if ([webView canGoBack]){
        self.backButton.enabled = YES;
    } else {
        self.backButton.enabled = NO;

    }
    
    if ([webView canGoForward]) {
        self.forwardButton.enabled = YES;
    } else {
        self.forwardButton.enabled = NO;
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
- (IBAction)onPlusButtonPressed:(id)sender {
    UIAlertView *av = [[UIAlertView alloc]initWithTitle:@"Comming Soon" message:@"Amazing new feature" delegate:nil cancelButtonTitle:@"Awesome!" otherButtonTitles: nil];
    [av show];
}

@end
