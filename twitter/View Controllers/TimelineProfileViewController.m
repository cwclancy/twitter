//
//  TimelineProfileViewController.m
//  twitter
//
//  Created by Connor Clancy on 7/5/18.
//  Copyright © 2018 Emerson Malca. All rights reserved.
//

#import "TimelineProfileViewController.h"
#import "UIImageView+AFNetworking.h"


@interface TimelineProfileViewController ()
@property (strong, nonatomic) IBOutlet UIImageView *backgroundImageView;
@property (strong, nonatomic) IBOutlet UIImageView *profileImageView;
@property (strong, nonatomic) IBOutlet UILabel *nameLabel;
@property (strong, nonatomic) IBOutlet UILabel *usernameLabel;
@property (strong, nonatomic) IBOutlet UILabel *bioLabel;
@property (strong, nonatomic) IBOutlet UIButton *followButton;
@property (strong, nonatomic) IBOutlet UILabel *followingLabel;
@property (strong, nonatomic) IBOutlet UILabel *followersCountLabel;
@property (strong, nonatomic) IBOutlet UILabel *followersLabel;
@property (strong, nonatomic) IBOutlet UILabel *followingCountLabel;

@end

@implementation TimelineProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    self.nameLabel.text = self.user.name;
    self.usernameLabel.text = [NSString stringWithFormat:@"@%@", self.user.screenName];
    [self.backgroundImageView setImageWithURL:self.user.backgroundPictureURL];
    [self.profileImageView setImageWithURL:self.user.profilePictureURL];
    self.followersCountLabel.text = self.user.followers;
    self.followingCountLabel.text = self.user.following;
    self.bioLabel.text = self.user.bio;
    self.profileImageView.layer.cornerRadius = self.profileImageView.frame.size.width / 2;
    self.profileImageView.clipsToBounds = YES;
    [self.profileImageView.layer setBorderColor: [[UIColor whiteColor] CGColor]];
    [self.profileImageView.layer setBorderWidth: 2.0];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
