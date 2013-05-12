//
//  ViewController.m
//  Jungle Battle
//
//  Created by Jean-Louis Danielo on 11/05/13.
//  Copyright (c) 2013 Jean-Louis Danielo. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    /******************** Globals vars ****************************/
    maxVideos = 5;
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    /******************** Globals vars ****************************/
    
    
    UIImageView *image = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"LOGO242PX"]];
    image.contentMode = UIViewContentModeScaleAspectFit;
    image.frame = CGRectMake(16, 15, 236/2, 166/2);
    
    [self.view addSubview:image];
    
//    [self loadVideoWithSource:@"truc"];
    
//    [self playVideo:@"http://www.youtube.com/watch?v=WL2l_Q1AR_Q"
//          frame:CGRectMake(
//                           16,
//                           image.frame.size.height + image.frame.origin.y + 32,
//                           290,
//                           163)];
    
    [self displayTheBest];
    
    int animalButtonPosition = image.frame.size.height + image.frame.origin.y + 32 + 163 + 23;
    
    animal1 = [[UIView alloc] initWithFrame:CGRectMake(16, animalButtonPosition, 53, 53)];
    animal1.backgroundColor = [UIColor clearColor];
    animal1.tag = 42;
    [self.view addSubview:animal1];
    
    UITapGestureRecognizer *vote = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(voteForAnimal:)];
    [animal1 addGestureRecognizer:vote];

    animal2 = [[UIView alloc] initWithFrame:CGRectMake(16 + 53 + 15, animalButtonPosition, 53, 53)];
    animal2.backgroundColor = [UIColor clearColor];
    animal2.tag = 43;
    [self.view addSubview:animal2];
    
    UITapGestureRecognizer *vote2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(voteForAnimal:)];
    [animal2 addGestureRecognizer:vote2];
 
    animalLeftName = [[UILabel alloc] initWithFrame:CGRectMake(9, 369, 65, 20)];
    animalLeftName.font = [UIFont fontWithName:@"Helvetica" size:12];
    animalLeftName.textAlignment = NSTextAlignmentCenter;
    animalLeftName.backgroundColor = [UIColor clearColor];
    [self.view addSubview:animalLeftName];
    
    animalRightName = [[UILabel alloc] initWithFrame:CGRectMake(77, 369, 65, 20)];
    animalRightName.font = [UIFont fontWithName:@"Helvetica" size:12];
    animalRightName.textAlignment = NSTextAlignmentCenter;
    animalRightName.backgroundColor = [UIColor clearColor];
    [self.view addSubview:animalRightName];
    
    UIView *nextVideoView = [[UIView alloc] initWithFrame:CGRectMake(255, animalButtonPosition, 53, 53)];
    nextVideoView.backgroundColor = [UIColor blueColor];
//    [self.view addSubview:nextVideoView];
    
    UIImageView *randomVideoView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"NEXT"]];
    randomVideoView.frame = CGRectMake(255, animalButtonPosition, 53, 53);
    randomVideoView.contentMode = UIViewContentModeScaleAspectFit;
    randomVideoView.userInteractionEnabled = YES;
    [self.view addSubview:randomVideoView];
    
    UITapGestureRecognizer *next = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(nextVideo:)];
    [randomVideoView addGestureRecognizer:next];
    
    appdelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    [self loadRandom];
    
//    [NSTimer scheduledTimerWithTimeInterval:120
//                                     target:self
//                                   selector:@selector(tick:)
//                                   userInfo:nil
//                                    repeats:YES];
    
