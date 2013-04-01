//
//  PostsViewController.h
//  iCouchBlog
//
//  Created by Anna Lesniak on 8/26/12.
//  Copyright (c) 2012 Anna Lesniak. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Couchbaselite/CBLUITableSource.h>

@class DetailViewController;

@interface PostsViewController : UITableViewController <CBLUITableDelegate>

@property (strong, nonatomic) IBOutlet CBLUITableSource* dataSource;

@end
