//
//  MainMap.m
//  Artillery
//
//  Created by default on 3/13/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//
//http://watchingapple.com/2008/04/core-animation-creating-a-jack-in-the-box-with-cakeyframeanimation/

#import "TouchControl.h"
#import "Tank.h"
#import "CannonBall.h"
#import <QuartzCore/QuartzCore.h>

#define groundHeight 100.0

#define tank1X 50.0
#define tank1Y 10.0

#define tank2X 50.0
#define tank2Y 365.0


#define tankHeight 20
#define tankWidth 40

#define P(x,y) CGPointMake(x,y)

static Tank *tank1 = nil;
static Tank *tank2 = nil;
static CAShapeLayer *ground = nil;
static CannonBall *ball = nil;


static const CGFloat pickupSize = 1.25;
static const CGFloat pickupAnimationDuration = 0.25;
static const CGFloat pickupAlpha = 0.7;

CALayer *gun;
CALayer *tank;
CGFloat angle;
CGPoint gunOrigin;

@implementation TouchControl

@synthesize touchOffset;



- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor blueColor];
        turretAngle = 0;
        
        //Draw the ground
        UIBezierPath *terrain = [UIBezierPath bezierPath];
        
        [terrain moveToPoint:P(0., 0.)];
        [terrain addLineToPoint:P(0., 1000.)];
        
        ground = [CAShapeLayer layer];
        ground.path = terrain.CGPath;
        ground.strokeColor = [UIColor greenColor].CGColor;
        ground.fillColor = [UIColor clearColor].CGColor;
        ground.lineWidth = groundHeight;
        [self.layer addSublayer:ground];
        
        //Lets build some tanks!!
        tank1 = [[Tank alloc] initWithRect:CGRectMake(tank1X, tank1Y, tankHeight, tankWidth) inLayer:ground];
        tank2 = [[Tank alloc] initWithRect:CGRectMake(tank2X, tank2Y, tankHeight, tankWidth) inLayer:ground];
        
        //player1 goes first
        playerTurn = 1;
        gun = [tank1 gun];
        tank = [tank1 body];
        gunOrigin = [tank1 getGunOrgin];  
        
    }
    return self;
}

//http://watchingapple.com/2008/04/core-animation-paths/
-(void) touchesBegan:(NSSet*)touches withEvent:(UIEvent*)event
{
    
    for( UITouch *touch in touches ){
        //CGPoint location = [touch locationInView:self.superview];
    }

}

-(void) touchesMoved:(NSSet*)touches withEvent:(UIEvent*)event
{
    
    for( UITouch *touch in touches )
    {
        //gun.position = CGPointMake(location.x,location.y);
    }

}


-(void) touchesEnded:(NSSet*)touches withEvent:(UIEvent*)event
{
    CATransform3D transform = CATransform3DIdentity;
    UILabel *textField;
    
    for( UITouch *touch in touches ){
        CGPoint location = [touch locationInView:self.superview];

        if ([tank containsPoint:location] == TRUE){
            
                printf("%f,%f",[tank position].x, [tank position].y);
            
            if (playerTurn == 1){
                //fire!!!  subtracting 90 seems to work better....
                ball = [ [CannonBall alloc] initWithRect:CGPointMake(gun.position.x, gun.position.y+5) inLayer:ground fireAngle:90-angle radius:250 ]; 
                
                //remember the current angle
                [tank1 setTurretAngle:angle]; 
                //set player2 stuff
                angle = [tank2 turretAngle];
                gunOrigin =[tank2 getGunOrgin];
                gun = [tank2 gun];
                tank = [tank2 body];
                
                if ([tank containsPoint:[ball getEnd]] == TRUE){
                    textField = [[UILabel alloc] initWithFrame:CGRectMake(100, 225, 200, 20)];
                    [textField setText:@"Player 1 Wins!!"];
                    [textField setBackgroundColor:[UIColor blueColor]];
                    [textField setTextColor:[UIColor whiteColor]];
                    [textField endEditing:false];
                    [textField setTransform:CGAffineTransformMakeRotation(M_PI/2)];
                    [self addSubview:textField];

                    playerTurn = -2;
                }
                else
                    playerTurn = 2;
                    
            }else if (playerTurn == 2){
                
                //fire!!!
                printf("%f < \n",angle);
                ball = [ [CannonBall alloc] initWithRect:CGPointMake(gun.position.x, gun.position.y+5) inLayer:ground fireAngle:(90-angle) radius:-250 ];
                
                [tank2 setTurretAngle:angle];
                
                //set player1 stuff
                angle = [tank1 turretAngle];
                gunOrigin =[tank1 getGunOrgin];
                gun = [tank1 gun];
                tank = [tank1 body];
                
                if ([tank containsPoint:[ball getEnd]] == TRUE){
                    textField = [[UILabel alloc] initWithFrame:CGRectMake(100, 225, 200, 20)];
                    [textField setText:@"Player 1 Wins!!"];
                    [textField setBackgroundColor:[UIColor blueColor]];
                    [textField setTextColor:[UIColor whiteColor]];
                    [textField endEditing:false];
                    [textField setTransform:CGAffineTransformMakeRotation(M_PI/2)];
                    [self addSubview:textField];
                    
                    playerTurn = -1;
                }
                else
                    playerTurn = 1;
            }
            
            
        }else{
            if (playerTurn == 1) {
                if ( (location.y > gunOrigin.y && angle < 30) ) 
                    angle +=5;
                else if ( (location.y < gunOrigin.y && angle > 0)  )
                    angle -=5;
            }else if (playerTurn ==2){
                
                if ( (location.y > gunOrigin.y && angle < 0) ) 
                    angle +=5;
                else if ( (location.y < gunOrigin.y && angle > -30)  )
                    angle -=5;
            }
                
            gun.transform = CATransform3DRotate(transform, angle* M_PI / 180, 0.0, 0.0, 1.0);
        }
    }
}

-(void) touchesCancelled:(NSSet*)touches withEvent:(UIEvent*)event
{
    [self touchesEnded:touches withEvent:event];
}




@end
