//
//  JSONReaderViewController.m
//  JSONReader
//
//  Created by Anh on 12/8/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "JSONReaderViewController.h"
#import "ASIFormDataRequest.h"
#import "ASIHTTPRequest.h"
#import "JSON.h"
#import "JSONReaderAppDelegate.h"


@implementation JSONReaderViewController

@synthesize pageViewController;
@synthesize entries;
@synthesize listData;
@synthesize backButton;
@synthesize listTableView;
@synthesize topLabel;



- (void)dealloc
{
    [pageViewController release];
    [entries release];
    [listData release];
    [backButton release];
    [listTableView release];
    [topLabel release];
    
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];    
    
    // Hide the Back button
    //self.backButton = YES;
    
    // Connect to the web service to request feed data.
    // Use this URL for the web service.
    NSURL *url = [NSURL URLWithString:@"https://ajax.googleapis.com/ajax/services/feed/load?q=http://feeds.feedburner.com/TechCrunch&v=1.0"];
    
    // Create a new instance of ASIHTTPRequest and specify the URL
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
    
    // Set JSONReaderViewController as the delegate of the request.
    [request setDelegate:self];
    
    // Now call startAsynchronous to start the request in the background.
    // When it's done, either requestFinished or requestFailed will be called
    // in JSONReaderViewController (since it is the delegate.)
    
    [request startAsynchronous];         
}


- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
    
    self.pageViewController = nil;
    self.entries = nil;
    self.listData = nil;
    self.backButton = nil;
    self.listTableView = nil;
    self.topLabel = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return YES;
}


#pragma mark -
#pragma mark Handle displaying different views

- (IBAction)showTableView:(id)sender {
    
    NSLog(@"showTableView:");
    
    // Remove the Page View subview from JSONReaderViewController.view
    [self.pageViewController viewWillDisappear:YES];
    [self.pageViewController.view removeFromSuperview];
    [self.pageViewController viewDidDisappear:YES];

    // Disable the Back button on the Navigation Bar
    self.backButton.enabled = NO;

    // Show the table and header again in JSONReaderViewController.view

    // <TBD:  Here is when we should go out and ping the web service
    // again for updated content.>
 
    self.listTableView.hidden = NO;
    self.topLabel.hidden = NO;
}

- (void)showPageView:(NSInteger)row {
 
    NSLog(@"showPageView:");
    
    // Make sure that the selected row is valid - 
    // that is, there's corresponding data in our listData array.
    
    NSInteger count = [self.listData count];
    if (row < count) {
        
        // Hide the table of article titles and the header currently visible in
        // JSONReaderViewController.view
        self.listTableView.hidden = YES;
        self.topLabel.hidden = YES;
        
        // Enable the Back button on the NavigationBar
        self.backButton.enabled = YES;
        
        // Display the Page View as a subview of JSONReaderViewController.view
        
        // Load the nib if the Page View hasn't been initialized yet or has been removed from memory.
        if (self.pageViewController.view == nil) {
            self.pageViewController = [[PageViewController alloc]
                                       initWithNibName:@"PageView" 
                                       bundle:nil];
        }     
        
        // Update the content of the PageView.
        // This is where we get the actual article to display.
        
        // each 'entry' in array 'entries' is an NSDictionary with 8 keys:
        //   link, categories, mediaGroups, publishedDate, author, content, contentSnippet, title
        // Most of the corresponding values for these 8 keys are NSString, except 'categories' and
        // 'mediaGroups'

        NSDictionary *entry = [self.entries objectAtIndex:row];
        
        JSONReaderAppDelegate *theAppDelegate = [UIApplication sharedApplication].delegate;
        
        theAppDelegate.appData.articleTitle = [entry objectForKey:@"title"];
        theAppDelegate.appData.articleAuthor = [entry objectForKey:@"author"];
        theAppDelegate.appData.articleDate = [entry objectForKey:@"publishedDate"];    
        theAppDelegate.appData.articleContent = [entry objectForKey:@"content"];
        
        [self.pageViewController viewWillAppear:YES];
        [self.view insertSubview:pageViewController.view atIndex:0];
        [self.pageViewController viewDidAppear:YES];  
    }
}



#pragma mark -
#pragma mark Table View Data Source Methods

// Return the number of rows per section
// In this case we have only one section.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSLog(@"tableView:numberOfRowsInSection:");
	return [self.listData count];
}

// This method is called by the table view when it needs to draw a cell
// that corresponds to one of its rows.

