//
//  AppDelegate.m
//  iCouchBlog
//
//  Created by Anna Lesniak on 8/26/12.
//  Copyright (c) 2012 Anna Lesniak. All rights reserved.
//

#import "AppDelegate.h"
#import "User.h"
#import "Post.h"

@class User, Post;

@implementation AppDelegate

- (BOOL) application: (UIApplication *) application didFinishLaunchingWithOptions: (NSDictionary *) launchOptions {
  for (id klass in @[[User class], [Post class]]) {
    [klass defineViews];
  }
  
  return YES;
}

@end
