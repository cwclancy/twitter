//
//  User.h
//  twitter
//
//  Created by Connor Clancy on 7/2/18.
//  Copyright © 2018 Emerson Malca. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface User : NSObject

@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *screenName;
@property (strong, nonatomic) NSString *userID;
@property (strong, nonatomic) NSURL *profilePictureURL;
@property (strong, nonatomic) NSURL *backgroundPictureURL;
@property (strong, nonatomic) NSString *bio;
@property (strong, nonatomic) NSString *followers;
@property (strong, nonatomic) NSString *following;

- (instancetype)initWithDictionary:(NSDictionary *)dict;

@end
