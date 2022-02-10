//
//  ATWaterfallManager.h
//  AnyThinkSDK
//
//  Created by Martin Lau on 2020/4/28.
//  Copyright © 2020 AnyThink. All rights reserved.
//

#import <Foundation/Foundation.h>
@class ATUnitGroupModel;
@class ATPlacementModel;
typedef NS_ENUM(NSInteger, ATWaterfallType) {
    ATWaterfallTypeWaterfall = 0,
    ATWaterfallTypeHeaderBidding = 1,
    ATWaterfallTypeFinal = 2
};

typedef NS_ENUM(NSInteger, ATUnitGroupFinishType) {
    ATUnitGroupFinishTypeFinished = 0,
    ATUnitGroupFinishTypeTimeout = 1,
    ATUnitGroupFinishTypeFailed = 2
};

@interface ATWaterfallWrapper:NSObject
-(void) finish;
-(void) fill;
-(ATUnitGroupModel*) filledUnitGroupWithMaximumPrice;
@property(nonatomic) NSInteger numberOfCachedOffers;
@property(nonatomic, readonly, getter=isFilled) BOOL filled;
@property(nonatomic) BOOL headerBiddingFired;
@property(nonatomic) BOOL headerBiddingFailed;
@end

@interface ATWaterfall:NSObject
-(instancetype) initWithUnitGroups:(NSArray<ATUnitGroupModel*>*)unitGroups placementID:(NSString*)placementID requestID:(NSString*)requestID;
-(void) requestUnitGroup:(ATUnitGroupModel*)unitGroup;
-(void) finishUnitGroup:(ATUnitGroupModel*)unitGroup withType:(ATUnitGroupFinishType)type;
-(void) addUnitGroup:(ATUnitGroupModel*)unitGroup;
-(void) insertUnitGroup:(ATUnitGroupModel*)unitGroup price:(NSString *)price;
-(ATUnitGroupModel*) firstPendingNonHBUnitGroupWithNetworkFirmID:(NSInteger)nwFirmID;
-(ATUnitGroupModel*) unitGroupWithUnitID:(NSString*)unitID;
-(ATUnitGroupModel*) unitGroupWithMaximumPrice;
-(ATUnitGroupModel*) unitGroupWithMinimumPrice;
-(BOOL)canContinueLoading:(BOOL)waitForSentRequests;
-(void) enumerateTimeoutUnitGroupWithBlock:(void(^)(ATUnitGroupModel*unitGroup))block;
@property(nonatomic, readonly) NSMutableArray<ATUnitGroupModel*>* unitGroups;
@property(nonatomic, readonly) NSUInteger numberOfTimeoutRequests;
@property(nonatomic, readonly) ATWaterfallType type;
@property(nonatomic, readonly, getter=isLoading) BOOL loading;
@end

@interface ATWaterfallManager : NSObject
+(instancetype) sharedManager;
-(BOOL) loadingAdForPlacementID:(NSString*)placementID;
-(void) attachWaterfall:(ATWaterfall*)waterfall completion:(void(^)(ATWaterfallWrapper *waterfallWrapper, ATWaterfall *waterfall, ATWaterfall *headerBiddingWaterfall, ATWaterfall *finalWaterfall, BOOL finished, NSDate *loadStartDate))completion;
-(void) accessWaterfallForPlacementID:(NSString*)placementID requestID:(NSString*)requestID withBlock:(void(^)(ATWaterfallWrapper *waterfallWrapper, ATWaterfall *waterfall, ATWaterfall *headerBiddingWaterfall, ATWaterfall *finalWaterfall, BOOL finished, NSDate *loadStartDate))block;
@end
