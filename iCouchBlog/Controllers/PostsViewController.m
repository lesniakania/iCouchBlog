//
//  PostsViewController.m
//  iCouchBlog
//
//  Created by Anna Lesniak on 8/26/12.
//  Copyright (c) 2012 Anna Lesniak. All rights reserved.
//

#import "AppNavigationController.h"
#import "PostsViewController.h"
#import "DetailViewController.h"
#import "EditPostViewController.h"
#import "Post.h"
#import "Replicator.h"

@implementation PostsViewController
{
  PullToRefreshView *pull;
}

- (void) viewDidLoad {
  [super viewDidLoad];
  
  [self.navigationController.navigationBar setTintColor: [UIColor navigationBarColor]];
  self.tableView.backgroundColor = [UIColor lightBackgroundColor];
  self.tableView.separatorColor = [UIColor tableSeparatorColor];
  
  //pull = [[PullToRefreshView alloc] initWithScrollView: (UIScrollView *) self.tableView];
  //[pull setDelegate: self];
  //[self.tableView addSubview: pull];
  
  CouchLiveQuery* query = [[[Post design] queryViewNamed: @"byTitle"] asLiveQuery];
  self.dataSource.query = query;
    
  [self reloadTableData];
}

- (void) pullToRefreshViewShouldRefresh: (PullToRefreshView *) view {
  [self performSelectorInBackground: @selector(reloadTableData) withObject: nil];
}

- (void) reloadTableData {
  /*[[Replicator currentReplicator] replicateWithFilterNamed: @"Post/for_user"
                                              filterParams: @{ @"user_id": [[[User current] document] documentID] }
                                                    target: nil callback: @selector(callback:)
                                                continuous: YES];
  [self.dataSource.query start];
  [pull finishedLoading];*/
  
  // TODO: remove below
  [[Replicator currentReplicator] startReplication];
}

- (void) viewWillAppear: (BOOL) animated {
  [super viewWillAppear: animated];
  
  [self reloadTableData];
}

#pragma mark - Table View

- (NSInteger) numberOfSectionsInTableView: (UITableView *) tableView {
  return 1;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
  cell.backgroundColor = [UIColor backgroundColor];
  cell.textLabel.textColor = [UIColor darkTextColor];
  cell.detailTextLabel.textColor = [UIColor lightTextColor];
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

- (void) logout {
  User *currentUser = [User current];
  [currentUser logout];
  id rootController = [self.storyboard instantiateViewControllerWithIdentifier: @"LoginViewController"];
  self.navigationController.viewControllers = [NSArray arrayWithObjects: rootController, nil];
}

@end
