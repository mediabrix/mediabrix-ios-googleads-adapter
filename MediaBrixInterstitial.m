//
//  MediaBrixInterstitial.m
//  AdMob iOS
//
//  Created by Muhammad Zubair on 7/11/16.
//  Copyright © 2016 MediaBrix. All rights reserved.
//

#import "MediaBrixInterstitial.h"

@interface MediaBrixInterstitial()

@property(nonatomic) NSString* APP_ID;
@property(nonatomic) NSString* ZONE;
@end

@implementation MediaBrixInterstitial 
@synthesize delegate;
- (void)requestInterstitialAdWithParameter:(NSString *)serverParameter
                                     label:(NSString *)serverLabel
                                   request:(GADCustomEventRequest *)request {
    _APP_ID = @"";
    _ZONE = @"";
    id callbackDelegate = self;
    [MediaBrix initMediaBrixAdHandler:callbackDelegate withBaseURL:@"http://mobile.mediabrix.com/v2/manifest" withAppID:_APP_ID]; // Replace APP_ID with the app id provided to you by MediaBrix
}

- (void)presentFromRootViewController:(UIViewController *)rootViewController {
    [self.delegate customEventInterstitialWillPresent:self];
    [[MediaBrix sharedInstance]showAdWithIdentifier:_ZONE fromViewController:nil reloadWhenFinish:NO];
}

- (void)mediaBrixAdHandler:(NSNotification *)notification { // implementing this function for notifications is required
    NSString * adIdentifier =[notification.userInfo objectForKey:kMediabrixTargetAdTypeKey]; //adIndentifier refers to zone that you are attempting to load/show
    if ([kMediaBrixStarted isEqualToString:notification.name]) {
        [[MediaBrix sharedInstance]loadAdWithIdentifier:_ZONE adData:_publisherVars withViewController:nil];
    }else if([kMediaBrixAdWillLoadNotification isEqualToString:notification.name]){
        // Invoked when the ad has been requested
    }
    else if([kMediaBrixAdFailedNotification isEqualToString:notification.name]){
        // Invoked when the ad fails to load an ad
        NSError *error = [NSError errorWithDomain:@"No_Ad_Returned"
                                             code:200
                                         userInfo:nil];
        [self.delegate customEventInterstitial:self didFailAd:error];
    }
    else if([kMediaBrixAdReadyNotification isEqualToString:notification.name]){
        // Invoked when ad has succesfully downloaded and is ready to show
        [self.delegate customEventInterstitialDidReceiveAd:self];
    }
    else if([kMediaBrixAdShowNotification isEqualToString:notification.name]){
        // Invoked when ad is being shown to the user
    }
    else if([kMediaBrixAdDidCloseNotification isEqualToString:notification.name]){
        // Invoked when the ad is closed
        [self.delegate customEventInterstitialDidDismiss:self];
    }
    else if([ kMediaBrixAdRewardNotification isEqualToString:notification.name]){
        // Invoked when the user has watched an ad that offers an incentive and reward should be given
    }
    else if([ kMediaBrixAdClickedNotification isEqualToString:notification.name]){
        // Invoked when the user has clicked the ad
        [self.delegate customEventInterstitialWasClicked:self];
        [self.delegate customEventInterstitialWillLeaveApplication:self];
    }
}

@end
