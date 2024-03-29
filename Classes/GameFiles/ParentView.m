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
    
    CGRect screen = [[UIScreen mainScreen] bounds]; 
    TouchControl *view = [[TouchControl alloc] initWithFrame:CGRectMake( 0, 0, screen.size.height, screen.size.width)];
    [view setCPU:true];
    [self.view addSubview:view];
   
}
- (BOOL) shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
{
    if ( UIInterfaceOrientationIsLandscape(toInterfaceOrientation) )
    {
        return YES;
    }
    return NO;
} 
- (void)viewDidUnload{[super viewDidUnload];}
- (void)viewWillAppear:(BOOL)animated{[super viewWillAppear:animated];}
- (void)viewDidAppear:(BOOL)animated{[super viewDidAppear:animated];}
- (void)viewWillDisappear:(BOOL)animated{[super viewWillDisappear:animated];}
- (void)viewDidDisappear:(BOOL)animated{[super viewDidDisappear:animated];}

@end
