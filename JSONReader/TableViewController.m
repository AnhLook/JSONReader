//
//  TableViewController.m
//  JSONReader
//
//  Created by Anh on 12/8/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "TableViewController.h"


@implementation TableViewController

@synthesize listData;

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
    [listData release];
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


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
	NSArray *array = [[NSArray alloc]
                      initWithObjects: @"Erie", @"Huron", @"Ontario", @"Michigan", @"Superior", 
                      @"Cayuga", @"Seneca", @"Owasco", @"Skaneateles", @"Keuka", @"Canandaigua", @"Oneida",
                      nil];
	self.listData = array;
	[array release];
    [super viewDidLoad];
}


- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
    
    self.listData = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
	return YES;
}


#pragma mark -
#pragma mark Table View Data Source Methods

// Return the number of rows per section
// In this case we have only one section.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return [self.listData count];
}

// This method is called by the table view when it needs to draw a cell
// that corresponds to one of its rows.

- (UITableViewCell *)tableView:(UITableView *)tableView
		 cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	
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
	
	// Find the row corresponding to the indexPath and get its row data.
	// Put this text data in the cell to be returned.
	
	NSInteger row = [indexPath row];
	cell.textLabel.text = [listData objectAtIndex:row];
	
    // Put a dummy image in here for now.
    // <TBD: Extract & scale image that came with entry.
	UIImage *image = [UIImage imageNamed:@"star.png"];
	cell.imageView.image = image;
    
    cell.detailTextLabel.text = @"";
	    
	return cell;
}

#pragma mark -
#pragma mark Table View Delegate Methods

- (NSInteger)tableView:(UITableView *)tableView
indentationLevelForRowAtIndexPath:(NSIndexPath *)indexPath {
	
	// Indentation level is the same as the row number.
	//return [indexPath row];
    return 0;
}


// This method gets called *before* a row gets selected.
- (NSIndexPath *)tableView:(UITableView *)tableView
  willSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	
	NSInteger row = [indexPath row];
	
	if (row == 0)
		return nil;
	else
		return indexPath;
}


// This method gets called *after* a row gets selected.
- (void)tableView:(UITableView *)tableView
didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	
	// Find the row corresponding to the indexPath and get its row data.
	
	NSInteger row = [indexPath row];
	NSString *rowValue = [listData objectAtIndex:row];
	
	NSString *message = [[NSString alloc]
						 initWithFormat:@"%@ Lake", rowValue];
	
	UIAlertView *alert = [[UIAlertView alloc]
						  initWithTitle:@"You selected"
						  message:message
						  delegate:nil
						  cancelButtonTitle:@"OK"
						  otherButtonTitles:nil];
	
	[alert show];
	
	[message release];
	[alert release];
	
	[tableView deselectRowAtIndexPath:indexPath animated:YES];	
}


@end
