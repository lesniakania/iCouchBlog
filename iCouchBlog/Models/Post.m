//
//  Post.m
//  iCouchBlog
//
//  Created by Anna Lesniak on 8/26/12.
//  Copyright (c) 2012 Anna Lesniak. All rights reserved.
//

#import "Post.h"
#import "User.h"

@implementation Post

+ (void) defineViews {
  [[[self class] design] defineViewNamed: @"byTitle" mapBlock: MAPBLOCK({
    NSString *type = [doc objectForKey: @"type"];
    id title = [doc objectForKey: @"title"];
    if ([type isEqualToString: @"Post"] && title) emit(title, doc);
  }) version: @"1.0"];
}

- (id) init {
  self = [super init];
  if (self) {
    [self setValue: [[[User current] document] documentID] ofProperty: @"user_id"];
  }
  return self;
}

@end
