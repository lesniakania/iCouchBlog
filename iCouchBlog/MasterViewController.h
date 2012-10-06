//
//  MasterViewController.h
//  iCouchBlog
//
//  Created by Anna Lesniak on 8/26/12.
//  Copyright (c) 2012 Anna Lesniak. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CouchCocoa/CouchUITableSource.h>

@class DetailViewController;

@interface MasterViewController : UITableViewController <CouchUITableDelegate>

@property (strong, nonatomic) IBOutlet CouchUITableSource* dataSource;

@end