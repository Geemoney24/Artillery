//
//  RootViewController.h
//
//  Created by T Codi Gann.
//

#import <UIKit/UIKit.h>

typedef enum {
	PlayerVsPlayer,
    PlayerVsCPU
} GameType;

@interface RootViewController : UITableViewController {
}

+ (NSString*)titleForType:(GameType)type;
+ (Class)classForType:(GameType)type;
- (BOOL) shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation;
@end
