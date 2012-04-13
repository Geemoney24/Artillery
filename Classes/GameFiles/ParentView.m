//
//  ParentView.m
//  Artillery
//
//  Created by default on 3/13/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ParentView.h"
#import "TouchControl.h"

@implementation ParentView

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    CGRect screen = [[UIScreen mainScreen] bounds]; //Startpoint.x, Startpoint.y, Width, Height.
    TouchControl *view = [[TouchControl alloc] initWithFrame:CGRectMake( 0, 0, screen.size.width, screen.size.height) ];
    [self.view addSubview:view];
   
}


- (void)viewDidUnload{[super viewDidUnload];}
- (void)viewWillAppear:(BOOL)animated{[super viewWillAppear:animated];}
- (void)viewDidAppear:(BOOL)animated{[super viewDidAppear:animated];}
- (void)viewWillDisappear:(BOOL)animated{[super viewWillDisappear:animated];}
- (void)viewDidDisappear:(BOOL)animated{[super viewDidDisappear:animated];}
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation{return YES;}

@end
