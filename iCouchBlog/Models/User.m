//
//  User.m
//  iCouchBlog
//
//  Created by Anna Lesniak on 10/16/12.
//  Copyright (c) 2012 Anna Lesniak. All rights reserved.
//

#import "User.h"
#import "Post.h"

#define UserEmailSettingsKey @"UserEmailSettingsKey"

static User *currentUser;

@implementation User

+ (void) defineViews {
  [[[self class] design] defineViewNamed: @"byEmail" mapBlock: MAPBLOCK({
    NSString *type = [doc objectForKey: @"type"];
    id email = [doc objectForKey: @"email"];
    if ([type isEqualToString: @"User"] && email) emit(email, doc);
  }) version: @"1.0"];
}

+ (User *) current {
  if (!currentUser) {
    NSString *email = [User emailFromSettings];
    if (email) {
      currentUser = [User findByEmail: email];
    }
  }
  return currentUser;
}

+ (User *) findByEmail: (NSString *) anEmail {
  CouchQuery *query = [[self design] queryViewNamed: @"byEmail"];
  query.keys = @[anEmail];
  NSDictionary *values = [[query.rows nextRow] value];
  if (values) {
    return [User modelForDocumentWithId: [values objectForKey: @"_id"]];
  } else {
    return nil;
  }
}

+ (User *) findOrCreateByEmail: (NSString *) anEmail {
  User *user = [User findByEmail: anEmail];
  if (!user) {
    user = [[User alloc] init];
    [user setValue: anEmail ofProperty: @"email"];
    [user save];
  }
  return user;
}


- (void) addPost: (Post *) post {
  NSString *postId = [[post document] documentID];
  NSMutableArray *posts = [NSMutableArray arrayWithArray: [self getValueOfProperty: @"post_ids"]];
  if (![posts containsObject: postId]) {
    [posts addObject: postId];
    [self setValue: posts ofProperty: @"post_ids"];
  }
  [self save];
}



+ (NSString *) emailFromSettings {
  NSUserDefaults *settings = [NSUserDefaults standardUserDefaults];
  return [settings objectForKey: UserEmailSettingsKey];
}

+ (BOOL) loginWithEmail: (NSString *) email {
  NSUserDefaults *settings = [NSUserDefaults standardUserDefaults];
  [settings setObject: email forKey: UserEmailSettingsKey];
  [settings synchronize];
  return [User current] != nil;
}

- (void) logout {
  NSUserDefaults *settings = [NSUserDefaults standardUserDefaults];
  [settings removeObjectForKey: UserEmailSettingsKey];
  [settings synchronize];
}

@end
