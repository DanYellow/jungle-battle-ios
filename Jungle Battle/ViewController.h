//
//  ViewController.h
//  Jungle Battle
//
//  Created by Jean-Louis Danielo on 11/05/13.
//  Copyright (c) 2013 Jean-Louis Danielo. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "AppDelegate.h"
#import "UIImageView+AFNetworking.h"
#import "AFJSONRequestOperation.h"

@interface ViewController : UIViewController <UIAccelerometerDelegate>{
    
    int maxVideos; //Contient le nombre maximal de vidéos contenues dans l'API
    
    UIView *animal1;
    UIView *animal2;
    
    int randomNumber;
    AppDelegate *appdelegate;
    
    NSMutableArray *randomAnimalVideo;
    
    NSString* urlForVote;
    
    UILabel *animalLeftName;
    UILabel *animalRightName;
}

@end
