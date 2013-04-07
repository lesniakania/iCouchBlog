//
//  User.h
//  iCouchBlog
//
//  Created by Anna Lesniak on 10/16/12.
//  Copyright (c) 2012 Anna Lesniak. All rights reserved.
//

#import "BaseModel.h"

#define UserEmailSettingsKey @"UserEmailSettingsKey"
#define UserByEmailView @"userByEmail"

@class Post;

@interface User : BaseModel

@property (strong, nonatomic) NSString *email;
@property (strong, nonatomic) NSArray *posts_ids;

+ (User *) current;
+ (User *) findByEmail: (NSString *) anEmail;
- (NSString *) documentID;

- (void) addPost: (Post *) post;

+ (NSString *) emailFromSettings;
+ (User *) createWith: (NSDictionary *) hash;
- (BOOL) login;
- (void) logout;

@end
