//
//  AutheticationRequest.h
//  iCouchBlog
//
//  Created by Anna Lesniak on 01.04.2013.
//  Copyright (c) 2013 Anna Lesniak. All rights reserved.
//

#import <Foundation/Foundation.h>

#define AuthenticationUrl [NSString stringWithFormat: @"%@:3000/api/users/me", Host]

@interface AutheticationRequest : NSObject

+ (NSDictionary *) send: (NSString *) email;

@end
