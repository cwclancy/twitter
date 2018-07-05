//
//  DetailsViewContoller.m
//  twitter
//
//  Created by Connor Clancy on 7/5/18.
//  Copyright © 2018 Emerson Malca. All rights reserved.
//

#import "DetailsViewContoller.h"
#import "UIImageView+AFNetworking.h"
#import "APIManager.h"


@interface DetailsViewContoller ()

@property (strong, nonatomic) IBOutlet UILabel *nameLabel;
@property (strong, nonatomic) IBOutlet UILabel *usernameLabel;
@property (strong, nonatomic) IBOutlet UIImageView *profilePicture;
@property (strong, nonatomic) IBOutlet UILabel *tweetBody;
@property (strong, nonatomic) IBOutlet UILabel *timeLabel;
@property (strong, nonatomic) IBOutlet UILabel *retweetCountLabel;
@property (strong, nonatomic) IBOutlet UILabel *retweetLabel;
@property (strong, nonatomic) IBOutlet UILabel *likeCountLabel;
@property (strong, nonatomic) IBOutlet UILabel *likesLabel;
@property (strong, nonatomic) IBOutlet UIButton *replyButtonLabel;
@property (strong, nonatomic) IBOutlet UIButton *retweetButtonLabel;
@property (strong, nonatomic) IBOutlet UIButton *favoriteButtonLabel;
@property (strong, nonatomic) IBOutlet UIButton *DMButton;

@end

@implementation DetailsViewContoller

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.nameLabel.text = self.tweet.user.name;
    self.usernameLabel.text = [NSString stringWithFormat:@"@%@", self.tweet.user.screenName];
    self.tweetBody.text = self.tweet.text;
    self.retweetCountLabel.text = [NSString stringWithFormat:@"%d", self.tweet.retweetCount];
    self.likeCountLabel.text = [NSString stringWithFormat:@"%d", self.tweet.favoriteCount];
    [self.profilePicture setImageWithURL:self.tweet.user.profilePictureURL];
    [self.tweetBody sizeToFit];
    self.timeLabel.text = self.tweet.createdAtString;
    self.profilePicture.layer.cornerRadius = self.profilePicture.frame.size.width / 2;
    self.profilePicture.clipsToBounds = YES;
    
}

-(void)refreshPage {
    self.nameLabel.text = self.tweet.user.name;
    self.usernameLabel.text = [NSString stringWithFormat:@"@%@", self.tweet.user.screenName];
    self.tweetBody.text = self.tweet.text;
    self.retweetCountLabel.text = [NSString stringWithFormat:@"%d", self.tweet.retweetCount];
    self.likeCountLabel.text = [NSString stringWithFormat:@"%d", self.tweet.favoriteCount];
    self.timeLabel.text = self.tweet.createdAtString;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)tappedRetweetButton:(id)sender {
    // case on whether tweet is retweeted or not
    APIManager *manager = [APIManager new];
    if (!self.retweetButtonLabel.selected) {
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
        [self.retweetButtonLabel setSelected:YES];
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
        [self.retweetButtonLabel setSelected:NO];
    }
}


- (IBAction)tappedFavoriteButton:(id)sender {
    // case on whether tweet is favorited or not
    if (!self.favoriteButtonLabel.selected) {
        [[APIManager shared] favorite:self.tweet completion:^(Tweet *tweet, NSError *error) {
            if (error) {
                NSLog(@"fail");
                [self.favoriteButtonLabel setSelected:YES];
            } else {
                self.tweet.favorited = YES;
                self.tweet.favoriteCount++;
                [self.favoriteButtonLabel setSelected:YES];
                [self refreshPage];
                NSLog(@"success");
            }
            
        }];
        [self.favoriteButtonLabel setSelected:YES];
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
        
        [self.favoriteButtonLabel setSelected:NO];
    }
    [self refreshPage];
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
