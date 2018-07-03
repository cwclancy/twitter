//
//  User.m
//  twitter
//
//  Created by Connor Clancy on 7/2/18.
//  Copyright © 2018 Emerson Malca. All rights reserved.
//

#import "User.h"

@implementation User

- (instancetype)initWithDictionary:(NSDictionary *)dict {
    self = [super init];
    if (self) {
        self.name = dict[@"name"];
        self.screenName = dict[@"screen_name"];
        self.userID = dict[@"user_id"];
        self.profilePictureURL = [NSURL URLWithString:dict[@"profile_image_url_https"]];
    }
    return self;
}

@end
