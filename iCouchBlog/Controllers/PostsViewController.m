//
//  PostsViewController.m
//  iCouchBlog
//
//  Created by Anna Lesniak on 8/26/12.
//  Copyright (c) 2012 Anna Lesniak. All rights reserved.
//

#import "PostsViewController.h"
#import "DetailViewController.h"
#import "EditPostViewController.h"
#import "Post.h"
#import "User.h"
#import "AppDelegate.h"

@implementation PostsViewController

- (void) viewDidLoad {
  [super viewDidLoad];
    
  [self.navigationController.navigationBar setTintColor: [UIColor navigationBarColor]];
  self.tableView.backgroundColor = [UIColor lightBackgroundColor];
  self.tableView.separatorColor = [UIColor tableSeparatorColor];
  
  [self setupDatabaseView];
  
  CBLLiveQuery* query = [[[[DataStore currentDatabase] viewNamed: PostByTitleView] query] asLiveQuery];
  query.descending = YES;
  self.dataSource.query = query;

  self.replicator = [[Replicator alloc] init];
  [self.replicator replicateWithFilterNamed: @"Post/for_user"
                               filterParams: @{ @"user_id": [[User current] documentID] }
                                 continuous: YES];
}

- (void) setupDatabaseView {
  [[[DataStore currentDatabase] viewNamed: PostByTitleView] setMapBlock: nil version: @"1.0"];
  
  [[[DataStore currentDatabase] viewNamed: PostByTitleView] setMapBlock: MAPBLOCK({
    NSString *type = [doc objectForKey: @"type"];
    NSString *title = [doc objectForKey: @"title"];
    NSString *userId = [doc objectForKey: @"user_id"];
    if ([type isEqualToString: @"Post"] && [userId isEqualToString: [[User current] documentID]]) {
      emit(title, doc);
    }
  }) version: @"1.0"];
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

- (void) couchTableSource: (CBLUITableSource*)source
              willUseCell: (UITableViewCell*)cell
                   forRow: (CBLQueryRow*)row {
  NSDictionary* properties = row.value;
  cell.textLabel.text = [properties valueForKey: @"title"];
  cell.detailTextLabel.text = [properties valueForKey: @"body"];
  cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
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
    [[segue destinationViewController] setTitle: @"Add post"];
    Post *newPost = [[Post alloc] init];
    [[segue destinationViewController] setPost: newPost];
  }
}

- (void) logout {
  [self.replicator forgetLastReplication];
  self.replicator = nil;
  
  User *currentUser = [User current];
  [currentUser logout];
  
  id rootController = [self.storyboard instantiateViewControllerWithIdentifier: @"LoginViewController"];
  self.navigationController.viewControllers = @[rootController];
}

@end
