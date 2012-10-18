//
//  LoginViewController.h
//  iCouchBlog
//
//  Created by Anna Lesniak on 10/7/12.
//  Copyright (c) 2012 Anna Lesniak. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginViewController : UITableViewController

@property (weak, nonatomic) IBOutlet UILabel *emailLabel;
@property (weak, nonatomic) IBOutlet UITextView *emailTextView;

- (IBAction) performLogin;

@end
