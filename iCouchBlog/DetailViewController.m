//
//  DetailViewController.m
//  iCouchBlog
//
//  Created by Anna Lesniak on 8/26/12.
//  Copyright (c) 2012 Anna Lesniak. All rights reserved.
//

#import "DetailViewController.h"

@interface DetailViewController ()
@property (strong, nonatomic) UIPopoverController *masterPopoverController;
- (void)configureView;
@end

@implementation DetailViewController

#pragma mark - Managing the detail item

- (void) setDetailItem: (id) newPost
{
    if (_post != newPost) {
        _post = newPost;
        
        [self configureView];
    }

    if (self.masterPopoverController != nil) {
        [self.masterPopoverController dismissPopoverAnimated: YES];
    }        
}

- (void) configureView
{
  if (self.post) {
    self.titleView.text = [self.post title];
    self.bodyView.text = [self.post body];
  }
}

- (void) viewDidLoad
{
    [super viewDidLoad];
    [self configureView];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
}

- (BOOL) shouldAutorotateToInterfaceOrientation: (UIInterfaceOrientation) interfaceOrientation
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
    } else {
        return YES;
    }
}

#pragma mark - Split view

- (void) splitViewController: (UISplitViewController *) splitController
      willHideViewController: (UIViewController *)viewController
           withBarButtonItem: (UIBarButtonItem *) barButtonItem
        forPopoverController: (UIPopoverController *)popoverController
{
    barButtonItem.title = NSLocalizedString(@"Master", @"Master");
    [self.navigationItem setLeftBarButtonItem: barButtonItem animated: YES];
    self.masterPopoverController = popoverController;
}

- (void) splitViewController: (UISplitViewController *) splitController
      willShowViewController: (UIViewController *) viewController
   invalidatingBarButtonItem: (UIBarButtonItem *) barButtonItem
{
    // Called when the view is shown again in the split view, invalidating the button and popover controller.
    [self.navigationItem setLeftBarButtonItem: nil animated: YES];
    self.masterPopoverController = nil;
}

@end
