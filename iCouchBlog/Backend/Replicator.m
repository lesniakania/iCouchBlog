//
//  Replicator.m
//  iCouchBlog
//
//  Created by Anna Lesniak on 10/21/12.
//  Copyright (c) 2012 Anna Lesniak. All rights reserved.
//

#import "Replicator.h"
#import "Post.h"

@implementation Replicator

- (void) replicationProgress: (NSNotificationCenter*) nctr {
  if (self.pull.mode == kCBLReplicationActive || self.push.mode == kCBLReplicationActive) {
    unsigned completed = self.pull.completed + self.push.completed;
    unsigned total = self.pull.total + self.push.total;
    
    NSLog(@"Replication progress: %u / %u", completed, total);
  } else {
    NSLog(@"Replication finished.");
    
    CBLQuery* query = [[[DataStore currentDatabase] viewNamed: PostByConflicts] query];
    NSLog(@"<CONFLICTS>");
    for (CBLQueryRow *row in query.rows) {
      NSError *error = nil;
    
      NSLog(@"<CONFLICTING REVISIONS FOR %@>", row.documentID);
      for (CBLRevision *revision in [row.document getConflictingRevisions: &error]) {
        NSLog(@"%@", revision.properties);
      }
      NSLog(@"</CONFLICTING REVISIONS FOR %@>", row.documentID);
    }
    NSLog(@"</CONFLICTS>");
  }
}

- (void) replicateWithFilterNamed: (NSString *) filterName
                     filterParams: (NSDictionary *) filterParams
                       continuous: (BOOL) continuous {
  [self forgetLastReplication];
  NSArray* replications = [[DataStore currentDatabase] replicateWithURL: [NSURL URLWithString: kSyncURL]
                                                            exclusively: YES];
  
  for (CBLReplication *replication in replications) {
    replication.filter = filterName;
    replication.query_params = filterParams;
    replication.continuous = continuous;
  }
  
  self.pull = [replications objectAtIndex: 0];
  self.push = [replications objectAtIndex: 1];
  
  NSNotificationCenter* nctr = [NSNotificationCenter defaultCenter];
  [nctr addObserver: self selector: @selector(replicationProgress:)
               name: kCBLReplicationChangeNotification object: self.pull];
  [nctr addObserver: self selector: @selector(replicationProgress:)
               name: kCBLReplicationChangeNotification object: self.push];
  
  [self startReplications];
}

- (void) startReplications {
  [self.pull start];
  [self.push start];
}

- (void) forgetLastReplication {
  NSNotificationCenter* nctr = [NSNotificationCenter defaultCenter];
  if (self.pull) {
    [self.pull stop];
    [nctr removeObserver: self name: nil object: self.pull];
    self.pull = nil;
  }
  if (self.push) {
    [self.push stop];
    [nctr removeObserver: self name: nil object: self.push];
    self.push = nil;
  }
}

@end
