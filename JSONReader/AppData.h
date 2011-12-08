//
//  AppData.h
//  MemTest
//
//  Created by Anh on 12/1/11.
//  Copyright 2011 Looksys. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface AppData : NSObject {
    
    NSString *articleTitle;
    NSString *articleAuthor;
    NSString *articleDate;
    NSString *articleContent;
}

@property (nonatomic, retain) NSString *articleTitle;
@property (nonatomic, retain) NSString *articleAuthor;
@property (nonatomic, retain) NSString *articleDate;
@property (nonatomic, retain) NSString *articleContent;

@end
