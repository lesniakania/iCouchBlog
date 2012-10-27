//
//  LoginViewController.m
//  iCouchBlog
//
//  Created by Anna Lesniak on 10/7/12.
//  Copyright (c) 2012 Anna Lesniak. All rights reserved.
//

#import "LoginViewController.h"
#import "User.h"
#import "Replicator.h"

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

- (void) performLogin {
  NSString *email = self.emailTextField.text;
  
  User *user = [User findByEmail: email];
  NSDictionary *filterParams = @{ @"email": email };
  if (user) {
    [self loginWith: filterParams];
  } else {
    [[Replicator currentReplicator] pullWithFilterNamed: @"User/for_email"
                                           filterParams: filterParams
                                                 target: self
                                               callback: @selector(loginWith:)
                                             continuous: NO];
  }
}

- (void) loginWith: (NSDictionary *) filterParams {
  NSString *email = [filterParams objectForKey: @"email"];
  if ([User loginWithEmail: email]) {
    [self loginSuccessful];
  } else {
    [self loginFailed];
  }
}

- (void) loginSuccessful {
  id rootController = [self.storyboard instantiateViewControllerWithIdentifier: @"PostsViewController"];
  self.navigationController.viewControllers = [NSArray arrayWithObjects: rootController, nil];
}

- (void) loginFailed {
  [[[UIAlertView alloc] initWithTitle: @"Login Error" message: @"Login failed." delegate: self cancelButtonTitle: @"Ok" otherButtonTitles: nil] show];
}

- (BOOL) textFieldShouldReturn: (UITextField *) theTextField {
  [self performLogin];
  return YES;
}

@end
