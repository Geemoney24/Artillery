//
//  Tank.m
//  Artillery
//
//  Created by default on 3/13/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Tank.h"
#import <QuartzCore/CAAnimation.h>
#import <QuartzCore/CAMediaTimingFunction.h>


@implementation Tank
@synthesize turretAngle;


- (id)initWithRect:(CGRect)rect inLayer:(CALayer *)parentLayer{
    self = [super init];
    if (self) {
        [self build:rect inLayer:parentLayer];
        turretAngle = 0;
        
    }
    return self;
}

- (void)build:(CGRect)rect inLayer:(CALayer *)parentLayer {
	float x = rect.origin.x;
	float y = rect.origin.y;
	float w = rect.size.width;
	float h = rect.size.height;
    
    float offset = 0;
    
    if (y>w)
        offset = y + 10 + w/2;
    else
        offset = y + (w - y);//top tank
    
    CGColorRef bodyColor  = CGColorRetain([UIColor colorWithRed:.0f green:.0f blue:0.0f alpha:1.f].CGColor);
    CGColorRef gunColor  = CGColorRetain([UIColor colorWithRed:0.0f green:0.0f blue:0.0f alpha:1.f].CGColor);
    
    gunx = x + ((x-h)/2);
    guny =  offset;
    gun = [self makeWallAtOrigin:CGPointMake(x + ((x-h)/2),  offset ) withSize:CGSizeMake([self gunHeight], [self gunWidth]) color:gunColor];
    body = [self makeWallAtOrigin:CGPointMake(x, y) withSize:CGSizeMake(w, h) color:bodyColor];
    

	[parentLayer addSublayer:body];
    [parentLayer addSublayer:gun];

    
}

- (CALayer *)makeWallAtOrigin:(CGPoint)origin withSize:(CGSize)size color:(CGColorRef)color 
{
    CALayer *wall = [CALayer layer]; 
	wall.backgroundColor = color;
	wall.anchorPoint = CGPointZero;
    CGRect frame;
    frame.origin = origin;
    frame.size = size;
    wall.frame = frame;
	wall.bounds = frame;
	return wall;
}

- (CGPoint)getGunOrgin{return CGPointMake(gunx,guny);}
- (CALayer *)gun{return gun;}
- (float)gunWidth{return 10;}
- (float)gunHeight{return 50;}
- (CALayer *)body{return body;}


@end
