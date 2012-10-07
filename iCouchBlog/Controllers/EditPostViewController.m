//
//  EditPostViewController.m
//  iCouchBlog
//
//  Created by Anna Lesniak on 8/26/12.
//  Copyright (c) 2012 Anna Lesniak. All rights reserved.
//

#import "EditPostViewController.h"

@implementation EditPostViewController

- (void) savePressed {
  [self.post setValue: self.titleView.text ofProperty: @"title"];
  [self.post setValue: self.bodyView.text ofProperty: @"body"];

  [self.post save];
  
  [self.navigationController popToRootViewControllerAnimated: YES];
}

@end
