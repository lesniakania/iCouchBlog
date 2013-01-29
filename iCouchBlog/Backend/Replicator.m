//
//  Replicator.m
//  iCouchBlog
//
//  Created by Anna Lesniak on 10/21/12.
//  Copyright (c) 2012 Anna Lesniak. All rights reserved.
//

#import "Replicator.h"
#import "User.h"

#define kTimeout 15.0
#define kTimeoutStep 0.1

@implementation Replicator

static Replicator *replicator;

+ (Replicator *) currentReplicator {
  if (!replicator) {
    replicator = [[Replicator alloc] init];
  }
  return replicator;
}

- (void) startReplication {
  [self forgetSync];
  
  NSArray* repls = [[DataStore currentDatabase] replicateWithURL: [NSURL URLWithString: kSyncURL]
                                                     exclusively: YES];
  self.pull = [repls objectAtIndex: 0];
  self.push = [repls objectAtIndex: 1];
  [self.pull addObserver: self forKeyPath: @"completed" options: 0 context: NULL];
  [self.push addObserver: self forKeyPath: @"completed" options: 0 context: NULL];
}

- (void) forgetSync {
  [self.pull removeObserver: self forKeyPath: @"completed"];
  self.pull = nil;
  [self.push removeObserver: self forKeyPath: @"completed"];
  self.push = nil;
}

- (void) observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object
                         change:(NSDictionary *)change context:(void *)context
{
  if (object == self.pull || object == self.push) {
    unsigned completed = self.pull.completed + self.push.completed;
    unsigned total = self.pull.total + self.push.total;
    NSLog(@"SYNC progress: %u / %u", completed, total);
    if (total > 0 && completed < total) {
      
    } else {
      NSLog(@"COMPLETED!");
      //[self.target performSelector: self.callback withObject: self.filterParams];
      [self.target performSelector: self.callback];
    }
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
  //self.filterParams = filterParams;
  
  self.pull = [replications objectAtIndex: 0];
  //self.pull.filter = filterName;
  //self.pull.query_params = filterParams;
  //self.pull.continuous = continuous;
  
  self.push = [replications objectAtIndex: 1];
  //self.push.continuous = continuous;
  
  self.target = target;
  self.callback = callback;
  [self.pull addObserver: self forKeyPath: @"completed" options: 0 context: NULL];
  [self.push addObserver: self forKeyPath: @"completed" options: 0 context: NULL];
}

- (void) pullWithFilterNamed: (NSString *) filterName
                filterParams: (NSDictionary *) filterParams
                      target: (id) target
                    callback: (SEL) callback
                  continuous: (BOOL) continuous {
  CouchReplication *pull = [[DataStore currentDatabase] pullFromDatabaseAtURL: [NSURL URLWithString: kSyncURL]];
  pull.filter = filterName;
  pull.filterParams = filterParams;
  pull.continuous = continuous;
  
  RESTOperation *op = [pull start];
  [op wait];
  
  NSTimeInterval timeout = kTimeoutStep;
  while(timeout < kTimeout && pull.running){
    timeout += kTimeoutStep;
    [[NSRunLoop currentRunLoop] runUntilDate:[NSDate dateWithTimeIntervalSinceNow: kTimeoutStep]];
  }
  
  [pull stop];
  pull = nil;
  [target performSelector: callback withObject: filterParams];
}

- (void) forgetLastReplication {
  @try{
    [self.pull removeObserver: self forKeyPath: @"completed"];
    [self.push removeObserver: self forKeyPath: @"completed"];
  } @catch (id exception) {
  
  }
  self.pull = nil;
  self.push = nil;
}

/*- (void) observeValueForKeyPath: (NSString *) keyPath ofObject: (id) object
                         change: (NSDictionary *) change context: (void *)context {
  if (object == self.pull || object == self.push) {
    if ([self.pull state] == kReplicationCompleted && [self.push state] == kReplicationCompleted) {
      [self.target performSelector: self.callback withObject: self.filterParams];
    }
  }
}*/

@end
