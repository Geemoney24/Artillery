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
        turretAngle = 90;
        
    }
    return self;
}

- (void)build:(CGRect)rect inLayer:(CALayer *)parentLayer {
	
    CGColorRef bodyColor  = CGColorRetain([UIColor colorWithRed:.0f green:0.f blue:0.0f alpha:1.f].CGColor);
    CGColorRef gunColor  = CGColorRetain([UIColor colorWithRed:0.0f green:0.0f blue:0.0f alpha:1.f].CGColor);
    
    float x = rect.origin.x;    // tank x
	float y = rect.origin.y;    // tank y
	float w = rect.size.width;  // tank w
	float h = rect.size.height; // tank h
  
    if (x > 200)
        gunx =  x + w/2 + 10;// right tank
    else
        gunx =  x + w/2; // left tank
    
    guny =  (y + h/2 )+2;
    
    gun = [self makeWallAtOrigin:CGPointMake(gunx, guny ) withSize:CGSizeMake([self gunWidth], [self gunHeight]) color:gunColor];
    CATransform3D transform = CATransform3DIdentity;
    gun.transform = CATransform3DRotate(transform, 180* M_PI / 180, 0.0, 0.0, 1.0);
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