//    [self performSelectorInBackground:@selector(loadRandom) withObject:nil];
    
    NSURL *url = [NSURL URLWithString:@"http://www.junglebattle.com/api/animals"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {       
        for (int i = 0; i < 3; i++)
        {
            NSString *animalsAssetsLink = @"http://www.junglebattle.com/img/";

            animalsAssetsLink = [animalsAssetsLink stringByAppendingString:[[JSON valueForKeyPath:@"image"] objectAtIndex:i]];
            
            UIView *view = [[UIView alloc] initWithFrame:CGRectMake((59 * i) + 135, 35, 98/2, 98/2)];
            view.backgroundColor = [UIColor clearColor];
            //
            UIImageView *image = [[UIImageView alloc] init];
            [image setImageWithURL:[NSURL URLWithString:animalsAssetsLink]];
            image.contentMode = UIViewContentModeScaleAspectFit;
            image.frame = CGRectMake(0, 0, 53, 53);
            image.backgroundColor = [UIColor clearColor];
            [view addSubview:image];
            
            
            UIImageView *ribbon = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[NSString stringWithFormat:@"COCARDE%d.png", i + 1]]];
            ribbon.contentMode = UIViewContentModeScaleAspectFit;
            ribbon.frame = CGRectMake(0, 0, 32, 32);
            
            [view addSubview:ribbon];
            [self.view addSubview:view];
        }
    } failure:nil];
    [operation start];
    
    
    
    NSURL *url2 = [NSURL URLWithString:@"http://www.junglebattle.com/api/videos/1"];
    NSURLRequest *request2 = [NSURLRequest requestWithURL:url2];
    AFJSONRequestOperation *operation2 = [AFJSONRequestOperation JSONRequestOperationWithRequest:request2 success:^(NSURLRequest *request2, NSHTTPURLResponse *response, id JSON) {
        
        for (int i = 0; i < 1; i++) {
            NSString *animalsAssetsLink = @"http://www.junglebattle.com/img/";
            
            NSString *videoId = [[JSON valueForKeyPath:@"video_id"] objectAtIndex:i];
            NSString *animal1Name = [[JSON valueForKeyPath:@"animal1"] objectAtIndex:i];
            NSString *animal2Name = [[JSON valueForKeyPath:@"animal2"] objectAtIndex:i];
            
            NSString *youtubeLink = @"http://www.youtube.com/watch?v=";
            youtubeLink = [youtubeLink stringByAppendingString:videoId];
            
            urlForVote = @"http://www.junglebattle.com/api/vote/";
            urlForVote = [urlForVote stringByAppendingString:videoId];
            
            NSString *imageLeft = animal1Name;
            NSString *imageRight = animal2Name;
            
            NSString *animal1ImageLink = @"";
            NSString *animal2ImageLink = @"";
            
            UIView *viewLeft = (UIView*)[self.view viewWithTag:42];
            UIView *viewRight = (UIView*)[self.view viewWithTag:43];
            
            if ([imageLeft isEqualToString:@"cat"]) {
                animal1ImageLink = [animalsAssetsLink stringByAppendingString: @"CHAT.png"];
            }else if ([imageLeft isEqualToString:@"dog"]) {
                animal1ImageLink = [animalsAssetsLink stringByAppendingString: @"CHIEN.png"];
            }else if ([imageLeft isEqualToString:@"bird"]) {
                animal1ImageLink = [animalsAssetsLink stringByAppendingString: @"OISEAU.png"];
            }else if ([imageLeft isEqualToString:@"mouse"]) {
                animal1ImageLink = [animalsAssetsLink stringByAppendingString: @"SOURIS.png"];
            }else if ([imageLeft isEqualToString:@"ostrich"]) {
                animal1ImageLink = [animalsAssetsLink stringByAppendingString: @"AUTRUCHE.png"];
            }else if ([imageLeft isEqualToString:@"horse"]) {
                animal1ImageLink = [animalsAssetsLink stringByAppendingString: @"CHEVAL.png"];
            }else if ([imageLeft isEqualToString:@"goat"]) {
                animal1ImageLink = [animalsAssetsLink stringByAppendingString: @"CHEVRE.png"];
            }else if ([imageLeft isEqualToString:@"pig"]) {
                animal1ImageLink = [animalsAssetsLink stringByAppendingString: @"COCHON.png"];
            }else if ([imageLeft isEqualToString:@"crocodile"]) {
                animal1ImageLink = [animalsAssetsLink stringByAppendingString: @"CROCO.png"];
            }else if ([imageLeft isEqualToString:@"elephant"]) {
                animal1ImageLink = [animalsAssetsLink stringByAppendingString: @"ELEPHANT.png"];
            }else if ([imageLeft isEqualToString:@"giraffe"]) {
                animal1ImageLink = [animalsAssetsLink stringByAppendingString: @"GIRAFE.png"];
            }else if ([imageLeft isEqualToString:@"hippo"]) {
                animal1ImageLink = [animalsAssetsLink stringByAppendingString: @"HIPPO.png"];
            }else if ([imageLeft isEqualToString:@"man"]) {
                animal1ImageLink = [animalsAssetsLink stringByAppendingString: @"HOMME.png"];
            }else if ([imageLeft isEqualToString:@"rabbit"]) {
                animal1ImageLink = [animalsAssetsLink stringByAppendingString: @"LAPIN.png"];
            }else if ([imageLeft isEqualToString:@"lion"]) {
                animal1ImageLink = [animalsAssetsLink stringByAppendingString: @"LION.png"];
            }else if ([imageLeft isEqualToString:@"sheep"]) {
                animal1ImageLink = [animalsAssetsLink stringByAppendingString: @"MOUTON.png"];
            }else if ([imageLeft isEqualToString:@"bear"]) {
                animal1ImageLink = [animalsAssetsLink stringByAppendingString: @"OURS.png"];
            }else if ([imageLeft isEqualToString:@"chicken"]) {
                animal1ImageLink = [animalsAssetsLink stringByAppendingString: @"POULET.png"];
            }else if ([imageLeft isEqualToString:@"shark"]) {
                animal1ImageLink = [animalsAssetsLink stringByAppendingString: @"REQUIN.png"];
            }else if ([imageLeft isEqualToString:@"rhino"]) {
                animal1ImageLink = [animalsAssetsLink stringByAppendingString: @"RHINO.png"];
            }else if ([imageLeft isEqualToString:@"snake"]) {
                animal1ImageLink = [animalsAssetsLink stringByAppendingString: @"SERPENT.png"];
            }else if ([imageLeft isEqualToString:@"monkey"]) {
                animal1ImageLink = [animalsAssetsLink stringByAppendingString: @"OISEAU.png"];
            }else if ([imageLeft isEqualToString:@"tiger"]) {
                animal1ImageLink = [animalsAssetsLink stringByAppendingString: @"SINGE.png"];
            }else if ([imageLeft isEqualToString:@"cow"]) {
                animal1ImageLink = [animalsAssetsLink stringByAppendingString: @"VACHE.png"];
            }else if ([imageLeft isEqualToString:@"zebra"]) {
                animal1ImageLink = [animalsAssetsLink stringByAppendingString: @"ZEBRE.png"];
            }
            
            if ([imageRight isEqualToString:@"cat"]) {
                animal2ImageLink = [animalsAssetsLink stringByAppendingString: @"CHAT.png"];
            }else if ([imageRight isEqualToString:@"dog"]) {
                animal2ImageLink = [animalsAssetsLink stringByAppendingString: @"CHIEN.png"];
            }else if ([imageRight isEqualToString:@"bird"]) {
                animal2ImageLink = [animalsAssetsLink stringByAppendingString: @"OISEAU.png"];
            }else if ([imageRight isEqualToString:@"mouse"]) {
                animal2ImageLink = [animalsAssetsLink stringByAppendingString: @"SOURIS.png"];
            }else if ([imageRight isEqualToString:@"ostrich"]) {
                animal2ImageLink = [animalsAssetsLink stringByAppendingString: @"AUTRUCHE.png"];
            }else if ([imageRight isEqualToString:@"horse"]) {
                animal2ImageLink = [animalsAssetsLink stringByAppendingString: @"CHEVAL.png"];
            }else if ([imageRight isEqualToString:@"goat"]) {
                animal2ImageLink = [animalsAssetsLink stringByAppendingString: @"CHEVRE.png"];
            }else if ([imageRight isEqualToString:@"pig"]) {
                animal2ImageLink = [animalsAssetsLink stringByAppendingString: @"COCHON.png"];
            }else if ([imageRight isEqualToString:@"crocodile"]) {
                animal2ImageLink = [animalsAssetsLink stringByAppendingString: @"CROCO.png"];
            }else if ([imageRight isEqualToString:@"elephant"]) {
                animal2ImageLink = [animalsAssetsLink stringByAppendingString: @"ELEPHANT.png"];
            }else if ([imageRight isEqualToString:@"giraffe"]) {
                animal2ImageLink = [animalsAssetsLink stringByAppendingString: @"GIRAFE.png"];
            }else if ([imageRight isEqualToString:@"hippo"]) {
                animal2ImageLink = [animalsAssetsLink stringByAppendingString: @"HIPPO.png"];
            }else if ([imageRight isEqualToString:@"man"]) {
                animal2ImageLink = [animalsAssetsLink stringByAppendingString: @"HOMME.png"];
            }else if ([imageRight isEqualToString:@"rabbit"]) {
                animal2ImageLink = [animalsAssetsLink stringByAppendingString: @"LAPIN.png"];
            }else if ([imageRight isEqualToString:@"lion"]) {
                animal2ImageLink = [animalsAssetsLink stringByAppendingString: @"LION.png"];
            }else if ([imageRight isEqualToString:@"sheep"]) {
                animal2ImageLink = [animalsAssetsLink stringByAppendingString: @"MOUTON.png"];
            }else if ([imageRight isEqualToString:@"bear"]) {
                animal2ImageLink = [animalsAssetsLink stringByAppendingString: @"OURS.png"];
            }else if ([imageRight isEqualToString:@"chicken"]) {
                animal2ImageLink = [animalsAssetsLink stringByAppendingString: @"POULET.png"];
            }else if ([imageRight isEqualToString:@"shark"]) {
                animal2ImageLink = [animalsAssetsLink stringByAppendingString: @"REQUIN.png"];
            }else if ([imageRight isEqualToString:@"rhino"]) {
                animal2ImageLink = [animalsAssetsLink stringByAppendingString: @"RHINO.png"];
            }else if ([imageRight isEqualToString:@"snake"]) {
                animal2ImageLink = [animalsAssetsLink stringByAppendingString: @"SERPENT.png"];
            }else if ([imageRight isEqualToString:@"monkey"]) {
                animal2ImageLink = [animalsAssetsLink stringByAppendingString: @"OISEAU.png"];
            }else if ([imageRight isEqualToString:@"tiger"]) {
                animal2ImageLink = [animalsAssetsLink stringByAppendingString: @"SINGE.png"];
            }else if ([imageRight isEqualToString:@"cow"]) {
                animal2ImageLink = [animalsAssetsLink stringByAppendingString: @"VACHE.png"];
            }else if ([imageRight isEqualToString:@"zebra"]) {
                animal2ImageLink = [animalsAssetsLink stringByAppendingString: @"ZEBRE.png"];
            }
            
            animalLeftName.text = imageLeft;
            animalRightName.text = imageRight;
            
            [animal1ImageLink lowercaseString];
            [animal2ImageLink lowercaseString];
            
            UIImageView *image = [[UIImageView alloc] init];
            [image setImageWithURL:[NSURL URLWithString:animal1ImageLink]];
            image.contentMode = UIViewContentModeScaleAspectFit;
            image.frame = CGRectMake(0, 0, 53, 53);
            image.backgroundColor = [UIColor clearColor];
            [viewLeft addSubview:image];
            
            
            
            UIImageView *image2 = [[UIImageView alloc] init];
            [image2 setImageWithURL:[NSURL URLWithString:animal2ImageLink]];
            image2.contentMode = UIViewContentModeScaleAspectFit;
            image2.frame = CGRectMake(0, 0, 53, 53);
            image2.backgroundColor = [UIColor clearColor];
            [viewRight addSubview:image2];
            
            [self playVideo:youtubeLink
                      frame:CGRectMake(
                                       16,
                                       130,
                                       290,
                                       163)];
            
            
            NSLog(@"%@", videoId);
        }
        
    } failure:nil];
    [operation2 start];
    
}



