//
//  CannonBall.h
//  Artillery
//
//  Created by default on 4/8/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CannonBall : NSObject{
	CALayer* ball;
    CGPoint end;
}
- (id)initWithRect:(CGPoint)pos inLayer:(CALayer *)parentLayer fireAngle:(CGFloat)angle radius:(CGFloat)pow;
- (void)build:(CGPoint)pos inLayer:(CALayer *)parentLayer fireAngle:(CGFloat)angle radius:(CGFloat)pow;

- (void)animationDidStop:(NSString *)animationID finished:(NSNumber *)finished context:(void *)context;


- (CALayer *)getBall;
- (CGPoint )getEnd;
@end
