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

#define groundHeight 75.0

#define tankOffset 50.0

#define tankWidth 40
#define tankHeight 20

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

-(void)setCPU:(Boolean)c{
    cpu = c;
}

- (id)initWithFrame:(CGRect)frame  
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor blueColor];

        turretAngle = 0;
        
        //Draw the ground
        UIBezierPath *terrain = [UIBezierPath bezierPath];
        
        [terrain moveToPoint:P(0 , frame.size.height-groundHeight)];
        [terrain addLineToPoint:P(frame.size.width, frame.size.height-groundHeight)];
        
        ground = [CAShapeLayer layer];
        ground.path = terrain.CGPath;
        ground.strokeColor = [UIColor greenColor].CGColor;
        ground.fillColor = [UIColor clearColor].CGColor;
        ground.lineWidth = groundHeight;
        [self.layer addSublayer:ground];
        
        printf("%f-%f=%f\n",frame.size.width, tankOffset,frame.size.width - groundHeight);
        printf("%f,%f",frame.size.height,frame.size.height - groundHeight);
        //Lets build some tanks!!
        tank1 = [[Tank alloc] initWithRect:CGRectMake(tankOffset, 187, tankWidth, tankHeight) inLayer:ground];
        tank2 = [[Tank alloc] initWithRect:CGRectMake(frame.size.width - tankOffset -tankWidth, 187,  tankWidth,tankHeight) inLayer:ground];
        
        //player1 goes first
        playerTurn = 1;
        angle = [tank1 turretAngle];
        gun = [tank1 gun];
        tank = [tank1 body];
        gunOrigin = [tank1 getGunOrgin];  
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)];
        tap.delegate = self;
        [self addGestureRecognizer:tap];
        
    }
    return self;
}

-(BOOL) gestureRecognizer:(UIGestureRecognizer*)gestureRecognizer
       shouldReceiveTouch:(UITouch*)touch
{
    return allowTapTouches;
}

-(void) handleTap:(UITapGestureRecognizer*)tap
{
    if (playerTurn == 1)
        [tank1 setTurretAngle:angle];
    if (playerTurn == 2)
        [tank2 setTurretAngle:angle];
    
    
    //if ([tank containsPoint:location] == TRUE){
        
        if (playerTurn == 1){
            //fire!!!  subtracting 90 seems to work better....
            ball = [ [CannonBall alloc] initWithRect:CGPointMake(gun.position.x-7, gun.position.y) inLayer:ground fireAngle:angle radius:350 ]; 
            
            //set player2 stuff
            angle = [tank2 turretAngle];
            gunOrigin =[tank2 getGunOrgin];
            gun = [tank2 gun];
            tank = [tank2 body];
            playerTurn = -2;
            
            
        }else if (playerTurn == 2){
            
            //fire!!!
            ball = [ [CannonBall alloc] initWithRect:CGPointMake(gun.position.x-6, gun.position.y) inLayer:ground fireAngle:(angle) radius:-350 ];
            
            //set player1 stuff
            angle = [tank1 turretAngle];
            gunOrigin =[tank1 getGunOrgin];
            gun = [tank1 gun];
            tank = [tank1 body];
            playerTurn = -1;
        }
        [NSTimer scheduledTimerWithTimeInterval:4.0 target:self selector:@selector(setPlayerTurn) userInfo:nil repeats:NO];
        
    //}//end if

}

-(UIView*) hitTest:(CGPoint)point withEvent:(UIEvent*)event
{
    UIView *view = [super hitTest:point withEvent:event];
    if( [view isKindOfClass:[UIControl class]] ) {
        allowTapTouches = FALSE;
    } else {
        allowTapTouches = TRUE;
    }
    return view;
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
    CATransform3D transform = CATransform3DIdentity;

    for( UITouch *touch in touches )
    {
        CGPoint location = [touch locationInView:self.superview];
        CGFloat radians = atan2f( location.y - gunOrigin.y , location.x - gunOrigin.x);
        
        
        if( ( playerTurn == 1 && (radians  * 180 / M_PI) < -30 && (radians  * 180 / M_PI) >  -90) ||
            ( playerTurn == 2 && (radians  * 180 / M_PI) < -90  && (radians  * 180 / M_PI) > -140)){
            gun.transform = CATransform3DRotate(transform,(270* M_PI / 180) + radians, 0.0, 0.0, 1.0);    
            angle = -(radians * 180 / M_PI);
        }        

    }

}


