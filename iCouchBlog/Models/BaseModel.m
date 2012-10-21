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

+ (CouchDesignDocument *) design {
  NSString *className = NSStringFromClass(self);
  return [DesignRepository designForClass: className];
}

+ (void) defineViews {}

- (id) init {
  return [self initWithNewDocumentInDatabase: [DataStore currentDatabase]];
}

- (void) save {
  RESTOperation *op = [super save];
  [op onCompletion: ^{
    if (op.error)
      NSLog(@"Couldn't save the post %@", self);
	}];
  [op start];
}


@end
