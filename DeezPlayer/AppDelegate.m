//
//  AppDelegate.m
//  DeezPlayer
//
//  Created by Bernard Potocki on 19.06.2012.
//  Copyright (c) 2012 Imanel. All rights reserved.
//

#import "AppDelegate.h"
#import "MainWindowController.h"
#import "IOKit/hidsystem/ev_keymap.h"

@implementation AppDelegate

@synthesize window = _window;
@synthesize myVC;

+ (void)initialize {
	if([self class] != [AppDelegate class]) return;

	// Register defaults for the whitelist of apps that want to use media keys
	[[NSUserDefaults standardUserDefaults] registerDefaults:[NSDictionary dictionaryWithObjectsAndKeys: [SPMediaKeyTap defaultMediaKeyUserBundleIdentifiers], kMediaKeyUsingBundleIdentifiersDefaultsKey, nil]];
}

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
	keyTap = [[SPMediaKeyTap alloc] initWithDelegate:self];
	if([SPMediaKeyTap usesGlobalMediaKeyTap])
		[keyTap startWatchingMediaKeys];
	else
		NSLog(@"Media key monitoring disabled");
}

- (BOOL)windowShouldClose:(id)sender {
    [[NSApplication sharedApplication] hide:self];
	return NO;
}

- (BOOL)applicationShouldHandleReopen:(NSApplication *)theApplication hasVisibleWindows:(BOOL)flag {
    if (!flag)
        [[self window] makeKeyAndOrderFront:self];
    return YES;
}

-(void)mediaKeyTap:(SPMediaKeyTap*)keyTap receivedMediaKeyEvent:(NSEvent*)event;
{
	NSAssert([event type] == NSSystemDefined && [event subtype] == SPSystemDefinedEventMediaKeys, @"Unexpected NSEvent in mediaKeyTap:receivedMediaKeyEvent:");
	// here be dragons...
	int keyCode = (([event data1] & 0xFFFF0000) >> 16);
	int keyFlags = ([event data1] & 0x0000FFFF);
	BOOL keyIsPressed = (((keyFlags & 0xFF00) >> 8)) == 0xA;
	// int keyRepeat = (keyFlags & 0x1);

	if (keyIsPressed) {
		switch (keyCode) {
			case NX_KEYTYPE_PLAY:
				[myVC togglePlayPause];
				break;
			case NX_KEYTYPE_FAST:
				[myVC playNext];
				break;

			case NX_KEYTYPE_REWIND:
				[myVC playPrev];
				break;
			default:
				break;
		}
	}
}

@end
