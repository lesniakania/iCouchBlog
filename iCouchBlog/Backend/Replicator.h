//
//  Replicator.h
//  iCouchBlog
//
//  Created by Anna Lesniak on 10/21/12.
//  Copyright (c) 2012 Anna Lesniak. All rights reserved.
//

#import <Foundation/Foundation.h>

#define kSyncURL [NSString stringWithFormat: @"%@:5984/couchblog/", Host]

@interface Replicator : NSObject

@property (strong, nonatomic) CBLReplication *pull;
@property (strong, nonatomic) CBLReplication *push;
@property (strong, nonatomic) id target;
@property (nonatomic) SEL callback;
@property (strong, nonatomic) NSDictionary *filterParams;

- (void) forgetLastReplication;

- (void) replicateWithFilterNamed: (NSString *) filterName
                     filterParams: (NSDictionary *) filterParams
                       continuous: (BOOL) continuous;

@end