-(void) touchesEnded:(NSSet*)touches withEvent:(UIEvent*)event
{
    
    
    
    for( UITouch *touch in touches ){
        CGPoint location = [touch locationInView:self.superview];
        
        if (playerTurn == 1)
            [tank1 setTurretAngle:angle];
        if (playerTurn == 2)
            [tank2 setTurretAngle:angle];

        
        if ([tank containsPoint:location] == TRUE){
            
            if (playerTurn == 1){
                //fire!!!  subtracting 90 seems to work better....
                ball = [ [CannonBall alloc] initWithRect:CGPointMake(gun.position.x-7, gun.position.y) inLayer:ground fireAngle:angle radius:350 ]; 
                 
                //set player2 stuff
                angle = [tank2 turretAngle];
                gunOrigin =[tank2 getGunOrgin];
                gun = [tank2 gun];
                tank = [tank2 body];
                playerTurn = -2;
               
                    
            }else if (playerTurn == 2){
                
                //fire!!!
                ball = [ [CannonBall alloc] initWithRect:CGPointMake(gun.position.x-6, gun.position.y) inLayer:ground fireAngle:(angle) radius:-350 ];

                //set player1 stuff
                angle = [tank1 turretAngle];
                gunOrigin =[tank1 getGunOrgin];
                gun = [tank1 gun];
                tank = [tank1 body];
                playerTurn = -1;
            }
            [NSTimer scheduledTimerWithTimeInterval:4.0 target:self selector:@selector(setPlayerTurn) userInfo:nil repeats:NO];
            
        }//end if
    }//end for
}

-(void) touchesCancelled:(NSSet*)touches withEvent:(UIEvent*)event
{
    [self touchesEnded:touches withEvent:event];
}


-(void) setPlayerTurn{
    UILabel *textField;
    
    if ([tank containsPoint:[ball getEnd]] == TRUE){
        textField = [[UILabel alloc] initWithFrame:CGRectMake(180, 0, 150, 20)];
        [textField setBackgroundColor:[UIColor blueColor]];
        [textField setTextColor:[UIColor whiteColor]];
        [textField endEditing:false];
        //[textField setTransform:CGAffineTransformMakeRotation(M_PI/2)];
        [self addSubview:textField];
        if (playerTurn == -2)
            [textField setText:@"Player 1 Wins!!"];
        else
            [textField setText:@"Player 2 Wins!!"];
    }
    else if (cpu && playerTurn == -2)//if there is a cpu opponent
    {
        int randomAngle = -( (arc4random() % (140 - 90)) + 90);
        CATransform3D transform = CATransform3DIdentity;
        gun.transform = CATransform3DRotate(transform, (270* M_PI / 180) + (randomAngle)* M_PI / 180, 0.0, 0.0, 1.0);
        [tank2 setTurretAngle:randomAngle];
        ball = [ [CannonBall alloc] initWithRect:CGPointMake(gun.position.x-6, gun.position.y) inLayer:ground fireAngle:(-randomAngle) radius:-350 ];
        angle = [tank1 turretAngle];
        gunOrigin =[tank1 getGunOrgin];
        gun = [tank1 gun];
        tank = [tank1 body];
        playerTurn = -1;
        [NSTimer scheduledTimerWithTimeInterval:4.0 target:self selector:@selector(setPlayerTurn) userInfo:nil repeats:NO];
    }
    else
        playerTurn = playerTurn * (-1);//playerTurn will be set to -2 after player 1's turn, and -1 after player 2 turn
                                        
}

@end
