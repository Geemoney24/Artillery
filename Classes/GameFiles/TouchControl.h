//
//  MainMap.h
//  Artillery
//
//  Created by default on 3/13/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TouchControl : UIView  <UIGestureRecognizerDelegate> {
    CGFloat playerTurn;
    CGFloat turretAngle;
}

@property (nonatomic, assign) CGPoint touchOffset;

@end
