//
//  DesignRepository.m
//  iCouchBlog
//
//  Created by Anna Lesniak on 10/21/12.
//  Copyright (c) 2012 Anna Lesniak. All rights reserved.
//

#import "DesignRepository.h"

@implementation DesignRepository

static NSMutableDictionary *repository;

+ (CouchDesignDocument *) designForClass: (NSString *) className {
  if (!repository) {
    repository = [[NSMutableDictionary alloc] init];
  }
  
  CouchDesignDocument *design = [repository objectForKey: className];
  if (!design) {
    design = [[DataStore currentDatabase] designDocumentWithName: className];
    [repository setObject: design forKey: className];
  }
  return design;
}

@end
