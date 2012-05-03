//
//  Artillery.h
//
//  Created by T Codi Gann.

#import <UIKit/UIKit.h>

@interface ArtilleryAppDelegate : NSObject <UIApplicationDelegate> {
    
    UIWindow *window;
    UINavigationController *navigationController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet UINavigationController *navigationController;

@end

/*
 Good work. You added some more polish since last time I saw the app, and it's
 improved. This is a foundation you could build a solid app on.
 
 Grade: 100%
 Course grade: 100% (A)
*/