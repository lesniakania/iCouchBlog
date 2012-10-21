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
  [[[self class] design] defineViewNamed: @"byTitle" mapBlock: MAPBLOCK({
    id title = [doc objectForKey: @"title"];
    if (title) emit(title, doc);
  }) version: @"1.0"];
}

@end
