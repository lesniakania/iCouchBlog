//
//  AppDelegate.m
//  iCouchBlog
//
//  Created by Anna Lesniak on 8/26/12.
//  Copyright (c) 2012 Anna Lesniak. All rights reserved.
//

#import "AppDelegate.h"
#import "Post.h"

@class Post;

@implementation AppDelegate

- (BOOL) application: (UIApplication *) application didFinishLaunchingWithOptions: (NSDictionary *) launchOptions {
  [self setupDatabase];
  
  for (id klass in @[[Post class]]) {
    [klass defineViews];
  }
  
  self.postsReplicator = [[Replicator alloc] init];
  
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

@end
