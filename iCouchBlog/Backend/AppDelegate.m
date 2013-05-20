//
//  AppDelegate.m
//  iCouchBlog
//
//  Created by Anna Lesniak on 8/26/12.
//  Copyright (c) 2012 Anna Lesniak. All rights reserved.
//

#import "AppDelegate.h"
#import "Post.h"
#import "User.h"

@implementation AppDelegate

- (BOOL) application: (UIApplication *) application didFinishLaunchingWithOptions: (NSDictionary *) launchOptions {
  [self setupDatabase];
  [self setupFilters];
  [self setupGeneralViews];
  
  return YES;
}

- (void) setupDatabase {
  NSError* error;
  self.database = [[CBLManager sharedInstance] createDatabaseNamed: kDatabaseName
                                                             error: &error];
  if (!self.database) {
    NSLog(@"Failed setuping database: %@.", [error localizedDescription]);
  }
}

- (void) setupFilters {
  for (id klass in @[[Post class], [User class]]) {
    [klass defineFilters];
  }
}

- (void) setupGeneralViews {
  [[[DataStore currentDatabase] viewNamed: UserByEmailView] setMapBlock: MAPBLOCK({
    NSString *type = doc[@"type"];
    id email = doc[@"email"];
    if ([type isEqualToString: @"User"] && email) emit(email, doc);
  }) reduceBlock: nil version: @"1.0"];
  
  [[[DataStore currentDatabase] viewNamed: PostByConflicts] setMapBlock: MAPBLOCK({
    NSString *type = doc[@"type"];
    id conflicts = doc[@"_conflicts"];
    if ([type isEqualToString: @"Post"] && conflicts) {
      emit(conflicts, doc);
    }
  }) reduceBlock: nil version: @"1.0"];
}

@end
