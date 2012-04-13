//
//  RootViewController.m
//
//  Created by T Codi Gann.
//

#import "RootViewController.h"
#import "ParentView.h"

@implementation RootViewController

+ (NSString*)titleForType:(GameType)type {
	switch (type) {
		case PlayerVsPlayer:
			return @"PlayerVsPlayer";
		case PlayerVsCPU:
			return @"PlayerVsCPU";
		default:
			return @"Unknown";
	}
}

+ (Class)classForType:(GameType)type {
	switch (type) {
		case PlayerVsPlayer:
            printf("PlayerVsPlayer");
			return [ParentView class];
		case PlayerVsCPU:
			printf("PlayerVsCPU");
            return nil;//[FloatingCloudViewController class];
		default:
			return nil;
	}
}

- (void)viewDidLoad {
	[super viewDidLoad];
	self.navigationItem.title = @"Aritllery";
}

#pragma mark -
#pragma mark Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    
	cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
	cell.textLabel.text = [RootViewController titleForType:indexPath.row];

    return cell;
}

#pragma mark -
#pragma mark Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	GameType type = indexPath.row;
	
	Class controllerClass = [RootViewController classForType:type];
	if (!controllerClass)
		return;
	
    UIViewController *controller = [(UIViewController*)[controllerClass alloc] initWithNibName:nil bundle:nil];
	controller.title = [RootViewController titleForType:type];
	
	if (controller != nil) {
		[self.navigationController pushViewController:controller animated:YES];
		[controller release];
	}
}

@end

