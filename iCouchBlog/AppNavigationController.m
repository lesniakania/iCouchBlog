//
//  AppNavigationController.m
//  iCouchBlog
//
//  Created by Anna Lesniak on 10/7/12.
//  Copyright (c) 2012 Anna Lesniak. All rights reserved.
//

#import "AppNavigationController.h"
#import "User.h"

@implementation AppNavigationController

static User *currentUser;

- (void) viewDidLoad {
  id rootController;
  
  NSString *email = [User emailFromSettings];
  if (email) {
    currentUser = [User findByEmail: email];
  }
  
  if (currentUser) {
    rootController = [self.storyboard instantiateViewControllerWithIdentifier: @"PostsViewController"];
  } else {
    rootController = [self.storyboard instantiateViewControllerWithIdentifier: @"LoginViewController"];
  }
  self.viewControllers = [NSArray arrayWithObjects:rootController, nil];
}

@end
