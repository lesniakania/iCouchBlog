//
//  MasterViewController.m
//  iCouchBlog
//
//  Created by Anna Lesniak on 8/26/12.
//  Copyright (c) 2012 Anna Lesniak. All rights reserved.
//

#import "MasterViewController.h"
#import "DetailViewController.h"
#import "EditPostViewController.h"
#import "Post.h"

@interface MasterViewController () {}
@end

@implementation MasterViewController

- (void) awakeFromNib
{
  if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
    self.clearsSelectionOnViewWillAppear = NO;
    self.contentSizeForViewInPopover = CGSizeMake(320.0, 600.0);
  }
  [super awakeFromNib];
}

- (void) viewDidLoad
{
  [super viewDidLoad];
  self.navigationItem.leftBarButtonItem = self.editButtonItem;
  
  CouchDesignDocument* design = [[DataStore currentDatabase] designDocumentWithName: @"posts"];
  [design defineViewNamed: @"byTitle" mapBlock: MAPBLOCK({
    id title = [doc objectForKey: @"title"];
    if (title) emit(title, doc);
  }) version: @"1.0"];
  
  CouchLiveQuery* query = [[[[DataStore currentDatabase] designDocumentWithName: @"posts"]
                            queryViewNamed: @"byTitle"] asLiveQuery];
  
  self.dataSource.query = query;
}

- (void) viewWillAppear:(BOOL)animated
{
  [super viewWillAppear: animated];
  [self.dataSource.query start];
}

- (BOOL) shouldAutorotateToInterfaceOrientation: (UIInterfaceOrientation) interfaceOrientation
{
  if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
  } else {
    return YES;
  }
}

#pragma mark - Table View

- (NSInteger) numberOfSectionsInTableView: (UITableView *) tableView
{
  return 1;
}

- (void) couchTableSource: (CouchUITableSource *) source
              willUseCell: (UITableViewCell *) cell
                   forRow: (CouchQueryRow *) row
{
  NSDictionary* properties = row.value;
  cell.textLabel.text = [properties valueForKey: @"title"];
  cell.detailTextLabel.text = [properties valueForKey: @"body"];
}

- (BOOL) tableView: (UITableView *) tableView canEditRowAtIndexPath: (NSIndexPath *) indexPath
{
  return YES;
}

- (void) prepareForSegue: (UIStoryboardSegue *) segue sender: (id)sender
{
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
