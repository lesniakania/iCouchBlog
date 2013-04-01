//
//  DataStore.m
//  iCouchBlog
//
//  Created by Anna Lesniak on 9/1/12.
//  Copyright (c) 2012 Anna Lesniak. All rights reserved.
//

#import "AppDelegate.h"
#import "DataStore.h"

@implementation DataStore

+ (CBLDatabase *) currentDatabase
{
  id delegate = [[UIApplication sharedApplication] delegate];
  return [delegate database];
}

@end
