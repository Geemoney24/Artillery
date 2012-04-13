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

