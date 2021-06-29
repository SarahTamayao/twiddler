//
//  Tweet.m
//  twitter
//
//  Created by Emily Jiang on 6/28/21.
//  Copyright © 2021 Emerson Malca. All rights reserved.
//

#import "Tweet.h"
#import "User.h"
#import "DateTools.h"

@implementation Tweet

- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    self = [super init];
    if (self) {
        // is retweet?
        NSDictionary *originalTweet = dictionary[@"retweeted_status"];
        if(originalTweet != nil) {
            NSDictionary *userDictionary = dictionary[@"user"];
            self.retweetedByUser = [[User alloc] initWithDictionary:userDictionary];
            
            dictionary = originalTweet; // change tweet to original tweet
        }
        self.idStr = dictionary[@"id_str"];
        self.text = dictionary[@"full_text"];
        self.favoriteCount = [dictionary[@"favorite_count"] intValue];
        self.favorited = [dictionary[@"favorited"] boolValue];
        self.retweetCount = [dictionary[@"retweet_count"] intValue];
        self.retweeted = [dictionary[@"retweeted"] boolValue];
        // TODO: dictionary object now has "entities" field for tweets w/ photos
        
        // initialize user
        NSDictionary *user = dictionary[@"user"];
        self.user = [[User alloc] initWithDictionary:user];
        
        // Format and set createdAtString
        NSString *createdAtOriginalString = dictionary[@"created_at"];
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        // Configure input format to parse date string
        formatter.dateFormat = @"E MMM d HH:mm:ss Z y";
        // Convert string to date
        NSDate *date = [formatter dateFromString:createdAtOriginalString];
        // config output format
        formatter.dateStyle = NSDateFormatterShortStyle;
        formatter.timeStyle = NSDateFormatterNoStyle;
        // convert date to string
//        self.createdAtString = [formatter stringFromDate:date];
        self.createdAtString = [date shortTimeAgoSinceNow];
    }
    return self;
}

+ (NSMutableArray *)tweetsWithArray:(NSArray *)dictionaries {
    NSMutableArray *tweets = [NSMutableArray array];
    for (NSDictionary *dictionary in dictionaries) { // for each tweet in tweets
        Tweet *tweet = [[Tweet alloc] initWithDictionary:dictionary]; // create tweet object from tweet JSON object
        [tweets addObject:tweet];
    }
    return tweets; // array of tweet objects
}

@end
