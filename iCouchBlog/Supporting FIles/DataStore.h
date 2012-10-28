//
//  DataStore.h
//  iCouchBlog
//
//  Created by Anna Lesniak on 9/1/12.
//  Copyright (c) 2012 Anna Lesniak. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DataStore : NSObject

#define kDatabaseName @"icouch-blog"
#define kSyncURL @"http://192.168.0.107:5984/couchblog/"

+ (CouchDatabase *) currentDatabase;

@end
