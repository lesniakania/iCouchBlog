//
//  DetailViewController.m
//  iCouchBlog
//
//  Created by Anna Lesniak on 8/26/12.
//  Copyright (c) 2012 Anna Lesniak. All rights reserved.
//

#import "DetailViewController.h"

@interface DetailViewController ()
- (void) configureView;
@end

@implementation DetailViewController

#pragma mark - Managing the detail item


- (void) configureView {
  if (self.post) {
    self.titleView.text = [self.post getValueOfProperty: @"title"];
    self.bodyView.text = [self.post getValueOfProperty: @"body"];
  }
}

- (void) viewDidLoad {
  [super viewDidLoad];
  [self configureView];
}

- (void) prepareForSegue: (UIStoryboardSegue *) segue sender: (id)sender {
  if ([[segue identifier] isEqualToString: @"editPost"]) {
    [[segue destinationViewController] setPost: self.post];
  }
}

@end
