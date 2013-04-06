//
//  PostsViewController.h
//  iCouchBlog
//
//  Created by Anna Lesniak on 8/26/12.
//  Copyright (c) 2012 Anna Lesniak. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Couchbaselite/CBLUITableSource.h>
#import "Replicator.h"
#import "Reachability.h"

@class DetailViewController;

@interface PostsViewController : UITableViewController <CBLUITableDelegate>

@property (strong, nonatomic) IBOutlet CBLUITableSource* dataSource;

@property (strong, nonatomic) Replicator *replicator;
@property (strong, nonatomic) Reachability *reachability;

- (IBAction) logout;

@end