- (void) loadRandom
{
    NSString *appendLink = @"http://www.junglebattle.com/api/videos/3";

    randomAnimalVideo = [[NSMutableArray alloc] init];
    
//    NSLog(@"%i", [[appdelegate getElementsFromJSON:appendLink] count]);
    
//    for (int i = 0; i < [[appdelegate getElementsFromJSON:appendLink] count]; i++) {
//        NSString *videoId = [[[appdelegate getElementsFromJSON:appendLink] valueForKeyPath:@"video_id"] objectAtIndex:i];
//        NSString *animal1Name = [[[appdelegate getElementsFromJSON:appendLink] valueForKeyPath:@"animal1"] objectAtIndex:i];
//        NSString *animal2Name = [[[appdelegate getElementsFromJSON:appendLink] valueForKeyPath:@"animal2"] objectAtIndex:i];
//        
//        
//        
//        NSMutableDictionary *randomFight = [[NSMutableDictionary alloc] init];
//        [randomFight setValue:videoId forKey:@"video_id"];
//        [randomFight setValue:animal1Name forKey:@"animal1"];
//        [randomFight setValue:animal2Name forKey:@"animal2"];
//        
//        [randomAnimalVideo addObject:randomFight];
//    }
    
    NSURL *url = [NSURL URLWithString:@"http://www.junglebattle.com/api/videos/3"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
        for (int i = 0; i < 3; i++)
        {
            NSString *animalsAssetsLink = @"http://www.junglebattle.com/img/";
            
            NSString *videoId = [[JSON valueForKeyPath:@"video_id"] objectAtIndex:i];
            NSString *animal1Name = [[JSON valueForKeyPath:@"animal1"] objectAtIndex:i];
            NSString *animal2Name = [[JSON valueForKeyPath:@"animal2"] objectAtIndex:i];
            
            NSMutableDictionary *randomFight = [[NSMutableDictionary alloc] init];
            [randomFight setValue:videoId forKey:@"video_id"];
            [randomFight setValue:animal1Name forKey:@"animal1"];
            [randomFight setValue:animal2Name forKey:@"animal2"];
            
            [randomAnimalVideo addObject:randomFight];
            
//             NSLog(@"%@", randomAnimalVideo);
        }
    } failure:nil];
    [operation start];
    
   
}

