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

@implementation PostsViewController

- (void) viewDidLoad {
  [super viewDidLoad];
    
  [self.navigationController.navigationBar setTintColor: [UIColor navigationBarColor]];
  self.tableView.backgroundColor = [UIColor lightBackgroundColor];
  self.tableView.separatorColor = [UIColor tableSeparatorColor];
  
  [self setupDatabaseView];
  [self setupReachabilityNotification];
  
  CBLLiveQuery* query = [[[[DataStore currentDatabase] viewNamed: PostByTitleView] query] asLiveQuery];
  self.dataSource.query = query;

  self.replicator = [[Replicator alloc] init];
  [self.replicator replicateWithFilterNamed: @"Post/for_user"
                               filterParams: @{ @"user_id": [[User current] documentID] }
                                 continuous: YES];
}

- (void) setupReachabilityNotification {
  [[NSNotificationCenter defaultCenter] addObserver: self
                                           selector: @selector(handleNetworkChange:)
                                               name: kReachabilityChangedNotification object:nil];
  self.reachability = [Reachability reachabilityForInternetConnection];
  [self.reachability startNotifier];
}

- (void)handleNetworkChange:(NSNotification *)notice{
  NetworkStatus status = [self.reachability currentReachabilityStatus];
  if (!status == NotReachable) {
    [self.replicator startReplications];
  }
}

- (void) setupDatabaseView {
  [[[DataStore currentDatabase] viewNamed: PostByTitleView] setMapBlock: nil version: @"1.0"];
  
  [[[DataStore currentDatabase] viewNamed: PostByTitleView] setMapBlock: MAPBLOCK({
    NSString *type = doc[@"type"];
    NSString *title = doc[@"title"];
    NSString *userId = doc[@"user_id"];
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
  cell.textLabel.text = properties[@"title"];
  cell.detailTextLabel.text = properties[@"body"];
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
