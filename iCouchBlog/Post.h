//
//  Post.h
//  iCouchBlog
//
//  Created by Anna Lesniak on 8/26/12.
//  Copyright (c) 2012 Anna Lesniak. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseModel.h"

@interface Post : BaseModel

@property (strong, nonatomic) NSString *title;
@property (strong, nonatomic) NSString *body;

- (void) save;

@end
