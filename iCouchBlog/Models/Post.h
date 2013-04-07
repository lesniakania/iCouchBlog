//
//  Post.h
//  iCouchBlog
//
//  Created by Anna Lesniak on 8/26/12.
//  Copyright (c) 2012 Anna Lesniak. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseModel.h"

#define PostByTitleView @"postsByTitle"
#define PostByConflicts @"postByConflicts"

@interface Post : BaseModel

@property (strong, nonatomic) NSString *title;
@property (strong, nonatomic) NSString *body;
@property (strong, nonatomic) NSString *user_id;

@end
