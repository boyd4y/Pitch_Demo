//
//  pitch_demoAppDelegate.h
//  pitch_demo
//
//  Created by Winston on 12-1-10.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class pitch_demoViewController;

@interface pitch_demoAppDelegate : NSObject <UIApplicationDelegate> {

}

@property (nonatomic, retain) IBOutlet UIWindow *window;

@property (nonatomic, retain) IBOutlet pitch_demoViewController *viewController;

@end
