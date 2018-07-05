//
//  TweetCell.m
//  twitter
//
//  Created by Connor Clancy on 7/2/18.
//  Copyright © 2018 Emerson Malca. All rights reserved.
//

#import "TweetCell.h"
#import "UIImageView+AFNetworking.h"
#import "APIManager.h"


@interface TweetCell ()

@end

@implementation TweetCell

// INIT

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.profilePicture.layer.cornerRadius = self.profilePicture.frame.size.width / 2;
    self.profilePicture.clipsToBounds = YES;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}



- (void)setTweet:(Tweet *)tweet {
    _tweet = tweet;
    self.username.text = [NSString stringWithFormat:@"@%@",tweet.user.screenName];
    self.screenName.text = tweet.user.name;
    self.tweetContents.text = tweet.text;
    self.retweetLabel.text = [NSString stringWithFormat:@"%d", tweet.retweetCount];
    self.favoriteLabel.text = [NSString stringWithFormat:@"%d", tweet.favoriteCount];
    [self.profilePicture setImageWithURL:tweet.user.profilePictureURL];
    [self.textLabel sizeToFit];
    self.timeLabel.text = self.tweet.createdAtString;
}

/*
    UPDATE CELL
*/

-(void)refreshPage {
    self.username.text = [NSString stringWithFormat:@"@%@",self.tweet.user.screenName];
    self.screenName.text = self.tweet.user.name;
    self.tweetContents.text = self.tweet.text;
    self.retweetLabel.text = [NSString stringWithFormat:@"%d", self.tweet.retweetCount];
    self.favoriteLabel.text = [NSString stringWithFormat:@"%d", self.tweet.favoriteCount];
}


- (IBAction)tappedFavoriteButton:(id)sender {
    // case on whether tweet is favorited or not
    if (!self.favoriteButton.selected) {
        [[APIManager shared] favorite:self.tweet completion:^(Tweet *tweet, NSError *error) {
            if (error) {
                NSLog(@"fail");
                [self.favoriteButton setSelected:YES];
            } else {
                self.tweet.favorited = YES;
                self.tweet.favoriteCount++;
                [self refreshPage];
                [self.favoriteButton setSelected:YES];
                NSLog(@"success");
            }
            
        }];
        [self.favoriteButton setSelected:YES];
    } else {
        NSLog(@"off");
        [[APIManager shared] unfavorite:self.tweet completion:^(Tweet *tweet, NSError *error) {
            if (error) {
                NSLog(@"unfavorite fail");
            } else {
                self.tweet.favorited = NO;
                self.tweet.favoriteCount--;
                [self refreshPage];
                NSLog(@"unfavorite success");
            }
            
        }];
        
        [self.favoriteButton setSelected:NO];
    }
    [self refreshPage];
}

- (IBAction)tappedRetweenButton:(id)sender {
    // case on whether tweet is retweeted or not
    APIManager *manager = [APIManager new];
    if (!self.retweetButton.selected) {
        [manager retweet:self.tweet completion:^(Tweet *tweet, NSError *error) {
            if (error) {
                NSLog(@"retweet error");
                NSLog(@"%@", error);
            } else {
                self.tweet.retweeted = YES;
                self.tweet.retweetCount++;
                [self refreshPage];
                NSLog(@"retweet success");
            }
        }];
        [self.retweetButton setSelected:YES];
    } else {
        [manager unretweet:self.tweet completion:^(Tweet *tweet, NSError *error) {
            if (error) {
                NSLog(@"unretweet error");
            } else {
                self.tweet.retweeted = NO;
                self.tweet.retweetCount--;
                [self refreshPage];
                NSLog(@"unretweet success");
            }
        }];
        [self.retweetButton setSelected:NO];
    }
}




@end