- (void) displayTheBest
{
//    NSArray *bestAnimalsArray = [[NSArray alloc] initWithObjects:@"string", nil];
    
    
}

- (void) nextVideo:(UIGestureRecognizer *)gesture{
    NSLog(@"treu");
    NSURL *url2 = [NSURL URLWithString:@"http://www.junglebattle.com/api/videos/1"];
    NSURLRequest *request2 = [NSURLRequest requestWithURL:url2];
    AFJSONRequestOperation *operation2 = [AFJSONRequestOperation JSONRequestOperationWithRequest:request2 success:^(NSURLRequest *request2, NSHTTPURLResponse *response, id JSON) {
        
        for (int i = 0; i < 1; i++) {
            NSString *animalsAssetsLink = @"http://www.junglebattle.com/img/";
            
            NSString *videoId = [[JSON valueForKeyPath:@"video_id"] objectAtIndex:i];
            NSString *animal1Name = [[JSON valueForKeyPath:@"animal1"] objectAtIndex:i];
            NSString *animal2Name = [[JSON valueForKeyPath:@"animal2"] objectAtIndex:i];
            
            NSString *youtubeLink = @"http://www.youtube.com/watch?v=";
            youtubeLink = [youtubeLink stringByAppendingString:videoId];
            
            urlForVote = @"http://www.junglebattle.com/api/vote/";
            urlForVote = [urlForVote stringByAppendingString:videoId];
            
            NSString *imageLeft = animal1Name;
            NSString *imageRight = animal2Name;
            
            NSString *animal1ImageLink = @"";
            NSString *animal2ImageLink = @"";
            
            UIView *viewLeft = (UIView*)[self.view viewWithTag:42];
            UIView *viewRight = (UIView*)[self.view viewWithTag:43];
            
            if ([imageLeft isEqualToString:@"cat"]) {
                animal1ImageLink = [animalsAssetsLink stringByAppendingString: @"CHAT.png"];
            }else if ([imageLeft isEqualToString:@"dog"]) {
                animal1ImageLink = [animalsAssetsLink stringByAppendingString: @"CHIEN.png"];
            }else if ([imageLeft isEqualToString:@"bird"]) {
                animal1ImageLink = [animalsAssetsLink stringByAppendingString: @"OISEAU.png"];
            }else if ([imageLeft isEqualToString:@"mouse"]) {
                animal1ImageLink = [animalsAssetsLink stringByAppendingString: @"SOURIS.png"];
            }else if ([imageLeft isEqualToString:@"ostrich"]) {
                animal1ImageLink = [animalsAssetsLink stringByAppendingString: @"AUTRUCHE.png"];
            }else if ([imageLeft isEqualToString:@"horse"]) {
                animal1ImageLink = [animalsAssetsLink stringByAppendingString: @"CHEVAL.png"];
            }else if ([imageLeft isEqualToString:@"goat"]) {
                animal1ImageLink = [animalsAssetsLink stringByAppendingString: @"CHEVRE.png"];
            }else if ([imageLeft isEqualToString:@"pig"]) {
                animal1ImageLink = [animalsAssetsLink stringByAppendingString: @"COCHON.png"];
            }else if ([imageLeft isEqualToString:@"crocodile"]) {
                animal1ImageLink = [animalsAssetsLink stringByAppendingString: @"CROCO.png"];
            }else if ([imageLeft isEqualToString:@"elephant"]) {
                animal1ImageLink = [animalsAssetsLink stringByAppendingString: @"ELEPHANT.png"];
            }else if ([imageLeft isEqualToString:@"giraffe"]) {
                animal1ImageLink = [animalsAssetsLink stringByAppendingString: @"GIRAFE.png"];
            }else if ([imageLeft isEqualToString:@"hippo"]) {
                animal1ImageLink = [animalsAssetsLink stringByAppendingString: @"HIPPO.png"];
            }else if ([imageLeft isEqualToString:@"man"]) {
                animal1ImageLink = [animalsAssetsLink stringByAppendingString: @"HOMME.png"];
            }else if ([imageLeft isEqualToString:@"rabbit"]) {
                animal1ImageLink = [animalsAssetsLink stringByAppendingString: @"LAPIN.png"];
            }else if ([imageLeft isEqualToString:@"lion"]) {
                animal1ImageLink = [animalsAssetsLink stringByAppendingString: @"LION.png"];
            }else if ([imageLeft isEqualToString:@"sheep"]) {
                animal1ImageLink = [animalsAssetsLink stringByAppendingString: @"MOUTON.png"];
            }else if ([imageLeft isEqualToString:@"bear"]) {
                animal1ImageLink = [animalsAssetsLink stringByAppendingString: @"OURS.png"];
            }else if ([imageLeft isEqualToString:@"chicken"]) {
                animal1ImageLink = [animalsAssetsLink stringByAppendingString: @"POULET.png"];
            }else if ([imageLeft isEqualToString:@"shark"]) {
                animal1ImageLink = [animalsAssetsLink stringByAppendingString: @"REQUIN.png"];
            }else if ([imageLeft isEqualToString:@"rhino"]) {
                animal1ImageLink = [animalsAssetsLink stringByAppendingString: @"RHINO.png"];
            }else if ([imageLeft isEqualToString:@"snake"]) {
                animal1ImageLink = [animalsAssetsLink stringByAppendingString: @"SERPENT.png"];
            }else if ([imageLeft isEqualToString:@"monkey"]) {
                animal1ImageLink = [animalsAssetsLink stringByAppendingString: @"OISEAU.png"];
            }else if ([imageLeft isEqualToString:@"tiger"]) {
                animal1ImageLink = [animalsAssetsLink stringByAppendingString: @"SINGE.png"];
            }else if ([imageLeft isEqualToString:@"cow"]) {
                animal1ImageLink = [animalsAssetsLink stringByAppendingString: @"VACHE.png"];
            }else if ([imageLeft isEqualToString:@"zebra"]) {
                animal1ImageLink = [animalsAssetsLink stringByAppendingString: @"ZEBRE.png"];
            }
            
            if ([imageRight isEqualToString:@"cat"]) {
                animal2ImageLink = [animalsAssetsLink stringByAppendingString: @"CHAT.png"];
            }else if ([imageRight isEqualToString:@"dog"]) {
                animal2ImageLink = [animalsAssetsLink stringByAppendingString: @"CHIEN.png"];
            }else if ([imageRight isEqualToString:@"bird"]) {
                animal2ImageLink = [animalsAssetsLink stringByAppendingString: @"OISEAU.png"];
            }else if ([imageRight isEqualToString:@"mouse"]) {
                animal2ImageLink = [animalsAssetsLink stringByAppendingString: @"SOURIS.png"];
            }else if ([imageRight isEqualToString:@"ostrich"]) {
                animal2ImageLink = [animalsAssetsLink stringByAppendingString: @"AUTRUCHE.png"];
            }else if ([imageRight isEqualToString:@"horse"]) {
                animal2ImageLink = [animalsAssetsLink stringByAppendingString: @"CHEVAL.png"];
            }else if ([imageRight isEqualToString:@"goat"]) {
                animal2ImageLink = [animalsAssetsLink stringByAppendingString: @"CHEVRE.png"];
            }else if ([imageRight isEqualToString:@"pig"]) {
                animal2ImageLink = [animalsAssetsLink stringByAppendingString: @"COCHON.png"];
            }else if ([imageRight isEqualToString:@"crocodile"]) {
                animal2ImageLink = [animalsAssetsLink stringByAppendingString: @"CROCO.png"];
            }else if ([imageRight isEqualToString:@"elephant"]) {
                animal2ImageLink = [animalsAssetsLink stringByAppendingString: @"ELEPHANT.png"];
            }else if ([imageRight isEqualToString:@"giraffe"]) {
                animal2ImageLink = [animalsAssetsLink stringByAppendingString: @"GIRAFE.png"];
            }else if ([imageRight isEqualToString:@"hippo"]) {
                animal2ImageLink = [animalsAssetsLink stringByAppendingString: @"HIPPO.png"];
            }else if ([imageRight isEqualToString:@"man"]) {
                animal2ImageLink = [animalsAssetsLink stringByAppendingString: @"HOMME.png"];
            }else if ([imageRight isEqualToString:@"rabbit"]) {
                animal2ImageLink = [animalsAssetsLink stringByAppendingString: @"LAPIN.png"];
            }else if ([imageRight isEqualToString:@"lion"]) {
                animal2ImageLink = [animalsAssetsLink stringByAppendingString: @"LION.png"];
            }else if ([imageRight isEqualToString:@"sheep"]) {
                animal2ImageLink = [animalsAssetsLink stringByAppendingString: @"MOUTON.png"];
            }else if ([imageRight isEqualToString:@"bear"]) {
                animal2ImageLink = [animalsAssetsLink stringByAppendingString: @"OURS.png"];
            }else if ([imageRight isEqualToString:@"chicken"]) {
                animal2ImageLink = [animalsAssetsLink stringByAppendingString: @"POULET.png"];
            }else if ([imageRight isEqualToString:@"shark"]) {
                animal2ImageLink = [animalsAssetsLink stringByAppendingString: @"REQUIN.png"];
            }else if ([imageRight isEqualToString:@"rhino"]) {
                animal2ImageLink = [animalsAssetsLink stringByAppendingString: @"RHINO.png"];
            }else if ([imageRight isEqualToString:@"snake"]) {
                animal2ImageLink = [animalsAssetsLink stringByAppendingString: @"SERPENT.png"];
            }else if ([imageRight isEqualToString:@"monkey"]) {
                animal2ImageLink = [animalsAssetsLink stringByAppendingString: @"OISEAU.png"];
            }else if ([imageRight isEqualToString:@"tiger"]) {
                animal2ImageLink = [animalsAssetsLink stringByAppendingString: @"SINGE.png"];
            }else if ([imageRight isEqualToString:@"cow"]) {
                animal2ImageLink = [animalsAssetsLink stringByAppendingString: @"VACHE.png"];
            }else if ([imageRight isEqualToString:@"zebra"]) {
                animal2ImageLink = [animalsAssetsLink stringByAppendingString: @"ZEBRE.png"];
            }
            
            animalLeftName.text = imageLeft;
            animalRightName.text = imageRight;
            
            [animal1ImageLink lowercaseString];
            [animal2ImageLink lowercaseString];
            
            UIImageView *image = [[UIImageView alloc] init];
            [image setImageWithURL:[NSURL URLWithString:animal1ImageLink]];
            image.contentMode = UIViewContentModeScaleAspectFit;
            image.frame = CGRectMake(0, 0, 53, 53);
            image.backgroundColor = [UIColor clearColor];
            [viewLeft addSubview:image];
            
            
            
            UIImageView *image2 = [[UIImageView alloc] init];
            [image2 setImageWithURL:[NSURL URLWithString:animal2ImageLink]];
            image2.contentMode = UIViewContentModeScaleAspectFit;
            image2.frame = CGRectMake(0, 0, 53, 53);
            image2.backgroundColor = [UIColor clearColor];
            [viewRight addSubview:image2];
            
            [self playVideo:youtubeLink
                      frame:CGRectMake(
                                       16,
                                       130,
                                       290,
                                       163)];
            
            
            NSLog(@"%@", videoId);
        }
        
    } failure:nil];
    [operation2 start];
}



