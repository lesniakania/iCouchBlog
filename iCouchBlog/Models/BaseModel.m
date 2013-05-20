//
//  BaseModel.m
//  iCouchBlog
//
//  Created by Anna Lesniak on 9/2/12.
//  Copyright (c) 2012 Anna Lesniak. All rights reserved.
//

#import "BaseModel.h"

@implementation BaseModel

@dynamic type, created_at, updated_at;

+ (void) defineFilters {}

- (id) init {
  self = [self initWithNewDocumentInDatabase: [DataStore currentDatabase]];
  if (self) {
    self.type = NSStringFromClass([self class]);
    self.created_at = [NSDate date];
  }
  return self;
}

+ (id) modelForDocumentWithId: (NSString *) docId {
  CBLDocument *document = [[DataStore currentDatabase] documentWithID: docId];
  return [[self class] modelForDocument: document];
}

- (BOOL) save: (NSError **) outError {
  self.updated_at = [NSDate date];
  
  return [super save: outError];
}

@end
