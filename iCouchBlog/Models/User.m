//
//  User.m
//  iCouchBlog
//
//  Created by Anna Lesniak on 10/16/12.
//  Copyright (c) 2012 Anna Lesniak. All rights reserved.
//

#import "User.h"

#define UserEmailSettingsKey @"UserEmailSettingsKey"

@implementation User

static CouchDesignDocument* design;

+ (CouchDesignDocument *) design {
  if (!design) {
    design = [User initDesignDocument];
  }
  return design;
}

+ (void) defineViews {
  [[[self class] design] defineViewNamed: @"byEmail" mapBlock: MAPBLOCK({
    id email = [doc objectForKey: @"email"];
    if (email) emit(email, doc);
  }) version: @"1.0"];
}

+ (User *) findByEmail: (NSString *) anEmail {
  CouchQuery *query = [[self design] queryViewNamed: @"byEmail"];
  query.keys = @[anEmail];
  return [[query.rows nextRow] value];
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

+ (NSString *) emailFromSettings {
  NSUserDefaults *settings = [NSUserDefaults standardUserDefaults];
  return [settings objectForKey: UserEmailSettingsKey];
}

- (void) login {
  NSUserDefaults *settings = [NSUserDefaults standardUserDefaults];
  [settings setObject: [self getValueOfProperty: @"email"] forKey: UserEmailSettingsKey];
  [settings synchronize];
}

@end
