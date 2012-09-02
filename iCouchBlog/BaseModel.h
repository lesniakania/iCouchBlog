//
//  BaseModel.h
//  iCouchBlog
//
//  Created by Anna Lesniak on 9/2/12.
//  Copyright (c) 2012 Anna Lesniak. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BaseModel : NSObject

@property (strong, nonatomic) NSString *_id;
@property (strong, nonatomic) NSString *_rev;

+ (id) withDocument: (CouchDocument *) document;
+ (id) withProperties: (NSDictionary *) properties;

@end
