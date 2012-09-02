//
//  Post.m
//  iCouchBlog
//
//  Created by Anna Lesniak on 8/26/12.
//  Copyright (c) 2012 Anna Lesniak. All rights reserved.
//

#import "Post.h"

@implementation Post

- (void) save
{
  CouchDocument *doc = [[DataStore currentDatabase] untitledDocument];
  RESTOperation *op = [doc putProperties: @{ @"title" : self.title, @"body" : self.body }];
  [op onCompletion: ^{
    if (op.error)
      NSLog(@"Couldn't save the post %@", self);
	}];
  [op start];
}

@end
