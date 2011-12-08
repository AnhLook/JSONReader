//
//  JSONReaderViewController.h
//  JSONReader
//
//  Created by Anh on 12/8/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TableViewController.h"
#import "PageViewController.h"

@interface JSONReaderViewController : UIViewController 
            <UITableViewDelegate, UITableViewDataSource> {
	
    NSArray *entries;
	NSArray *listData;
    
    PageViewController *pageViewController;      

    UITableView *listTableView;            
    UIBarButtonItem *backButton;
                
    UILabel *topLabel;
    UILabel *byLabel;
    UIImage *editorImage;
}

@property (nonatomic, retain) NSArray *entries;
@property (nonatomic, retain) NSArray *listData;

@property (nonatomic,retain) PageViewController *pageViewController;

@property (nonatomic, retain) IBOutlet UITableView *listTableView;     
@property (nonatomic, retain) IBOutlet UIBarButtonItem *backButton;
@property (nonatomic, retain) IBOutlet UILabel *topLabel;


- (IBAction)showTableView:(id)sender;
- (void)updateListData;


@end
