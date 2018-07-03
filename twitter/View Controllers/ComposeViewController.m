//
//  ComposeViewController.m
//  twitter
//
//  Created by Connor Clancy on 7/3/18.
//  Copyright © 2018 Emerson Malca. All rights reserved.
//

#import "ComposeViewController.h"
#import "APIManager.h"

@interface ComposeViewController ()
@property (weak, nonatomic) IBOutlet UIBarButtonItem *closeButton;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *tweetButton;
@property (weak, nonatomic) IBOutlet UITextView *textField;

@end

@implementation ComposeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


/* CLOSE VIEW BUTTON */

- (IBAction)closeView:(id)sender {
    [self dismissViewControllerAnimated:true completion:nil];
}


/* TWEET BUTTON */
- (IBAction)sendTweet:(id)sender {
    NSString *text = self.textField.text;
    APIManager *manager = [APIManager new];
    [manager postStatusWithString:text completion:^(Tweet *tweet, NSError *error) {
        if (error) {
            [self dismissViewControllerAnimated:true completion:nil];
            NSLog(@"error");
        } else {
            [self.delegate didTweet:tweet];
            [self dismissViewControllerAnimated:true completion:nil];
            NSLog(@"success");
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
