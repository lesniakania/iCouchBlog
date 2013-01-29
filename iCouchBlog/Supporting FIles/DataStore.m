//
//  DataStore.m
//  iCouchBlog
//
//  Created by Anna Lesniak on 9/1/12.
//  Copyright (c) 2012 Anna Lesniak. All rights reserved.
//

#import "AppDelegate.h"
#import "DataStore.h"

static CouchDatabase *currentDatabase;

@implementation DataStore

+ (CouchDatabase *) currentDatabase
{
  if (!currentDatabase) {
    CouchTouchDBServer *server = [[CouchTouchDBServer alloc] init];
    
    if (server.error) {
      NSLog(@"Couldn't start Couchbase. Error: %@", server.error);
      return nil;
    }
    
    currentDatabase = [server databaseNamed: kDatabaseName];

    
    // Create the database on the first run of the app.
    NSError* error;
    if (![currentDatabase ensureCreated: &error]) {
      NSLog(@"Couldn't create local database. Error: %@", error);
      return nil;
    }
    
    currentDatabase.tracksChanges = YES;
  }
  return currentDatabase;
}

@end
