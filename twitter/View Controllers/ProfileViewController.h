//
//  ProfileViewController.h
//  twitter
//
//  Created by Connor Clancy on 7/5/18.
//  Copyright © 2018 Emerson Malca. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "User.h"

@interface ProfileViewController : UIViewController
@property (strong, nonatomic) User *me;
@end
