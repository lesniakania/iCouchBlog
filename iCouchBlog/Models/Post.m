//
//  Post.m
//  iCouchBlog
//
//  Created by Anna Lesniak on 8/26/12.
//  Copyright (c) 2012 Anna Lesniak. All rights reserved.
//

#import "Post.h"

@implementation Post

+ (void) defineViews {
  [[[DataStore currentDatabase] viewNamed: @"postsByTitle"] setMapBlock: MAPBLOCK({
    NSString *type = [doc objectForKey: @"type"];
    id title = [doc objectForKey: @"title"];
    if ([type isEqualToString: @"Post"] && title) emit(title, doc);
  }) reduceBlock: nil version: @"1.0"];
}

- (id) init {
  self = [super init];
  if (self) {
    [self setValue: @"8470a4c9ad09c8b397d71fece91f985f" ofProperty: @"user_id"];
  }
  return self;
}

@end
