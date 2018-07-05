//
//  TimelineViewController.m
//  twitter
//
//  Created by emersonmalca on 5/28/18.
//  Copyright © 2018 Emerson Malca. All rights reserved.
//

#import "TimelineViewController.h"
#import "APIManager.h"
#import "Tweet.h"
#import "User.h"
#import "TweetCell.h"
#import "ComposeViewController.h"
#import "UIImageView+AFNetworking.h"
#import "AppDelegate.h"
#import "LoginViewController.h"
#import "DateTools.h"
#import "DetailsViewContoller.h"

@interface TimelineViewController () <ComposeViewControllerDelegate, UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSMutableArray *tweets;
@property (strong, nonatomic) UIRefreshControl *refreshControl;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *logoutButton;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *composeTweetButton;


@end

@implementation TimelineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // table view setup
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
    // refresh control
    self.refreshControl = [UIRefreshControl new];
    [self.refreshControl addTarget:self action:@selector(beginRefresh:) forControlEvents:UIControlEventValueChanged];
    [self.tableView insertSubview:self.refreshControl atIndex:0];
    
    // timeline set up
    [self fetchTweets];
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    

}

// refresh control functions

- (void)beginRefresh:(UIRefreshControl *)refreshControl {
    [self fetchTweets];
    [self.tableView reloadData];
    [self.refreshControl endRefreshing];
}


- (void)fetchTweets {
    // Get timeline
    [[APIManager shared] getHomeTimelineWithCompletion:^(NSArray *tweets, NSError *error) {
        if (tweets) {
            self.tweets = [NSMutableArray arrayWithArray:tweets];
            [self.tableView reloadData];
        } else {
            // TODO: Add network error message
        }
    }];
    [self.tableView reloadData];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



/************************
 
    TABLE VIEW FUNCTIONS
 
 *************************/


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TweetCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TweetCell"];
    cell.tweet = self.tweets[indexPath.row];
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.tweets.count;
}


/************************
 
    DELEGATE FUNCTIONS
 
 *************************/

- (void)didTweet:(Tweet *)tweet {
    [self.tweets insertObject:tweet atIndex:0];
    [self.tableView reloadData];
    NSLog(@"here");
}

/************************
 
 LOGOUT
 
 *************************/

- (IBAction)tappedLogoutButton:(id)sender {
    AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    LoginViewController *loginViewController = [storyboard instantiateViewControllerWithIdentifier:@"LoginViewController"];
    appDelegate.window.rootViewController = loginViewController;
    [[APIManager shared] logout];
}


/************************
 
 SEGUE
 
 *************************/

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // for composing tweets
    if (sender == self.composeTweetButton) {
        UINavigationController *navigationController = [segue destinationViewController];
        ComposeViewController *composeController = (ComposeViewController*)navigationController.topViewController;
        composeController.delegate = self;
    }
    // for going to details view
    else {
        UITableViewCell *tappedCell = sender;
        NSIndexPath *indexPath =[self.tableView indexPathForCell:tappedCell];
        Tweet *tweet = self.tweets[indexPath.row];
        DetailsViewContoller *detailsViewController = [segue destinationViewController];
        detailsViewController.tweet = tweet;
    }
}


@end
