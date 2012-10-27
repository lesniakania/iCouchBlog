//
//  Replicator.h
//  iCouchBlog
//
//  Created by Anna Lesniak on 10/21/12.
//  Copyright (c) 2012 Anna Lesniak. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Replicator : NSObject

@property (weak, nonatomic) CouchPersistentReplication *pull;
@property (weak, nonatomic) CouchPersistentReplication *push;
@property (strong, nonatomic) id target;
@property (nonatomic) SEL callback;
@property (strong, nonatomic) NSDictionary *filterParams;

+ (Replicator *) currentReplicator;

- (void) forgetLastReplication;

- (void) replicateWithFilterNamed: (NSString *) filterName
                     filterParams: (NSDictionary *) filterParams
                           target: (id) target
                         callback: (SEL) callback
                       continuous: (BOOL) continuous;

- (void) pullWithFilterNamed: (NSString *) filterName
                filterParams: (NSDictionary *) filterParams
                      target: (id) target
                    callback: (SEL) callback
                  continuous: (BOOL) continuous;

@end
