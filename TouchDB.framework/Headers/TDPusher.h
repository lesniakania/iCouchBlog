//
//  TDPusher.h
//  TouchDB
//
//  Created by Jens Alfke on 12/5/11.
//  Copyright (c) 2011 Couchbase, Inc. All rights reserved.
//

#import "TDPuller.h"
#import <TouchDB/TDDatabase.h>


/** Replicator that pushes to a remote CouchDB. */
@interface TDPusher : TDReplicator
{
    BOOL _createTarget;
    BOOL _observing;
}

@property BOOL createTarget;

@end
