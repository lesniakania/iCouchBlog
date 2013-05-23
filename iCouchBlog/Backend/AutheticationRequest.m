//
//  AutheticationRequest.m
//  iCouchBlog
//
//  Created by Anna Lesniak on 01.04.2013.
//  Copyright (c) 2013 Anna Lesniak. All rights reserved.
//

#import "AutheticationRequest.h"

@implementation AutheticationRequest

+ (NSDictionary *) send: (NSString *) email {
  NSMutableURLRequest *request = [[NSMutableURLRequest alloc]
                                  initWithURL: [NSURL URLWithString: AuthenticationUrl]];
  
  NSString *authStr = [NSString stringWithFormat: @"%@:%@", email, @"mypassword"];
  NSData *authData = [authStr dataUsingEncoding: NSUTF8StringEncoding];
  NSString *authValue = [NSString stringWithFormat: @"Basic %@", [authData base64EncodedString]];
  [request setValue:authValue forHTTPHeaderField: @"Authorization"];
  
  NSHTTPURLResponse *response = nil;
  NSError *error = nil;
  NSData *responseData = [NSURLConnection sendSynchronousRequest: request returningResponse:&response error: &error];
  NSString *responseString = [[NSString alloc] initWithData: responseData encoding: NSUTF8StringEncoding];
  
  NSDictionary *userData = nil;
  @try {
    userData = [responseString yajl_JSON];
  }
  @catch (id exception) {}
  return userData;
}

@end