- (void) tick:(NSTimer *) timer {
    //do something here..
    NSURL *url = [NSURL URLWithString:@"http://www.junglebattle.com/api/animals"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
        for (int i = 0; i < 3; i++)
        {
            NSString *animalsAssetsLink = @"http://www.junglebattle.com/img/";
            
            animalsAssetsLink = [animalsAssetsLink stringByAppendingString:[[JSON valueForKeyPath:@"image"] objectAtIndex:i]];
            
            UIView *view = [[UIView alloc] initWithFrame:CGRectMake((53 * i) + 145, 35, 98/2, 98/2)];
            view.backgroundColor = [UIColor clearColor];
            //
            UIImageView *image = [[UIImageView alloc] init];
            [image setImageWithURL:[NSURL URLWithString:animalsAssetsLink]];
            image.contentMode = UIViewContentModeScaleAspectFit;
            image.frame = CGRectMake(0, 0, 53, 53);
            image.backgroundColor = [UIColor clearColor];
            [view addSubview:image];
            
            
            UIImageView *ribbon = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[NSString stringWithFormat:@"COCARDE%d.png", i + 1]]];
            ribbon.contentMode = UIViewContentModeScaleAspectFit;
            ribbon.frame = CGRectMake(0, 0, 32, 32);
            
            [view addSubview:ribbon];
            [self.view addSubview:view];
        }
    } failure:nil];
    [operation start];
}

