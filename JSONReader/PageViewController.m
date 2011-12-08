//
//  PageViewController.m
//  JSONReader
//
//  Created by Anh on 12/8/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "PageViewController.h"
#import "JSONReaderAppDelegate.h"


@implementation PageViewController

@synthesize titleLabel;
@synthesize authorLabel;
@synthesize dateLabel;
@synthesize articleView;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)dealloc
{
    [titleLabel release];
    [authorLabel release];
    [dateLabel release];
    [articleView release];
    
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView
{
}
*/

/*
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
}
*/

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;

    self.titleLabel = nil;
    self.authorLabel = nil;
    self.dateLabel = nil;
    self.articleView = nil;
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
	return YES;
}

- (void)viewWillAppear:(BOOL)animated {    
	[super viewWillAppear:animated];	
}

- (void)viewWillDisappear:(BOOL)animated {	
	[super viewWillDisappear:animated];	
}

/* Update the content of PageViewController.view
 */
- (void)viewDidAppear:(BOOL)animated {	
	
    JSONReaderAppDelegate *theAppDelegate = [UIApplication sharedApplication].delegate;

    // Update the title, author and date labels.
    self.titleLabel.text = theAppDelegate.appData.articleTitle;
    self.authorLabel.text = theAppDelegate.appData.articleAuthor;
    self.dateLabel.text = theAppDelegate.appData.articleDate;
    
    // Update the content of the article itself.
    [self.articleView loadHTMLString:theAppDelegate.appData.articleContent 
                             baseURL:nil];
    
 	[super viewDidAppear:animated];
}


- (void)viewDidDisappear:(BOOL)animated {
	[super viewDidDisappear:animated];
}



@end
