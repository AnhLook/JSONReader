//
//  TableViewController.h
//  JSONReader
//
//  Created by Anh on 12/8/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface TableViewController : UIViewController 
                                <UITableViewDelegate, UITableViewDataSource> {
	
	NSArray *listData;
    
}

@property (nonatomic, retain) IBOutlet NSArray *listData;

@end
