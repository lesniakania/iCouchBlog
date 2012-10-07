//
//  DataStore.h
//  iCouchBlog
//
//  Created by Anna Lesniak on 9/1/12.
//  Copyright (c) 2012 Anna Lesniak. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DataStore : NSObject

+ (CouchDatabase *) currentDatabase;

@end
