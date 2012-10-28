//
//  DetailViewController.h
//  iCouchBlog
//
//  Created by Anna Lesniak on 8/26/12.
//  Copyright (c) 2012 Anna Lesniak. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Post.h"

@interface DetailViewController : UIViewController

@property (strong, nonatomic) Post *post;

@property (strong, nonatomic) IBOutlet UITextView *titleView;
@property (strong, nonatomic) IBOutlet UITextView *bodyView;
@property (strong, nonatomic) IBOutlet UILabel *titleLabel;
@property (strong, nonatomic) IBOutlet UILabel *bodyLabel;

- (IBAction) deletePressed;

@end
