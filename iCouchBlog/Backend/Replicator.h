//
//  Replicator.h
//  iCouchBlog
//
//  Created by Anna Lesniak on 10/21/12.
//  Copyright (c) 2012 Anna Lesniak. All rights reserved.
//

#import <Foundation/Foundation.h>

#define kSyncURL @"http://192.168.0.114:5984/couchblog/"

@interface Replicator : NSObject

@property (strong, nonatomic) CBLReplication *pull;
@property (strong, nonatomic) CBLReplication *push;
@property (strong, nonatomic) id target;
@property (nonatomic) SEL callback;
@property (strong, nonatomic) NSDictionary *filterParams;

- (void) forgetLastReplication;

- (void) replicateWithFilterNamed: (NSString *) filterName
                     filterParams: (NSDictionary *) filterParams
                           target: (id) target
                         callback: (SEL) callback
                       continuous: (BOOL) continuous;

@end
