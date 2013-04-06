//
//  EditPostViewController.m
//  iCouchBlog
//
//  Created by Anna Lesniak on 8/26/12.
//  Copyright (c) 2012 Anna Lesniak. All rights reserved.
//

#import "EditPostViewController.h"
#import "User.h"

@implementation EditPostViewController

- (void) savePressed {
  [self.post setValue: self.titleView.text ofProperty: @"title"];
  [self.post setValue: self.bodyView.text ofProperty: @"body"];
  NSDate *now = [NSDate date];
  [self.post setValue: [[Post dateFormatter] stringFromDate: now] ofProperty: @"updated_at"];

  NSError *error;
  [self.post save: &error];
  if (error) {
      NSLog(@"Couldn't save the post %@", self);
  } else {
    [[User current] addPost: self.post];
    [self.navigationController popToRootViewControllerAnimated: YES];
	}
}

@end
