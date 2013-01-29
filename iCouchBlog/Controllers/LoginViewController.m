//
//  LoginViewController.m
//  iCouchBlog
//
//  Created by Anna Lesniak on 10/7/12.
//  Copyright (c) 2012 Anna Lesniak. All rights reserved.
//

#import "LoginViewController.h"
#import "User.h"
#import "Connector.h"

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
  if (user) {
    [self performLoginWithUser: user];
  } else {
    user = [User createWith: [Connector loginUserWithEmail: email]];
    RESTOperation *op = [user save];
    [op onCompletion: ^{
      if (op.error) {
        NSLog(@"Couldn't save the user %@, error: %@", user, op.error);
      } else {
        [self performLoginWithUser: user];
      }
    }];
    [op start];
  }  
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
