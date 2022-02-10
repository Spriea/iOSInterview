//
//  ATMyOfferOfferModel.h
//  AnyThinkMyOffer
//
//  Created by Martin Lau on 2019/9/23.
//  Copyright © 2019 Martin Lau. All rights reserved.
//

#import "ATOfferModel.h"
#import "ATMyOfferSetting.h"

@interface ATMyOfferOfferModel : ATOfferModel
-(instancetype) initWithDictionary:(NSDictionary *)dictionary placeholders:(NSDictionary*)placeholders format:(NSInteger)format setting:(ATMyOfferSetting*)setting;

@property(nonatomic, readwrite) ATScreenOrientation imageOrientation;
@property(nonatomic, readwrite) ATScreenOrientation videoOrientation;
@property(nonatomic, readwrite) NSString *videoStartTKURL;
@property(nonatomic, readwrite) NSString *video25TKURL;
@property(nonatomic, readwrite) NSString *video50TKURL;
@property(nonatomic, readwrite) NSString *video75TKURL;
@property(nonatomic, readwrite) NSString *videoEndTKURL;
@property(nonatomic, readwrite) NSString *endCardShowTKURL;
@property(nonatomic, readwrite) NSString *endCardCloseTKURL;
@property(nonatomic, readwrite) NSString *impURL;
@property(nonatomic, readwrite) NSString *impTKURL;
@property(nonatomic, readwrite) NSString *clickTKURL;
@property(nonatomic, readwrite) NSInteger dailyCap;
@property(nonatomic, readwrite) NSTimeInterval pacing;
@property(nonatomic, readwrite) NSDictionary<NSString*, NSString*> *placeholders;

//@property(nonatomic, readonly) NSInteger screenOrientation;
@property(nonatomic, readwrite) ATClickMode performsAsynchronousRedirection;


+(instancetype) mockOfferModel;
@end


