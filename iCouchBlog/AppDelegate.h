//
//  AppDelegate.h
//  iCouchBlog
//
//  Created by Anna Lesniak on 8/26/12.
//  Copyright (c) 2012 Anna Lesniak. All rights reserved.
//

#import <UIKit/UIKit.h>

#define kDatabaseName @"icouch-blog"
#define kSyncURL @"http://localhost:5984/couchblog/"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@end
