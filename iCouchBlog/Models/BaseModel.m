//
//  BaseModel.m
//  iCouchBlog
//
//  Created by Anna Lesniak on 9/2/12.
//  Copyright (c) 2012 Anna Lesniak. All rights reserved.
//

#import "BaseModel.h"

@implementation BaseModel

static NSDateFormatter *dateFormatter;

+ (void) defineFilters {}

- (id) init {
  self = [self initWithNewDocumentInDatabase: [DataStore currentDatabase]];
  if (self) {
    [self setValue: NSStringFromClass([self class]) ofProperty: @"type"];
    
    NSDate *now = [NSDate date];
    [self setValue: [[[self class] dateFormatter] stringFromDate: now] ofProperty: @"created_at"];
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
