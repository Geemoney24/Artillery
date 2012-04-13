//
//  Tank.h
//  Artillery
//
//  Created by default on 3/13/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Tank : NSObject{
	CALayer* body;
	CALayer* gun;
    CGFloat gunx;
    CGFloat guny;


}

@property(nonatomic, assign) CGFloat turretAngle;


- (id)initWithRect:(CGRect)rect inLayer:(CALayer *)parentLayer;
- (void)build:(CGRect)rect inLayer:(CALayer *)parentLayer;
- (CALayer *)makeWallAtOrigin:(CGPoint)origin withSize:(CGSize)size color:(CGColorRef)color;
- (CGPoint)getGunOrgin;
- (float)gunWidth;
- (float)gunHeight;
- (CALayer *)gun;
- (CALayer *)body;

@end
