//
//  JSONReaderAppDelegate.h
//  JSONReader
//
//  Created by Anh on 12/8/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppData.h"

@class JSONReaderViewController;

@interface JSONReaderAppDelegate : NSObject <UIApplicationDelegate> {
    
    AppData *appData;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;

@property (nonatomic, retain) IBOutlet JSONReaderViewController *viewController;

@property (nonatomic, retain) AppData *appData;

@end
