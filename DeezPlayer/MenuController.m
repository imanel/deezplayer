//
//  MenuController.m
//  DeezPlayer
//
//  Created by Matheus C. Candido on 10/24/13.
//  Copyright (c) 2013 Imanel. All rights reserved.
//

#import "MenuController.h"

@implementation MenuController

@synthesize myVC;

- (IBAction) play:(id)sender {
    [myVC togglePlayPause];
}

- (IBAction) next:(id)sender {
    [myVC playNext];
}

- (IBAction) previous:(id)sender {
    [myVC playPrev];
}

@end
