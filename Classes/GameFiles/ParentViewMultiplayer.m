//
//  ParentView.m
//  Artillery
//
//  Created by default on 3/13/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ParentViewMultiplayer.h"
#import "TouchControl.h"

@implementation ParentViewMultiplayer

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    CGRect screen = [[UIScreen mainScreen] bounds]; 
    TouchControl *view = [[TouchControl alloc] initWithFrame:CGRectMake( 0, 0, screen.size.width, screen.size.height)];
    [view setCPU:true];
    [self.view addSubview:view];
    
}

- (void)viewDidUnload{[super viewDidUnload];}
- (void)viewWillAppear:(BOOL)animated{[super viewWillAppear:animated];}
- (void)viewDidAppear:(BOOL)animated{[super viewDidAppear:animated];}
- (void)viewWillDisappear:(BOOL)animated{[super viewWillDisappear:animated];}
- (void)viewDidDisappear:(BOOL)animated{[super viewDidDisappear:animated];}
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation{return YES;}

@end
