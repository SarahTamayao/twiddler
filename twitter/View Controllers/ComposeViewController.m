//
//  ComposeViewController.m
//  twitter
//
//  Created by Emily Jiang on 6/28/21.
//  Copyright © 2021 Emerson Malca. All rights reserved.
//

#import "ComposeViewController.h"
#import "APIManager.h"

@interface ComposeViewController () <UITextViewDelegate>
@property (weak, nonatomic) IBOutlet UITextView *tweetTextView;
@property (weak, nonatomic) IBOutlet UILabel *charCountLabel;

@end

@implementation ComposeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.tweetTextView.delegate = self;
    if (self.inReplyToTweet) { // new tweet is a reply
        self.tweetTextView.text = [@"@" stringByAppendingString:self.inReplyToTweet.user.screenName];
        self.tweetTextView.textColor = [UIColor blackColor];
        // TODO: what happens to charcount label in reply tweet??
    } else {
        self.tweetTextView.text = @"What's happening?";
        self.tweetTextView.textColor = [UIColor lightGrayColor];
        self.charCountLabel.text = @"280";
    }
}

// below 2 methods control placeholder text in UITextView
- (void)textViewDidBeginEditing:(UITextView *)textView {
    if ([textView.text isEqualToString:@"What's happening?"]) {
        textView.text = @"";
        textView.textColor = [UIColor blackColor];
    }
    [textView becomeFirstResponder];
}

- (void)textViewDidEndEditing:(UITextView *)textView {
    if ([textView.text isEqualToString:@""]) {
        textView.text = @"What's happening?";
        textView.textColor = [UIColor lightGrayColor];
    }
    [textView becomeFirstResponder];
}

- (void)textViewDidChange:(UITextView *)textView {
    // count chars while typing, turn label red when it's negative etc.
    NSInteger tweetLen = [self.tweetTextView.text length];
    NSInteger charsLeft = 280 - tweetLen;
    if (charsLeft < 0) { // no more chars left
        self.charCountLabel.textColor = [UIColor redColor];
    } else {
        self.charCountLabel.textColor = [UIColor blackColor];
    }
    self.charCountLabel.text = [NSString stringWithFormat:@"%li", charsLeft];
}

- (IBAction)onTap:(id)sender { // why isnt this working bruh
    [self.view endEditing:true];
}

- (IBAction)onClose:(id)sender {
    [self dismissViewControllerAnimated:true completion:nil];
}

- (IBAction)postTweet:(id)sender {
    NSString *statusId = nil;
    if (self.inReplyToTweet) {
        statusId = self.inReplyToTweet.idStr;
    }
    [[APIManager shared] postStatusWithText:self.tweetTextView.text replyTo:statusId completion:^(Tweet *tweet, NSError *error) {
        if (error) {
            NSLog(@"Error posting tweet: %@", error.localizedDescription);
        } else {
            NSLog(@"Tweeted successfully!");
            [self.delegate didTweet:tweet];
            // dismiss modal
            [self dismissViewControllerAnimated:true completion:nil];
        }
    }];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
