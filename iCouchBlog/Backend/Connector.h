//
//  Connector.h
//  iCouchBlog
//
//  Created by Anna Lesniak on 1/29/13.
//  Copyright (c) 2013 Anna Lesniak. All rights reserved.
//

#import <Foundation/Foundation.h>

#define kHOST @"192.168.0.110"
#define kApiURL [NSString stringWithFormat: @"http://%@:3000/api", kHOST]

@interface Connector : NSObject

+ (NSDictionary *) loginUserWithEmail: (NSString *) email;

@end
