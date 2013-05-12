//
//  AppDelegate.h
//  Jungle Battle
//
//  Created by Jean-Louis Danielo on 11/05/13.
//  Copyright (c) 2013 Jean-Louis Danielo. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ViewController;

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) ViewController *viewController;

- (NSDictionary*) getElementsFromJSON:(NSString*)anURL;

@end
