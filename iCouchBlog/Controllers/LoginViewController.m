//
//  LoginViewController.m
//  iCouchBlog
//
//  Created by Anna Lesniak on 10/7/12.
//  Copyright (c) 2012 Anna Lesniak. All rights reserved.
//

#import "LoginViewController.h"
#import "User.h"

@implementation LoginViewController

- (void) viewDidLoad {
  [super viewDidLoad];
  self.view.backgroundColor = [UIColor navigationBarColor];
  [self.navigationController.navigationBar setTintColor: [UIColor navigationBarColor]];
  
  self.emailLabel.textColor = [UIColor darkTextColor];
  self.emailTextView.textColor = [UIColor darkTextColor];
  self.emailTextView.backgroundColor = [UIColor lightBackgroundColor];
}

- (void) tableView: (UITableView *) tableView willDisplayCell: (UITableViewCell *) cell forRowAtIndexPath: (NSIndexPath *) indexPath {
  cell.backgroundColor = [UIColor backgroundColor];
}

- (void) performLogin {
  NSString *email = self.emailTextView.text;
  User *user = [User findOrCreateByEmail: email];
  [user login];
  
  id rootController = [self.storyboard instantiateViewControllerWithIdentifier: @"PostsViewController"];
  self.navigationController.viewControllers = [NSArray arrayWithObjects:rootController, nil];
}

@end
