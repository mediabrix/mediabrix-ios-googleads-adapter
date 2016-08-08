//
//  MediaBrixInterstitial.h
//  AdMob iOS
//
//  Created by Muhammad Zubair on 7/11/16.
//  Copyright © 2016 MediaBrix. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MediaBrix.h"
@import GoogleMobileAds;

@interface MediaBrixInterstitial : NSObject<GADCustomEventInterstitial>

@property(strong,nonatomic) NSMutableDictionary * publisherVars;

@end
