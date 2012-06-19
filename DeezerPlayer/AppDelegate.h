//
//  AppDelegate.h
//  DeezerPlayer
//
//  Created by Bernard Potocki on 19.06.2012.
//  Copyright (c) 2012 Rebased. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "SPMediaKeyTap.h"
#import "MainWindowController.h"

@interface AppDelegate : NSObject <NSApplicationDelegate,NSWindowDelegate> {
    MainWindowController *myVC;
    SPMediaKeyTap *keyTap;
}

@property (assign) IBOutlet NSWindow *window;
@property IBOutlet MainWindowController *myVC;

@end
