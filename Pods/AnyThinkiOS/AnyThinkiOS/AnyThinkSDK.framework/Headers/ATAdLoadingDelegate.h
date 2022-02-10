//
//  ATAdLoadingDelegate.h
//  AnyThinkSDK
//
//  Created by Martin Lau on 04/07/2018.
//  Copyright © 2018 Martin Lau. All rights reserved.
//

#ifndef ATAdLoadingDelegate_h
#define ATAdLoadingDelegate_h
@protocol ATAdLoadingDelegate<NSObject>
-(void) didFinishLoadingADWithPlacementID:(NSString *)placementID;
-(void) didFailToLoadADWithPlacementID:(NSString*)placementID error:(NSError*)error;
@end
#endif /* ATAdLoadingDelegate_h */
