//
//  ATAdManager+Internal.h
//  AnyThinkSDK
//
//  Created by Martin Lau on 04/05/2018.
//  Copyright © 2018 Martin Lau. All rights reserved.
//

/**
 * This file contains methods&properties implemented by ATAdManager intented for internal use only.
 */
#ifndef ATAdManager_Internal_h
#define ATAdManager_Internal_h
#import "ATAdManager.h"
#import "ATAd.h"
//The value is (subclass of) UIViewController
extern NSString *const kExtraInfoRootViewControllerKey;
extern NSString *const kAdLoadingExtraRefreshFlagKey;//Defined in loader
extern NSString *const kAdLoadingExtraAutoloadFlagKey;
extern NSString *const kAdLoadingTrackingExtraStatusKey;
extern NSString *const kAdLoadingTrackingExtraFlagKey;
extern NSString *const kAdLoadingExtraDefaultLoadKey;
extern NSString *const kAdLoadingExtraFilledByReadyFlagKey;
extern NSString *const kAdLoadingExtraAutoLoadOnCloseFlagKey;

/*
 Defined in Storage Utility
 */
extern NSString *const kAdStorageExtraNotReadyReasonKey;
extern NSString *const kAdStorageExtraNeedReloadFlagKey;
extern NSString *const kAdStorageExtraPlacementIDKey;
extern NSString *const kAdStorageExtraRequestIDKey;
extern NSString *const kAdStorageExtraReadyFlagKey;
extern NSString *const kAdStorageExtraCallerInfoKey;
extern NSString *const kAdStorageExtraPSIDKey;
extern NSString *const kAdStorageExtraSessionIDKey;
extern NSString *const kAdStorageExtraHeaderBiddingInfo;
extern NSString *const kAdStoreageExtraUnitGroupUnitID;
extern NSString *const kAdStorageExtraNetworkFirmIDKey;
extern NSString *const kAdStorageExtraNetworkSDKVersion;
extern NSString *const kAdStorageExtraPriorityKey;
extern NSString *const kAdStorageExtraUnitGroupInfosKey;
extern NSString *const kAdStorageExtraUnitGroupInfoContentKey;
extern NSString *const kAdStorageExtraUnitGroupInfoPriorityKey;
extern NSString *const kAdStorageExtraUnitGroupInfoNetworkFirmIDKey;
extern NSString *const kAdStorageExtraUnitGroupInfoUnitIDKey;
extern NSString *const kAdStorageExtraUnitGroupInfoNetworkSDKVersionKey;
extern NSString *const kAdStorageExtraUnitGroupInfoReadyFlagKey;
extern NSString *const kAdStorageExtraFinalWaterfallKey;

typedef NS_ENUM(NSInteger, ATAdManagerReadyAPICaller) {
    ATAdManagerReadyAPICallerReady = 0,
    ATAdManagerReadyAPICallerShow = 1
};
@interface ATAdManager(Internal)
#pragma mark - for inner usage
//TODO: Packing the following method in a category and hide it from the client code.
/**
 The following ps id accessing methods are thread-safe.
 */
-(void) clearPSID;
-(void) setPSID:(NSString*)psID interval:(NSTimeInterval)interval;
-(BOOL) psIDExpired;
@property(nonatomic, readonly) dispatch_queue_t show_api_control_queue;
@property(nonatomic, readonly) NSString *psID;

/**
 Contains all the placement ids the developer has configured for this app. This property is thread-safe.
 */
@property(nonatomic, readonly) NSSet *placementIDs;

/**
 placementID will be added and stored if it's not previous been added, otherwise do nothing.
 This method is thread-safe.
 */
-(void) addNewPlacementID:(NSString*)placementID;

/**
 nil might be returned on one of the following conditions:
 1) No offer's been successfully loaded for the placement;
 2) Pacing/caps has exceeded the limit.
 when this happens, clients are expected to behave as if ad load request has failed.
 */
-(id<ATAd>) offerWithPlacementID:(NSString*)placementID error:(NSError**)error refresh:(BOOL)refresh;

/*
 Check if ad's ready for a placement, context is a storage specific block
 */
- (BOOL)adReadyForPlacementID:(NSString*)placementID scene:(NSString*)scene caller:(ATAdManagerReadyAPICaller)caller context:(BOOL(^)(NSDictionary *__autoreleasing *extra))context;
- (BOOL)adReadyForPlacementID:(NSString*)placementID caller:(ATAdManagerReadyAPICaller)caller context:(BOOL(^)(NSDictionary *__autoreleasing *extra))context;
- (BOOL)adReadyForPlacementID:(NSString*)placementID scene:(NSString*)scene caller:(ATAdManagerReadyAPICaller)caller sendTK:(BOOL)send context:(BOOL(^)(NSDictionary *__autoreleasing *extra))context;

/*
 *For internal use only
 */
- (BOOL)adReadyForPlacementID:(NSString*)placementID;
- (BOOL)adReadyForPlacementID:(NSString*)placementID sendTK:(BOOL)send;


-(NSDictionary*)extraInfoForPlacementID:(NSString*)placementID requestID:(NSString*)requestID;
-(void) setExtraInfo:(NSDictionary*)extraInfo forPlacementID:(NSString*)placementID requestID:(NSString*)requestID;
-(void) removeExtraInfoForPlacementID:(NSString*)placementID requestID:(NSString*)requestID;
-(NSDictionary*)lastExtraInfoForPlacementID:(NSString*)placementID;
-(void) clearCacheWithPlacementModel:(ATPlacementModel*)placementModel unitGroupModel:(ATUnitGroupModel*)unitGroupModel;

-(void) setAdBeingShownFlagForPlacementID:(NSString*)placementID;
-(void) clearAdBeingShownFlagForPlacementID:(NSString*)placementID;
-(BOOL) adBeingShownForPlacementID:(NSString*)placementID;
@end

@interface NSObject(DelegateBinding)
@property(nonatomic, weak) id delegateToBePassed;
@end
#endif /* ATAdManager_Internal_h */
