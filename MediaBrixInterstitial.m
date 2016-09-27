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
    
    if(serverParameter){
        NSError *jsonError;
        NSData *objectData = [serverParameter dataUsingEncoding:NSUTF8StringEncoding];
        NSDictionary *adMobParams = [NSJSONSerialization JSONObjectWithData:objectData
                                                         options:NSJSONReadingMutableContainers
                                                           error:&jsonError];
        
        if(adMobParams){
            id callbackDelegate = self;
            
            if([adMobParams objectForKey:@"appID"])
                _APP_ID = adMobParams[@"appID"];
            else
                  NSLog(@"Please ensure that you have added appID in the parameters feild in the format that MediaBrix has provided");
            
            if([adMobParams objectForKey:@"zone"])
                _ZONE = adMobParams[@"zone"];
            else
                  NSLog(@"Please ensure that you have added zone in the parameters feild in the format that MediaBrix has provided");
            
            
            if([_ZONE length] > 0 && [_APP_ID length] > 0)
                [MediaBrix initMediaBrixDelegate:callbackDelegate withBaseURL:@"http://mobile.mediabrix.com/v2/manifest" withAppID:_APP_ID];
            else
                NSLog(@"Please add the parameters in the format that MediaBrix has provided into AdMob.");
            
        }else{
            NSLog(@"Please add the parameters in the format that MediaBrix has provided into AdMob.");
        }
    }else{
        NSLog(@"Please add the parameters in the format that MediaBrix has provided into AdMob.");
    }
}

- (void)presentFromRootViewController:(UIViewController *)rootViewController {
    [self.delegate customEventInterstitialWillPresent:self];
    [[MediaBrix sharedInstance]showAdWithIdentifier:_ZONE fromViewController:nil reloadWhenFinish:NO];
}

#pragma mark - <MediaBrixDelegate>
- (void)mediaBrixStarted {
    [[MediaBrix sharedInstance]loadAdWithIdentifier:_ZONE adData:_publisherVars withViewController:nil];
}

- (void)mediaBrixAdWillLoad:(NSString *)identifier {
    
}

- (void)mediaBrixAdFailed:(NSString *)identifier {
    NSError *error = [NSError errorWithDomain:@"No_Ad_Returned"
                                         code:200
                                     userInfo:nil];
    
    [self.delegate customEventInterstitial:self didFailAd:error];
    // Invoked when the ad fails to load an ad
}

- (void)mediaBrixAdReady:(NSString *)identifier {
    [self.delegate customEventInterstitialDidReceiveAd:self];
    // Invoked when ad has succesfully downloaded and is ready to show
}

- (void)mediaBrixAdShow:(NSString *)identifier {
    // Invoked when ad is being shown to the user
}

- (void)mediaBrixAdDidClose:(NSString *)identifier {
    [self.delegate customEventInterstitialDidDismiss:self];    // Invoked when the ad is closed
}

- (void)mediaBrixAdReward:(NSString *)identifier {
    
    // Invoked when the user has watched an ad that offers an incentive and reward should be given
}

- (void)mediaBrixAdClicked:(NSString *)identifier {
    [self.delegate customEventInterstitialWasClicked:self];
    [self.delegate customEventInterstitialWillLeaveApplication:self];
    // Invoked when the user has clicked the ad
}


-(void)handleCustomEventInvalidated{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


@end
