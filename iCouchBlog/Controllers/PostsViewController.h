//
//  PostsViewController.h
//  iCouchBlog
//
//  Created by Anna Lesniak on 8/26/12.
//  Copyright (c) 2012 Anna Lesniak. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CouchCocoa/CouchUITableSource.h>
#import "PullToRefreshView.h"

@class DetailViewController;

@interface PostsViewController : UITableViewController <CouchUITableDelegate, PullToRefreshViewDelegate> {
  CouchPersistentReplication* _pull;
  CouchPersistentReplication* _push;
}

@property (strong, nonatomic) IBOutlet CouchUITableSource* dataSource;


- (IBAction) logout;

@end
