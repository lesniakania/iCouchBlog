//
//  User.h
//  iCouchBlog
//
//  Created by Anna Lesniak on 10/16/12.
//  Copyright (c) 2012 Anna Lesniak. All rights reserved.
//

#import "BaseModel.h"

@class Post;

@interface User : BaseModel

+ (User *) current;
+ (User *) findByEmail: (NSString *) anEmail;
+ (User *) findOrCreateByEmail: (NSString *) anEmail;

- (void) addPost: (Post *) post;

+ (NSString *) emailFromSettings;
+ (BOOL) loginWithEmail: (NSString *) email;
- (void) logout;

@end