#pragma mark - gestion du toucher

- (BOOL) canBecomeFirstResponder{
    return YES; //La vue se charge de prendre les évènements
}

- (void) motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event{
    
    if (motion == UIEventSubtypeMotionShake)
    {
        NSURL *url = [NSURL URLWithString:@"http://www.junglebattle.com/api/videos/1"];
        NSURLRequest *request = [NSURLRequest requestWithURL:url];
        AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
            
            for (int i = 0; i < 1; i++) {
                NSString *animalsAssetsLink = @"http://www.junglebattle.com/img/";
                
                NSString *videoId = [[JSON valueForKeyPath:@"video_id"] objectAtIndex:i];
                NSString *animal1Name = [[JSON valueForKeyPath:@"animal1"] objectAtIndex:i];
                NSString *animal2Name = [[JSON valueForKeyPath:@"animal2"] objectAtIndex:i];
                
                NSString *youtubeLink = @"http://www.youtube.com/watch?v=";
                youtubeLink = [youtubeLink stringByAppendingString:videoId];

                urlForVote = @"http://www.junglebattle.com/api/vote/";
                urlForVote = [urlForVote stringByAppendingString:videoId];
                
                NSString *imageLeft = animal1Name;
                NSString *imageRight = animal2Name;
                
                NSString *animal1ImageLink = @"";
                NSString *animal2ImageLink = @"";
                
                UIView *viewLeft = (UIView*)[self.view viewWithTag:42];
                UIView *viewRight = (UIView*)[self.view viewWithTag:43];
                
                if ([imageLeft isEqualToString:@"cat"]) {
                    animal1ImageLink = [animalsAssetsLink stringByAppendingString: @"CHAT.png"];
                }else if ([imageLeft isEqualToString:@"dog"]) {
                    animal1ImageLink = [animalsAssetsLink stringByAppendingString: @"CHIEN.png"];
                }else if ([imageLeft isEqualToString:@"bird"]) {
                    animal1ImageLink = [animalsAssetsLink stringByAppendingString: @"OISEAU.png"];
                }else if ([imageLeft isEqualToString:@"mouse"]) {
                    animal1ImageLink = [animalsAssetsLink stringByAppendingString: @"SOURIS.png"];
                }else if ([imageLeft isEqualToString:@"ostrich"]) {
                    animal1ImageLink = [animalsAssetsLink stringByAppendingString: @"AUTRUCHE.png"];
                }else if ([imageLeft isEqualToString:@"horse"]) {
                    animal1ImageLink = [animalsAssetsLink stringByAppendingString: @"CHEVAL.png"];
                }else if ([imageLeft isEqualToString:@"goat"]) {
                    animal1ImageLink = [animalsAssetsLink stringByAppendingString: @"CHEVRE.png"];
                }else if ([imageLeft isEqualToString:@"pig"]) {
                    animal1ImageLink = [animalsAssetsLink stringByAppendingString: @"COCHON.png"];
                }else if ([imageLeft isEqualToString:@"crocodile"]) {
                    animal1ImageLink = [animalsAssetsLink stringByAppendingString: @"CROCO.png"];
                }else if ([imageLeft isEqualToString:@"elephant"]) {
                    animal1ImageLink = [animalsAssetsLink stringByAppendingString: @"ELEPHANT.png"];
                }else if ([imageLeft isEqualToString:@"giraffe"]) {
                    animal1ImageLink = [animalsAssetsLink stringByAppendingString: @"GIRAFE.png"];
                }else if ([imageLeft isEqualToString:@"hippo"]) {
                    animal1ImageLink = [animalsAssetsLink stringByAppendingString: @"HIPPO.png"];
                }else if ([imageLeft isEqualToString:@"man"]) {
                    animal1ImageLink = [animalsAssetsLink stringByAppendingString: @"HOMME.png"];
                }else if ([imageLeft isEqualToString:@"rabbit"]) {
                    animal1ImageLink = [animalsAssetsLink stringByAppendingString: @"LAPIN.png"];
                }else if ([imageLeft isEqualToString:@"lion"]) {
                    animal1ImageLink = [animalsAssetsLink stringByAppendingString: @"LION.png"];
                }else if ([imageLeft isEqualToString:@"sheep"]) {
                    animal1ImageLink = [animalsAssetsLink stringByAppendingString: @"MOUTON.png"];
                }else if ([imageLeft isEqualToString:@"bear"]) {
                    animal1ImageLink = [animalsAssetsLink stringByAppendingString: @"OURS.png"];
                }else if ([imageLeft isEqualToString:@"chicken"]) {
                    animal1ImageLink = [animalsAssetsLink stringByAppendingString: @"POULET.png"];
                }else if ([imageLeft isEqualToString:@"shark"]) {
                    animal1ImageLink = [animalsAssetsLink stringByAppendingString: @"REQUIN.png"];
                }else if ([imageLeft isEqualToString:@"rhino"]) {
                    animal1ImageLink = [animalsAssetsLink stringByAppendingString: @"RHINO.png"];
                }else if ([imageLeft isEqualToString:@"snake"]) {
                    animal1ImageLink = [animalsAssetsLink stringByAppendingString: @"SERPENT.png"];
                }else if ([imageLeft isEqualToString:@"monkey"]) {
                    animal1ImageLink = [animalsAssetsLink stringByAppendingString: @"OISEAU.png"];
                }else if ([imageLeft isEqualToString:@"tiger"]) {
                    animal1ImageLink = [animalsAssetsLink stringByAppendingString: @"SINGE.png"];
                }else if ([imageLeft isEqualToString:@"cow"]) {
                    animal1ImageLink = [animalsAssetsLink stringByAppendingString: @"VACHE.png"];
                }else if ([imageLeft isEqualToString:@"zebra"]) {
                    animal1ImageLink = [animalsAssetsLink stringByAppendingString: @"ZEBRE.png"];
                }
                
                if ([imageRight isEqualToString:@"cat"]) {
                    animal2ImageLink = [animalsAssetsLink stringByAppendingString: @"CHAT.png"];
                }else if ([imageRight isEqualToString:@"dog"]) {
                    animal2ImageLink = [animalsAssetsLink stringByAppendingString: @"CHIEN.png"];
                }else if ([imageRight isEqualToString:@"bird"]) {
                    animal2ImageLink = [animalsAssetsLink stringByAppendingString: @"OISEAU.png"];
                }else if ([imageRight isEqualToString:@"mouse"]) {
                    animal2ImageLink = [animalsAssetsLink stringByAppendingString: @"SOURIS.png"];
                }else if ([imageRight isEqualToString:@"ostrich"]) {
                    animal2ImageLink = [animalsAssetsLink stringByAppendingString: @"AUTRUCHE.png"];
                }else if ([imageRight isEqualToString:@"horse"]) {
                    animal2ImageLink = [animalsAssetsLink stringByAppendingString: @"CHEVAL.png"];
                }else if ([imageRight isEqualToString:@"goat"]) {
                    animal2ImageLink = [animalsAssetsLink stringByAppendingString: @"CHEVRE.png"];
                }else if ([imageRight isEqualToString:@"pig"]) {
                    animal2ImageLink = [animalsAssetsLink stringByAppendingString: @"COCHON.png"];
                }else if ([imageRight isEqualToString:@"crocodile"]) {
                    animal2ImageLink = [animalsAssetsLink stringByAppendingString: @"CROCO.png"];
                }else if ([imageRight isEqualToString:@"elephant"]) {
                    animal2ImageLink = [animalsAssetsLink stringByAppendingString: @"ELEPHANT.png"];
                }else if ([imageRight isEqualToString:@"giraffe"]) {
                    animal2ImageLink = [animalsAssetsLink stringByAppendingString: @"GIRAFE.png"];
                }else if ([imageRight isEqualToString:@"hippo"]) {
                    animal2ImageLink = [animalsAssetsLink stringByAppendingString: @"HIPPO.png"];
                }else if ([imageRight isEqualToString:@"man"]) {
                    animal2ImageLink = [animalsAssetsLink stringByAppendingString: @"HOMME.png"];
                }else if ([imageRight isEqualToString:@"rabbit"]) {
                    animal2ImageLink = [animalsAssetsLink stringByAppendingString: @"LAPIN.png"];
                }else if ([imageRight isEqualToString:@"lion"]) {
                    animal2ImageLink = [animalsAssetsLink stringByAppendingString: @"LION.png"];
                }else if ([imageRight isEqualToString:@"sheep"]) {
                    animal2ImageLink = [animalsAssetsLink stringByAppendingString: @"MOUTON.png"];
                }else if ([imageRight isEqualToString:@"bear"]) {
                    animal2ImageLink = [animalsAssetsLink stringByAppendingString: @"OURS.png"];
                }else if ([imageRight isEqualToString:@"chicken"]) {
                    animal2ImageLink = [animalsAssetsLink stringByAppendingString: @"POULET.png"];
                }else if ([imageRight isEqualToString:@"shark"]) {
                    animal2ImageLink = [animalsAssetsLink stringByAppendingString: @"REQUIN.png"];
                }else if ([imageRight isEqualToString:@"rhino"]) {
                    animal2ImageLink = [animalsAssetsLink stringByAppendingString: @"RHINO.png"];
                }else if ([imageRight isEqualToString:@"snake"]) {
                    animal2ImageLink = [animalsAssetsLink stringByAppendingString: @"SERPENT.png"];
                }else if ([imageRight isEqualToString:@"monkey"]) {
                    animal2ImageLink = [animalsAssetsLink stringByAppendingString: @"OISEAU.png"];
                }else if ([imageRight isEqualToString:@"tiger"]) {
                    animal2ImageLink = [animalsAssetsLink stringByAppendingString: @"SINGE.png"];
                }else if ([imageRight isEqualToString:@"cow"]) {
                    animal2ImageLink = [animalsAssetsLink stringByAppendingString: @"VACHE.png"];
                }else if ([imageRight isEqualToString:@"zebra"]) {
                    animal2ImageLink = [animalsAssetsLink stringByAppendingString: @"ZEBRE.png"];
                }
                
                animalLeftName.text = imageLeft;
                animalRightName.text = imageRight;
                
                
                [animal1ImageLink lowercaseString];
                [animal2ImageLink lowercaseString];
                
                UIImageView *image = [[UIImageView alloc] init];
                [image setImageWithURL:[NSURL URLWithString:animal1ImageLink]];
                image.contentMode = UIViewContentModeScaleAspectFit;
                image.frame = CGRectMake(0, 0, 53, 53);
                image.backgroundColor = [UIColor clearColor];
                [viewLeft addSubview:image];
                
                
                
                UIImageView *image2 = [[UIImageView alloc] init];
                [image2 setImageWithURL:[NSURL URLWithString:animal2ImageLink]];
                image2.contentMode = UIViewContentModeScaleAspectFit;
                image2.frame = CGRectMake(0, 0, 53, 53);
                image2.backgroundColor = [UIColor clearColor];
                [viewRight addSubview:image2];
                
                [self playVideo:youtubeLink
                          frame:CGRectMake(
                                           16,
                                           130,
                                           290,
                                           163)];
                
                
                
            }
            
        } failure:nil];
        [operation start];
    }
    [super motionEnded:motion withEvent:event];
}


