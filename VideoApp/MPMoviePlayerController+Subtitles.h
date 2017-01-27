//
//  MPMoviePlayerController+Subtitles.h
//  VideoApp
//
//  Created by Özcan AKKOCA on 17.01.2017.
//  Copyright © 2017 Özcan AKKOCA. All rights reserved.
//

#import <MediaPlayer/MediaPlayer.h>

@interface MPMoviePlayerController (Subtitles)


#pragma mark - Methods
- (void)openSRTFileAtPath:(NSString *)localFile completion:(void (^)(BOOL finished))success failure:(void (^)(NSError *error))failure;
- (void)showSubtitles;
- (void)hideSubtitles;
@end
