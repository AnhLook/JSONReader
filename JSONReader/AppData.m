//
//  AppData.m
//  MemTest
//
//  Created by Anh on 12/1/11.
//  Copyright 2011 Looksys. All rights reserved.
//

#import "AppData.h"

@implementation AppData

@synthesize articleTitle;
@synthesize articleAuthor;
@synthesize articleDate;
@synthesize articleContent;

- (id)init
{
    self = [super init];
    if (self) {
        /* class-specific initialization goes here */
    }
    return self;
}


- (void)dealloc
{
    [articleTitle release];
    [articleAuthor release];
    [articleDate release];
    [articleContent release];
    
    [super dealloc];
}


@end