//On génère un chiffre entre 0 et le nombre de photographies affichées
- (void) motionBegan:(UIEventSubtype)motion withEvent:(UIEvent *)event{
    if (motion == UIEventSubtypeMotionShake) {
        randomNumber = arc4random() % [randomAnimalVideo count];
//        NSLog(@"%i", [randomAnimalVideo count]);
    }
    [super motionBegan:motion withEvent:event];
}
//Gestion du shake

- (void)playVideo:(NSString *)urlString frame:(CGRect)frame
{
    
    
    NSString *embedHTML = @"\
    <html><head>\
    <style type=\"text/css\">\
    body {\
    background-color: transparent;\
    color: black;\
    }\
    </style>\
    </head><body style=\"margin:0\">\
    <embed id=\"yt\" src=\"%@\" type=\"application/x-shockwave-flash\" \
    width=\"%0.0f\" height=\"%0.0f\"></embed>\
    </body></html>";
    
    NSString *html = [NSString stringWithFormat:embedHTML, urlString, frame.size.width, frame.size.height];
    
    
    
    UIWebView *videoView = [[UIWebView alloc] initWithFrame:frame];
    [videoView loadHTMLString:html baseURL:nil];
    
    [self.view addSubview:videoView];
//    [self.view addSubview:label];
}

- (void)voteForAnimal:(UIGestureRecognizer *)gesture{
    UIView *index = gesture.view;
    
    NSString *url = @"";
    
    if (index.tag == 42) { //On vote pour l'animal de gauche
        url = [urlForVote stringByAppendingString: @"/1"];
    }else if(index.tag == 43){
        url = [urlForVote stringByAppendingString: @"/2"];
    }

    NSData *dummyData = [NSData dataWithContentsOfURL:[NSURL URLWithString:url]];
    
//    [[UIApplication sharedApplication] openURL:[NSURL URLWithString: url]];
}
 
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
