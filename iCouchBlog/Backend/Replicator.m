//
//  Replicator.m
//  iCouchBlog
//
//  Created by Anna Lesniak on 10/21/12.
//  Copyright (c) 2012 Anna Lesniak. All rights reserved.
//

#import "Replicator.h"

@implementation Replicator

- (void) replicationProgress: (NSNotificationCenter*) nctr {
  if (self.pull.mode == kCBLReplicationActive || self.push.mode == kCBLReplicationActive) {
    unsigned completed = self.pull.completed + self.push.completed;
    unsigned total = self.pull.total + self.push.total;
    NSLog(@"Replication progress: %u / %u", completed, total);
  } else {
    NSLog(@"Replication finished.");
  }
}

- (void) replicateWithFilterNamed: (NSString *) filterName
                     filterParams: (NSDictionary *) filterParams
                           target: (id) target
                         callback: (SEL) callback
                       continuous: (BOOL) continuous {
  [self forgetLastReplication];
  NSArray* replications = [[DataStore currentDatabase] replicateWithURL: [NSURL URLWithString: kSyncURL]
                                                            exclusively: YES];
  self.filterParams = filterParams;
  
  self.pull = [replications objectAtIndex: 0];
  self.pull.filter = filterName;
  self.pull.query_params = filterParams;
  self.pull.continuous = continuous;
  
  self.push = [replications objectAtIndex: 1];
  self.push.continuous = continuous;
  
  self.target = target;
  self.callback = callback;
  
  NSNotificationCenter* nctr = [NSNotificationCenter defaultCenter];
  [nctr addObserver: self selector: @selector(replicationProgress:)
               name: kCBLReplicationChangeNotification object: self.pull];
  [nctr addObserver: self selector: @selector(replicationProgress:)
               name: kCBLReplicationChangeNotification object: self.push];
}

- (void) forgetLastReplication {
  NSNotificationCenter* nctr = [NSNotificationCenter defaultCenter];
  if (self.pull) {
    [nctr removeObserver: self name: nil object: self.pull];
    self.pull = nil;
  }
  if (self.push) {
    [nctr removeObserver: self name: nil object: self.push];
    self.push = nil;
  }
}

@end
