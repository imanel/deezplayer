//
//  MainWindowController.h
//  DeezerPlayer
//
//  Created by Bernard Potocki on 19.06.2012.
//  Copyright (c) 2012 Rebased. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <WebKit/WebKit.h>

@interface MainWindowController : NSWindowController {
    IBOutlet NSView *view;
    IBOutlet WebView *webView;
}

- (void)togglePlayPause;
- (void)playNext;
- (void)playPrev;

@end
