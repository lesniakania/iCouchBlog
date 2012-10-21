//
//  DesignRepository.h
//  iCouchBlog
//
//  Created by Anna Lesniak on 10/21/12.
//  Copyright (c) 2012 Anna Lesniak. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DesignRepository : NSObject

+ (CouchDesignDocument *) designForClass: (NSString *) className;

@end
