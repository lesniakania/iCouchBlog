//
//  DataStore.h
//  iCouchBlog
//
//  Created by Anna Lesniak on 9/1/12.
//  Copyright (c) 2012 Anna Lesniak. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Connector.h"

@interface DataStore : NSObject

#define kDatabaseName @"icouch-blog"
#define kSyncURL [NSString stringWithFormat: @"http://%@:5984/couchblog/", kHOST]

+ (CouchDatabase *) currentDatabase;

@end
