//
//  BaseModel.m
//  iCouchBlog
//
//  Created by Anna Lesniak on 9/2/12.
//  Copyright (c) 2012 Anna Lesniak. All rights reserved.
//

#import "BaseModel.h"
#import "DesignRepository.h"

@implementation BaseModel

static NSDateFormatter *dateFormatter;

+ (CouchDesignDocument *) design {
  NSString *className = NSStringFromClass(self);
  return [DesignRepository designForClass: className];
}

+ (void) defineViews {}

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
  CouchDocument *document = [[DataStore currentDatabase] documentWithID: docId];
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
