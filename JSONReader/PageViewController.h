//
//  PageViewController.h
//  JSONReader
//
//  Created by Anh on 12/8/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface PageViewController : UIViewController {
    
    UILabel *titleLabel;
    UILabel *authorLabel;
    UILabel *dateLabel;
    UIWebView *articleView;
}


@property (nonatomic, retain) IBOutlet UILabel *titleLabel;
@property (nonatomic, retain) IBOutlet UILabel *authorLabel;
@property (nonatomic, retain) IBOutlet UILabel *dateLabel;
@property (nonatomic, retain) IBOutlet UIWebView *articleView;

@end
