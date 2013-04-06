//
//  LoginViewController.m
//  iCouchBlog
//
//  Created by Anna Lesniak on 10/7/12.
//  Copyright (c) 2012 Anna Lesniak. All rights reserved.
//

#import "LoginViewController.h"
#import "User.h"
#import "AppDelegate.h"
#import "AutheticationRequest.h"

@implementation LoginViewController

- (void) viewDidLoad {
  [super viewDidLoad];
    
  self.view.backgroundColor = [UIColor navigationBarColor];
  [self.navigationController.navigationBar setTintColor: [UIColor navigationBarColor]];
  
  self.emailLabel.textColor = [UIColor darkTextColor];
  self.emailTextField.textColor = [UIColor darkTextColor];
  self.emailTextField.backgroundColor = [UIColor lightBackgroundColor];
}

- (void) tableView: (UITableView *) tableView willDisplayCell: (UITableViewCell *) cell forRowAtIndexPath: (NSIndexPath *) indexPath {
  cell.backgroundColor = [UIColor backgroundColor];
}

- (void) loginPressed {
  NSString *email = self.emailTextField.text;
  
  User *user = [User findByEmail: email];
  if (!user) {
    user = [self createUserFromServer: email];
  }
  [self performLoginWithUser: user];
}

- (User *) createUserFromServer: (NSString *) email {
  User *user = nil;
  NSDictionary *userData = [AutheticationRequest send: email];
  if (userData) {
    user = [User createWith: userData];
  }
  return user;
}

- (void) performLoginWithUser: (User *) user {
  if ([user login]) {
    [self loginSuccessful];
  } else {
    [self loginFailed];
  }
}

- (void) loginSuccessful {
  id rootController = [self.storyboard instantiateViewControllerWithIdentifier: @"PostsViewController"];
  self.navigationController.viewControllers = @[rootController];
}

- (void) loginFailed {
  [[[UIAlertView alloc] initWithTitle: @"Login Error" message: @"Login failed." delegate: self cancelButtonTitle: @"Ok" otherButtonTitles: nil] show];
}

- (BOOL) textFieldShouldReturn: (UITextField *) theTextField {
  [self loginPressed];
  return YES;
}

@end
