//
//  MenuController.h
//  DeezPlayer
//
//  Created by Matheus C. Candido on 10/24/13.
//  Copyright (c) 2013 Imanel. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MainWindowController.h"

@interface MenuController : NSMenu {
    MainWindowController *myVC;
}

@property IBOutlet MainWindowController *myVC;
- (IBAction) play:(id)sender;
- (IBAction) next:(id)sender;
- (IBAction) previous:(id)sender;

@end
