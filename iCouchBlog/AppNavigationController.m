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

- (void) viewDidLoad {
  id rootController;
  
  if ([User current]) {
    rootController = [self.storyboard instantiateViewControllerWithIdentifier: @"PostsViewController"];
  } else {
    rootController = [self.storyboard instantiateViewControllerWithIdentifier: @"LoginViewController"];
  }
  self.viewControllers = [NSArray arrayWithObjects:rootController, nil];
}

@end
