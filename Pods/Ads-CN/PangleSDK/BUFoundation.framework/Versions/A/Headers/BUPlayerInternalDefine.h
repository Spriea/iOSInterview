//
//  BUPlayerInternalDefine.h
//  BUFoundation
//
//  Created by bytedance on 2020/12/17.
//

#ifndef BUPlayerInternalDefine_h
#define BUPlayerInternalDefine_h

typedef NS_ENUM(NSInteger, BUVideoPlayerState) {
    BUVideoPlayerStateFailed    = 0,
    BUVideoPlayerStateBuffering = 1,
    BUVideoPlayerStatePlaying   = 2,
    BUVideoPlayerStateStopped   = 3,
    BUVideoPlayerStatePause     = 4,
    BUVideoPlayerStateDefalt    = 5
};

@class BUPlayer;

@protocol BUVideoPlayerDelegate <NSObject>

@optional
/**
 This method is called when the player status changes.
 */
- (void)player:(BUPlayer *)player stateDidChanged:(BUVideoPlayerState)playerState;
/**
 This method is called when the player is ready.
 */
- (void)playerReadyToPlay:(BUPlayer *)player;
/**
 This method is called when the player plays completion or occurrs error.
 */
- (void)playerDidPlayFinish:(BUPlayer *)player error:(NSError *)error;

/**
 This method is called when the player is clicked.
 */
- (void)player:(BUPlayer *)player recognizeTapGesture:(UITapGestureRecognizer *)gesture;


/**
 This method is called when the view is clicked during ad play.
 */
- (void)playerTouchesBegan:(BUPlayer *)player;

@end


#endif /* BUPlayerInternalDefine_h */
