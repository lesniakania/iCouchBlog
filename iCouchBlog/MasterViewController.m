//
//  MasterViewController.m
//  iCouchBlog
//
//  Created by Anna Lesniak on 8/26/12.
//  Copyright (c) 2012 Anna Lesniak. All rights reserved.
//

#import "AppDelegate.h"
#import "MasterViewController.h"
#import "DetailViewController.h"
#import "EditPostViewController.h"
#import "Post.h"

@implementation MasterViewController

- (void) viewDidLoad {
  [super viewDidLoad];
  self.navigationItem.leftBarButtonItem = self.editButtonItem;
  
  //TODO: where to put this?
  CouchDesignDocument* design = [[DataStore currentDatabase] designDocumentWithName: @"posts"];
  [design defineViewNamed: @"byTitle" mapBlock: MAPBLOCK({
    id title = [doc objectForKey: @"title"];
    if (title) emit(title, doc);
  }) version: @"1.0"];
  
  // TODO: move it to some method and add pull to refresh
  NSArray *replications = [[DataStore currentDatabase] replicateWithURL: [NSURL URLWithString: kSyncURL] exclusively: YES];
  CouchPersistentReplication *pull = [replications objectAtIndex: 0];
  pull.filter = @"Post/for_user";
  pull.query_params = @{ @"user_id": @"75d651fda6012650a1d573795b1f46c5"};
  
  
  CouchLiveQuery* query = [[[[DataStore currentDatabase] designDocumentWithName: @"posts"]
                            queryViewNamed: @"byTitle"] asLiveQuery];
  
  self.dataSource.query = query;
}

- (void) viewWillAppear:(BOOL)animated {
  [super viewWillAppear: animated];
  [self.dataSource.query start];
}

#pragma mark - Table View

- (NSInteger) numberOfSectionsInTableView: (UITableView *) tableView {
  return 1;
}

- (void) couchTableSource: (CouchUITableSource *) source
              willUseCell: (UITableViewCell *) cell
                   forRow: (CouchQueryRow *) row {
  NSDictionary* properties = row.value;
  cell.textLabel.text = [properties valueForKey: @"title"];
  cell.detailTextLabel.text = [properties valueForKey: @"body"];
}

- (BOOL) tableView: (UITableView *) tableView canEditRowAtIndexPath: (NSIndexPath *) indexPath {
  return YES;
}

- (void) prepareForSegue: (UIStoryboardSegue *) segue sender: (id)sender {
  if ([[segue identifier] isEqualToString: @"showDetail"]) {
    NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
    Post *post = [Post modelForDocument: [self.dataSource documentAtIndexPath: indexPath]];
    [[segue destinationViewController] setPost: post];
  } else if ([[segue identifier] isEqualToString: @"addPost"]) {
    Post *newPost = [[Post alloc] init];
    [[segue destinationViewController] setPost: newPost];
  }
}

@end
