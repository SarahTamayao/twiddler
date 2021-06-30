//
//  DetailsViewController.m
//  twitter
//
//  Created by Emily Jiang on 6/29/21.
//  Copyright © 2021 Emerson Malca. All rights reserved.
//

#import "DetailsViewController.h"
#import "ComposeViewController.h"
#import "UIImageView+AFNetworking.h"
#import "APIManager.h"
#import "Tweet.h"

@interface DetailsViewController () <ComposeViewControllerDelegate>
// public: @property (nonatomic, strong) Tweet *tweet;
@property (weak, nonatomic) IBOutlet UIImageView *profilePic;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *usernameLabel;
//@property (weak, nonatomic) IBOutlet UILabel *tweetLabel;
@property (weak, nonatomic) IBOutlet UITextView *tweetLabel;

@property (weak, nonatomic) IBOutlet UILabel *dateLabel;

@property (weak, nonatomic) IBOutlet UILabel *rtCount;
@property (weak, nonatomic) IBOutlet UILabel *favCount;
@property (weak, nonatomic) IBOutlet UIButton *rtButton;
@property (weak, nonatomic) IBOutlet UIButton *favButton;

@end

@implementation DetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupView];
    [self refreshData];
}

- (void)configButtons {
    // Initialization code to config default and selected button states
    [self.favButton setImage:[UIImage imageNamed:@"favor-icon"] forState:UIControlStateNormal];
    [self.favButton setImage:[UIImage imageNamed:@"favor-icon-red"] forState:UIControlStateSelected];
    
    [self.rtButton setImage:[UIImage imageNamed:@"retweet-icon"] forState:UIControlStateNormal];
    [self.rtButton setImage:[UIImage imageNamed:@"retweet-icon-green"] forState:UIControlStateSelected];
}

- (void)setupView {
    [self configButtons];
    
    self.nameLabel.text = self.tweet.user.name;
    self.usernameLabel.text = [@"@" stringByAppendingString:self.tweet.user.screenName];
    self.tweetLabel.text = self.tweet.text;
    [self.tweetLabel setTextContainerInset:UIEdgeInsetsZero];
    self.tweetLabel.textContainer.lineFragmentPadding = 0;

    self.dateLabel.text = self.tweet.createdAtStringLong;

    self.favButton.selected = self.tweet.favorited;
    self.rtButton.selected = self.tweet.retweeted;
    self.favCount.text = [NSString stringWithFormat:@"%i", self.tweet.favoriteCount];
    self.rtCount.text = [NSString stringWithFormat:@"%i", self.tweet.retweetCount];
    
    NSString *URLString = self.tweet.user.profilePicture;
    NSString *imUrl = [URLString stringByReplacingOccurrencesOfString:@"_normal" withString:@""];
    NSURL *url = [NSURL URLWithString:imUrl];
    [self.profilePic setImageWithURL:url];
    self.profilePic.layer.cornerRadius = 30; // ht = wt = 60
}

- (void)refreshData { //updates cell UI (not any internal tweet info, that should already be changed)
    self.favCount.text = [NSString stringWithFormat:@"%i", self.tweet.favoriteCount];
    self.rtCount.text = [NSString stringWithFormat:@"%i", self.tweet.retweetCount];
}

- (void)didTweet:(Tweet *)tweet {
    [self refreshData];
}

- (IBAction)didTapFav:(id)sender {
    if (self.tweet.favorited) { // already fav'd, now unfav it
        self.tweet.favorited = false;
        self.tweet.favoriteCount -= 1;
        self.favButton.selected = false;
        [[APIManager shared] unfavorite:self.tweet completion:^(Tweet *tweet, NSError *error) {
            if(error){
                NSLog(@"Error unfavoriting tweet: %@", error.localizedDescription);
            } else {
                NSLog(@"Unfavorited tweet: %@", tweet.text);
            }
        }];
    } else { // favorite tweet
        // Update the local tweet model
        self.tweet.favorited = true;
        self.tweet.favoriteCount += 1;
        self.favButton.selected = true;
        // Send a POST request to the POST favorites/create endpoint
        [[APIManager shared] favorite:self.tweet completion:^(Tweet *tweet, NSError *error) {
            if(error){
                NSLog(@"Error favoriting tweet: %@", error.localizedDescription);
            } else {
                NSLog(@"Favorited tweet: %@", tweet.text);
            }
        }];
    }
    // Update cell UI
    [self refreshData];
}

- (IBAction)didTapRetweet:(id)sender {
    if (self.tweet.retweeted) { // unretweet it
        self.tweet.retweeted = false;
        self.tweet.retweetCount -= 1;
        self.rtButton.selected = false;
        [[APIManager shared] unretweet:self.tweet completion:^(Tweet *tweet, NSError *error) {
            if(error){
                NSLog(@"Error unretweeting: %@", error.localizedDescription);
            } else {
                NSLog(@"Unretweeted: %@", tweet.text);
            }
        }];
    } else { // retweet it
        // update locally
        self.tweet.retweeted = true;
        self.tweet.retweetCount += 1;
        self.rtButton.selected = true;
        [[APIManager shared] retweet:self.tweet completion:^(Tweet *tweet, NSError *error) {
            if(error){
                NSLog(@"Error retweeting: %@", error.localizedDescription);
            } else {
                NSLog(@"Retweeted: %@", tweet.text);
            }
        }];
    }
    [self refreshData];
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    NSString *segId = [segue identifier];
    NSLog(@"segue identifier: %@", segId);
    if([segId isEqualToString:@"composeReply"]) {
        UINavigationController *navigationController = [segue destinationViewController];
        ComposeViewController *composeController = (ComposeViewController *)navigationController.topViewController;
        composeController.delegate = self;
        composeController.inReplyToTweet = self.tweet;
    }
}


@end
