//
//  BaseModel.m
//  iCouchBlog
//
//  Created by Anna Lesniak on 9/2/12.
//  Copyright (c) 2012 Anna Lesniak. All rights reserved.
//

#import "BaseModel.h"

static NSDateFormatter *dateFormatter;

@implementation BaseModel

@dynamic type, created_at, updated_at;

+ (void) defineFilters {}

- (id) init {
  self = [self initWithNewDocumentInDatabase: [DataStore currentDatabase]];
  if (self) {
    self.type = NSStringFromClass([self class]);
    self.created_at = [[[self class] dateFormatter] stringFromDate: [NSDate date]];
  }
  return self;
}

+ (id) modelForDocumentWithId: (NSString *) docId {
  CBLDocument *document = [[DataStore currentDatabase] documentWithID: docId];
  return [[self class] modelForDocument: document];
}

+ (NSDateFormatter *) dateFormatter {
  if (!dateFormatter) {
    dateFormatter = [[NSDateFormatter alloc] init];
  }
  [dateFormatter setDateFormat: @"yyyy-MM-ddTHH:mm.sssZ"];
  
  return dateFormatter;
}

@end
