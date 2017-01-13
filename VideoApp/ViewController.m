//
//  ViewController.m
//  VideoApp
//
//  Created by Özcan AKKOCA on 11.01.2017.
//  Copyright © 2017 Özcan AKKOCA. All rights reserved.
//

// http://stackoverflow.com/questions/35722451/xcode-objective-c-avplayer-programmatically-play-local-video-with-standar
#import "ViewController.h"

@interface ViewController ()
    @property (nonatomic, retain) AVPlayerViewController *avPlayerViewcontroller;

@end

@implementation ViewController {
    SRTParser *_srtParser;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
/*
    NSURL *url = [[NSURL alloc] initWithString:@"https://s3-eu-west-1.amazonaws.com/alf-proeysen/Bakvendtland-MASTER.mp4"];
    AVPlayer *player = [AVPlayer playerWithURL:url];
    
    AVPlayerViewController *controller = [[AVPlayerViewController alloc] init];
    
    [self addChildViewController:controller];
    [self.view addSubview:controller.view];
    
    controller.view.frame = CGRectMake(50,50,250,100);
    controller.player = player;
    controller.showsPlaybackControls = YES;
    player.closedCaptionDisplayEnabled = NO;
    [player pause];
    [player play];
    
    
    AVPlayerItem * item = player.currentItem;
    
    if (item.status == AVPlayerItemStatusReadyToPlay) {
        NSArray * timeRangeArray = item.loadedTimeRanges;
        
        CMTimeRange aTimeRange = [[timeRangeArray objectAtIndex:0] CMTimeRangeValue];
        
        double startTime = CMTimeGetSeconds(aTimeRange.start);
        double loadedDuration = CMTimeGetSeconds(aTimeRange.duration);
        
        // FIXME: shoule we sum up all sections to have a total playable duration,
        // or we just use first section as whole?
        
        NSLog(@"get time range, its start is %f seconds, its duration is %f seconds.", startTime, loadedDuration);
    }
    
    ///////
    NSString *srtPath = [[NSBundle mainBundle] pathForResource:@"sample" ofType:@"srt"];
    SRTParser *srt = [[SRTParser alloc] initWithSRTFile:srtPath];
    srt.delegate = self;
    [srt parse];
    NSLog(@"-----%@ ???????", [srt.getSrtArray[0] objectAtIndex:2]);
    
    for (NSInteger i = 0; i < [srt.getSrtArray count]; i++) {
        [srt.getSrtArray[i] objectAtIndex:1];
    }
    
    ////////
    NSLog(@"/////////////////////////");
    SDSRTParser *parser = [[SDSRTParser alloc] init];
    //[parser loadFromString:@"1\n00:00:12,345 --> 00:00:34,567\nfoo\nbar\n\n..."];
    [parser loadFromString:@"1\n00:00:01,345 --> 00:00:02,567\nfoo\n\n 2\n00:00:01,320 --> 00:00:02,987\nThe storm continued" error:nil];
    
  //  @"1\n00:00:01,320 --> 00:00:02,987\nThe storm continued all night long, but nothing strange happened"
    for (SDSubtitle *subtitle in parser.subtitles)
    {
        [subtitle index];
        [subtitle startTime];
        [subtitle endTime];
        [subtitle content];
        NSLog(@"%@", [subtitle content]);

    }
    */
    
    // 1 - Load video asset
    NSURL *url = [[NSURL alloc] initWithString:@"https://s3-eu-west-1.amazonaws.com/alf-proeysen/Bakvendtland-MASTER.mp4"];

    AVAsset *videoAsset = [AVURLAsset assetWithURL:url];
    
    
    // 2 - Create AVMutableComposition object. This object will hold your AVMutableCompositionTrack instances.
    AVMutableComposition *mixComposition = [[AVMutableComposition alloc] init];
    
    // 3 - Video track
    AVMutableCompositionTrack *videoTrack = [mixComposition addMutableTrackWithMediaType:AVMediaTypeVideo
                                                                        preferredTrackID:kCMPersistentTrackID_Invalid];
    [videoTrack insertTimeRange:CMTimeRangeMake(kCMTimeZero, videoAsset.duration)
                        ofTrack:[[videoAsset tracksWithMediaType:AVMediaTypeVideo] objectAtIndex:0]
                         atTime:kCMTimeZero error:nil];

    // 4 - Audio track
    AVMutableCompositionTrack *audioTrack = [mixComposition addMutableTrackWithMediaType:AVMediaTypeAudio
                                                                        preferredTrackID:kCMPersistentTrackID_Invalid];
    [audioTrack insertTimeRange:CMTimeRangeMake(kCMTimeZero, videoAsset.duration)
                        ofTrack:[[videoAsset tracksWithMediaType:AVMediaTypeAudio] objectAtIndex:0]
                         atTime:kCMTimeZero error:nil];
  
    // 5 - Subtitle track
    AVURLAsset *subtitleAsset = [AVURLAsset assetWithURL:[[NSBundle mainBundle] URLForResource:@"trailer_720p" withExtension:@"vtt"]];
    
    AVMutableCompositionTrack *subtitleTrack = [mixComposition addMutableTrackWithMediaType:AVMediaTypeText
                                                                           preferredTrackID:kCMPersistentTrackID_Invalid];
    
    [subtitleTrack insertTimeRange:CMTimeRangeMake(kCMTimeZero, videoAsset.duration)
                           ofTrack:[[subtitleAsset tracksWithMediaType:AVMediaTypeText] objectAtIndex:0]
                            atTime:kCMTimeZero error:nil];
     
    // 6 - Set up player
    AVPlayer *player = [AVPlayer playerWithPlayerItem: [AVPlayerItem playerItemWithAsset:mixComposition]];
    
    AVPlayerViewController *controller = [[AVPlayerViewController alloc] init];
    
    [self addChildViewController:controller];
    [self.view addSubview:controller.view];
    
    controller.view.frame = CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.width);
    controller.player = player;
    controller.showsPlaybackControls = YES;
    player.closedCaptionDisplayEnabled = NO;
    [player pause];
    [player play];
     
  
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (void)parsingFinishedWithSubs:(NSArray *)subs
{
    NSLog(@"%@",subs);
}



@end
