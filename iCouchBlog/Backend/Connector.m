//
//  Connector.m
//  iCouchBlog
//
//  Created by Anna Lesniak on 1/29/13.
//  Copyright (c) 2013 Anna Lesniak. All rights reserved.
//

#import "Connector.h"

@implementation Connector

+ (NSDictionary *) loginUserWithEmail: (NSString *) email {
  NSString *showURL = [NSString stringWithFormat: @"%@/users/me/?email=%@", kApiURL, email];
  NSURLRequest *request = [NSURLRequest requestWithURL: [NSURL URLWithString: showURL]];
  NSURLResponse *response = nil;
  NSError *error = nil;
  NSData *data = [NSURLConnection sendSynchronousRequest: request returningResponse: &response error: &error];
  return [data yajl_JSON];
}

@end
