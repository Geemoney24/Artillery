//
//  CannonBall.m
//  Artillery
//
//  Created by default on 4/8/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "CannonBall.h"
#import <QuartzCore/CAAnimation.h>
#import <QuartzCore/CAMediaTimingFunction.h>

@implementation CannonBall


- (id)initWithRect:(CGPoint)pos inLayer:(CALayer *)parentLayer fireAngle:(CGFloat)angle radius:(CGFloat)pow{
    self = [super init];
    if (self) {
        [self build:pos inLayer:parentLayer fireAngle:angle radius:pow];
    }
    return self;
}

CGFloat x;// = pos.x + 150 * cos(45);
CGFloat y;// = pos.y + 150 * sin(45);

- (void)build:(CGPoint)pos inLayer:(CALayer *)parentLayer fireAngle:(CGFloat)angle radius:(CGFloat)pow{
    
	    
    CGFloat r;
    if (pow < 0)
        r = -(pow);
    else
        r = pow;
    
    //mid point 
    x = pos.x + r * sin(angle * M_PI / 180); //becasue my x and y are in oppisite land
    y = pos.y + r * cos(angle * M_PI / 180); 
    //end point
    CGFloat  endx = 55;
    CGFloat  endy = y + (y - pos.y);
        
    
    CGColorRef color  = CGColorRetain([UIColor colorWithRed:.0f green:.0f blue:.0f alpha:1.f].CGColor);
    ball = [CALayer layer];
    ball.bounds = CGRectMake(0,0,8,8);    
    ball.position = pos; 
    ball.CornerRadius = 4;
    ball.backgroundColor = color;
  
    [parentLayer addSublayer:ball];
    
    
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"position.y"];
    [animation setFromValue:[NSNumber numberWithFloat:pos.y]];
    [animation setToValue:[NSNumber numberWithFloat:y]];
    // Here's the important part
    [animation setDuration:2.0];
    [animation setBeginTime:0.0];
    
    CABasicAnimation *animation2 = [CABasicAnimation animationWithKeyPath:@"position.x"];
    [animation2 setFromValue:[NSNumber numberWithFloat:pos.x]];
    [animation2 setToValue:[NSNumber numberWithFloat:x]];
    // Here's the important part
    [animation2 setDuration:2.0];
    [animation2 setBeginTime:0.0];
    
    
    CABasicAnimation *animation3 = [CABasicAnimation animationWithKeyPath:@"position.y"];
    [animation3 setFromValue:[NSNumber numberWithFloat:y]];
    [animation3 setToValue:[NSNumber numberWithFloat:endy]];
    // Here's the important part
    [animation3 setDuration:2.0];
    [animation3 setBeginTime:2.0];
    
    CABasicAnimation *animation4 = [CABasicAnimation animationWithKeyPath:@"position.x"];
    [animation4 setFromValue:[NSNumber numberWithFloat:x]];
    [animation4 setToValue:[NSNumber numberWithFloat:endx]];
    // Here's the important part
    [animation4 setDuration:2.0];
    [animation4 setBeginTime:2.0];
    
    CAAnimationGroup *group = [CAAnimationGroup animation];
    [group setDuration:4.0];
    [group setRepeatCount:1.0];
    [group setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear]];
    [group setAnimations:[NSArray arrayWithObjects:animation, animation2, animation3, animation4, nil]];
    [ball addAnimation:group forKey:nil];
    
    printf("start pt>%f,%f\n",pos.x,pos.y);
    printf("mid   pt>%f,%f\n",x,y);
    printf("end   pt>%f,%f\n",endx,endy);

    end =  CGPointMake(endx, endy);
    
}

-(CGPoint )getEnd{return end;}
-(CALayer *)getBall{return  ball;}
@end
