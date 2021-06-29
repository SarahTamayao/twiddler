//
//  TweetCell.h
//  
//
//  Created by Emily Jiang on 6/28/21.
//

#import <UIKit/UIKit.h>
#import "Tweet.h"

NS_ASSUME_NONNULL_BEGIN

@interface TweetCell : UITableViewCell
@property (nonatomic, strong) Tweet *tweet;

@property (weak, nonatomic) IBOutlet UIImageView *profilePic;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *usernameLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UILabel *tweetLabel;

//@property (weak, nonatomic) IBOutlet UIButton *replyButton;
//@property (weak, nonatomic) IBOutlet UILabel *replyCount;
@property (weak, nonatomic) IBOutlet UIButton *rtButton;
@property (weak, nonatomic) IBOutlet UILabel *rtCount;
@property (weak, nonatomic) IBOutlet UIButton *favButton;
@property (weak, nonatomic) IBOutlet UILabel *favCount;

@end

NS_ASSUME_NONNULL_END
