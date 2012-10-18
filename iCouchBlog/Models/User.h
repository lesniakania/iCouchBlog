//
//  User.h
//  iCouchBlog
//
//  Created by Anna Lesniak on 10/16/12.
//  Copyright (c) 2012 Anna Lesniak. All rights reserved.
//

#import "BaseModel.h"

@interface User : BaseModel

+ (User *) findByEmail: (NSString *) anEmail;
+ (User *) findOrCreateByEmail: (NSString *) anEmail;
+ (NSString *) emailFromSettings;
- (void) login;

@end
