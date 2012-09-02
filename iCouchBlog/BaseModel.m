//
//  BaseModel.m
//  iCouchBlog
//
//  Created by Anna Lesniak on 9/2/12.
//  Copyright (c) 2012 Anna Lesniak. All rights reserved.
//

#import "BaseModel.h"

@implementation BaseModel

+ (id) withDocument: (CouchDocument *) document
{
  return [self withProperties: [document properties]];
}

+ (id) withProperties: (NSDictionary *) properties
{
  BaseModel *model = [[[self class] alloc] init];
  for (NSString *property in properties) {
    [model setValue: [properties valueForKey: property] forKey: property];
  }
  return model;
}

@end