- (UITableViewCell *)tableView:(UITableView *)tableView
		 cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	
    NSLog(@"tableView:cellForRowAtIndexPath:");

	// NSIndexPath is the mechanism that UITableView to wrap its section and row into one object.
	
	// Get from the system a reusable cell of type SimpleTableIndentifier.
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SimpleTableIndentifier"];
	
	// If one is not available, manually create a cell for this table type
	if (cell == nil) {
		cell = [[[UITableViewCell alloc] 
                 initWithStyle:UITableViewCellStyleSubtitle
                 reuseIdentifier:@"SimpleTableIndentifier"] 
                autorelease];
	}
	
	// Find the row corresponding to the indexPath.	
	NSInteger row = [indexPath row];
    
    // Get the row's data from listData and 
    // put this text data in the cell to be returned.
	cell.textLabel.text = [listData objectAtIndex:row];
	
    /* <TBD:  
     Extract the embedded image name and size from entry's content.  
     Download it from the web.  
     Scale it down to more of a thumbview.
     Display it next to the title in the table.
     */
    
    // Put a dummy image in here for now.
    UIImage *image = [UIImage imageNamed:@"star.png"];
	cell.imageView.image = image;
    
    cell.detailTextLabel.text = @"";
    
	return cell;
}

#pragma mark -
#pragma mark Table View Delegate Methods

- (NSInteger)tableView:(UITableView *)tableView
indentationLevelForRowAtIndexPath:(NSIndexPath *)indexPath {
	
    NSLog(@"tableView:indentationLevelForRowAtIndexPath:");
    
	// Indentation level is the same as the row number.
	//return [indexPath row];
    return 0;
}


// This method gets called *before* a row gets selected.
- (NSIndexPath *)tableView:(UITableView *)tableView
  willSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	
    NSLog(@"tableView:willSelectRowAtIndexPath:");
    
    // Check that the selected row has corresponding data in our listData array.
    NSInteger listSize = [self.listData count];
	NSInteger row = [indexPath row];
    
    if (row < listSize)
        return indexPath;
    else 
        return nil;
}


// This method gets called *after* a row gets selected.
- (void)tableView:(UITableView *)tableView
    didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	
    NSLog(@"tableView:didSelectRowAtIndexPath:");
    
	// Find the row corresponding to the indexPath and get its row data.
	
	NSInteger row = [indexPath row];
    [self showPageView:row];
}


#pragma mark -
#pragma mark Handle callbacks from ASIHTTPRequest


- (void)requestFinished:(ASIHTTPRequest *)request
{
    NSLog(@"requestFinished:");
    
    // Get the response string from the returned 'request'.
    // This is the raw data.
    NSString *responseString = [request responseString];
    
    // Use our JSON parser to parse it.
    NSDictionary *responseDict = (NSDictionary *)[responseString JSONValue];
    
    // ------ Level 1:
    // responseDict should have the following keys:
    // 'responseData', 'responseStatus', 'responseDetail'
    
    // Get the 'responseStatus'
    NSNumber *responseStatus = [responseDict objectForKey:@"responseStatus"];
    NSLog(@"responseStatus: %d", [responseStatus intValue]);
    
    // Get the 'responseData'
    NSDictionary *responseData = (NSDictionary *)[responseDict objectForKey:@"responseData"];
    
    // ------ Level 2:
    // responseData should have one key called 'feed'.    
    NSDictionary *feed = [responseData objectForKey:@"feed"];
    
    // ------ Level 3
    // 'feed' should have the following keys:
    //      link, description, type, author, entries, feedUrl, title
    // 'entries' is the one we are interested in.
    
    self.entries = [feed objectForKey:@"entries"];
        
    [self updateListData];
}



- (void)requestFailed:(ASIHTTPRequest *)request
{
    NSLog(@"requestFailed:");
    
    NSError *error = [request error];
    NSString *errorText = error.localizedDescription;
    NSLog(@"errorText = %@", errorText);
}


#pragma mark -
#pragma mark Update the content and redisplay table

- (void)updateListData {
    
    NSLog(@"updateListData");

    NSMutableArray *titleList = [[NSMutableArray alloc] initWithCapacity:1];
    
    for (NSDictionary *element in self.entries) {
        
        // ------ Level 4
        // each 'element' in array 'entries' has 8 keys:
        //   link, categories, mediaGroups, publishedDate, author, content, contentSnippet, title
        // Most of the corresponding values for these 8 keys are NSString, except 'categories' and
        // 'mediaGroups'
        
        NSString *title = [element objectForKey:@"title"];
        NSString *author = [element objectForKey:@"author"];
        NSString *content = [element objectForKey:@"content"];
        NSString *contentSnippet = [element objectForKey:@"contentSnippet"];
        NSString *publishedDate = [element objectForKey:@"publishedDate"];
        
        NSLog(@"\n");
        NSLog(@"title: %@", title);
        NSLog(@"author: %@", author);
        NSLog(@"publishedDate: %@", publishedDate);        
        NSLog(@"content: %@", content);
        NSLog(@"contentSnippet: %@", contentSnippet);
        NSLog(@"\n");
        
        // Save each entry...
        [titleList addObject:title];
    }
    
    // ... save each entry in our listData array.
	self.listData = titleList;
    
	[titleList release];    
    
    // Update the table display.
    [self.listTableView reloadData];
}


@end
