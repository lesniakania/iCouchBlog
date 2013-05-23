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
  self.post.title = self.titleView.text;
  self.post.body = self.bodyView.text;

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
