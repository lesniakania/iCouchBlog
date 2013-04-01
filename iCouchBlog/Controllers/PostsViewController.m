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
#import "AppDelegate.h"

@implementation PostsViewController

- (void) viewDidLoad {
  [super viewDidLoad];
    
  [self.navigationController.navigationBar setTintColor: [UIColor navigationBarColor]];
  self.tableView.backgroundColor = [UIColor lightBackgroundColor];
  self.tableView.separatorColor = [UIColor tableSeparatorColor];
  
  CBLLiveQuery* query = [[[[DataStore currentDatabase] viewNamed:@"postsByTitle"] query] asLiveQuery];
  self.dataSource.query = query;

  AppDelegate *delegate = [[UIApplication sharedApplication] delegate];
  NSString *userID = @"8470a4c9ad09c8b397d71fece91f985f";
  [delegate.postsReplicator replicateWithFilterNamed: @"Post/for_user"
                                        filterParams: @{ @"user_id": userID }
                                              target: nil
                                            callback: @selector(callback:)
                                          continuous: YES];
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

- (void)couchTableSource:(CBLUITableSource*)source
             willUseCell:(UITableViewCell*)cell
                  forRow:(CBLQueryRow*)row {
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

@end
