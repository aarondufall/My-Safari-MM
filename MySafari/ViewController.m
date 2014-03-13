//
//  ViewController.m
//  MySafari
//
//  Created by Aaron Dufall on 12/03/2014.
//  Copyright (c) 2014 Aaron Dufall. All rights reserved.
//

#import "ViewController.h"
typedef NS_ENUM(NSInteger, ScrollDirection){
    ScrollDirectionUp,
    ScrollDirectionDown,
};

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIWebView *myWebView;
@property (weak, nonatomic) IBOutlet UITextField *myURLTextField;
@property (weak, nonatomic) IBOutlet UIButton *backButton;
@property (weak, nonatomic) IBOutlet UIButton *forwardButton;

@property (nonatomic, assign) CGFloat lastContentOffset;
@property (nonatomic, assign) ScrollDirection scrollDirection;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *pageLoadIndicatorView;
@property (weak, nonatomic) IBOutlet UIView *navView;
@property (weak, nonatomic) IBOutlet UIView *headerView;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.myWebView.scrollView setDelegate:self];
	
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    
    NSString *urlString = [textField text];
    if ([[textField text]rangeOfString:@"http://"].location == NSNotFound) {
       urlString = [NSString stringWithFormat:@"http://%@",[textField text]];
    }
    
    NSURL *url = [[NSURL alloc]initWithString:urlString];
    NSURLRequest *request = [[NSURLRequest alloc]initWithURL:url];
    [self.myWebView loadRequest:request];
    
    self.myURLTextField.text = urlString;
    [textField resignFirstResponder];
    
    return YES;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView

{
   
    if (self.lastContentOffset > scrollView.contentOffset.y) {
        //Scroll down
        self.scrollDirection = ScrollDirectionDown;
        
    } else if (self.lastContentOffset < scrollView.contentOffset.y){
        //Scoll up
        self.scrollDirection = ScrollDirectionUp;
    }
    
    self.lastContentOffset = scrollView.contentOffset.y;
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    if (self.scrollDirection == ScrollDirectionDown){
        [UIView animateWithDuration:0.4 animations:^{
            self.headerView.frame = CGRectMake(0, 0, 320, 96);
            self.navView.frame = CGRectMake(0, self.view.frame.size.height - 60, 320, 30);
            self.myWebView.frame = CGRectMake(0, 96, self.view.frame.size.width, self.view.frame.size.height - 154);
        }];
    } else if (self.scrollDirection == ScrollDirectionUp){
        [UIView animateWithDuration:0.4 animations:^{
            self.headerView.frame = CGRectMake(0, -96, 320, 96);
            self.navView.frame = CGRectMake(0, self.view.frame.size.height + 60, 320, 60);
            self.myWebView.frame = CGRectMake(0, 20, self.view.frame.size.width, (self.view.frame.size.height - 20));
        }];
    }
}

-(void)webViewDidStartLoad:(UIWebView *)webView
{
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    [self.pageLoadIndicatorView startAnimating];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    self.titleLabel.text = [webView stringByEvaluatingJavaScriptFromString:@"document.title"];
    self.backButton.enabled = [webView canGoBack];
    self.forwardButton.enabled = [webView canGoForward];
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
    [self.pageLoadIndicatorView stopAnimating];

   
}




- (IBAction)onPlusButtonPressed:(id)sender {
    UIAlertView *av = [[UIAlertView alloc]initWithTitle:@"Comming Soon" message:@"Amazing new feature" delegate:nil cancelButtonTitle:@"Awesome!" otherButtonTitles: nil];
    [av show];
}

@end
