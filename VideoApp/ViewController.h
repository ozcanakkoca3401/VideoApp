//
//  ViewController.h
//  VideoApp
//
//  Created by Özcan AKKOCA on 11.01.2017.
//  Copyright © 2017 Özcan AKKOCA. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import <AVKit/AVKit.h>
#import <MediaPlayer/MediaPlayer.h>
#import "SRTParser.h"
#import "SDSRTParser.h"
#import "MPMoviePlayerController+Subtitles.h"



@interface ViewController : UIViewController <SRTParserDelegate, MPMediaPickerControllerDelegate,MPMediaPlayback>


@end

