# MediaBrix Google DFP/AdMob Adapters - iOS
## Please see "Testing / Release Settings" section for new guidelines on testing and deploying your integration.

MediaBrix has created a Google DFP/AdMob adapter that allows publishers, using Google DFP/AdMob as their central ad server, to mediate the MediaBrix network as another demand source.

## Prerequisites
* MediaBrix App ID and Zone Name
* MediaBrix SDK Integration ([download/clone here](https://github.com/mediabrix/mediabrix-ios-sdk))
* Google DFP/AdMob SDK Integration
* [Google DFP](https://developers.google.com/mobile-ads-sdk/docs/dfp/android/custom-events)/[AdMob Mediation Setup](https://support.google.com/admob/answer/3083407?hl=en&ref_topic=3063091)

## Edit Custom Event
### Class Name
Enter the following for "Class Name", `MediaBrixInterstitial` when editing the the custom event.

### Mediation Parameters
When creating the custom event network for [Google DFP](https://developers.google.com/mobile-ads-sdk/docs/dfp/android/custom-events)/[AdMob Mediation Setup](https://support.google.com/admob/answer/3083407?hl=en&ref_topic=3063091) you will need to add the following to the "Parameter" feild in this format: 
```
{"zone": "provided_by_mediabrix", "appID": "provided_by_mediabrix"}
```

**Step 1:** Add the following files to your project ([which can be found here](https://github.com/mediabrix/mediabrix-ios-sdk)):
 * MediaBrix.h
 * libMediaBrix.a 

**Step 2** In "Link Binary with Libraries" press the "+" button to add libxml2.tbd

**Step 3:** Download **MediaBrixInterstitial.h** and **MediaBrixInterstitial.m** from [here](https://github.com/mediabrix/mediabrix-ios-googleads-adapter)

## Logging 
To disable logging from the MediaBrix SDK, set ```MBEnableVerboseLogging``` to ```NO``` in "MediaBrixInterstitial.m"

## Testing / Release Settings

To facilitate integrations and QA around the globe, MediaBrix has deployed an open Base URL for all of our world wide network partners to use while testing the MediaBrix SDK. This Test Base URL will eliminate the need for proxying your device to the US and ensure your app receives 100% fill during testing.

* **Test Base URL:** `https://test-mobile.mediabrix.com/v2/manifest/`

* **Production Base URL:** `https://mobile.mediabrix.com/v2/manifest/`

`https://test-mobile.mediabrix.com/v2/manifest/` should **ONLY** be used for testing purposes, as it will not deliver live campaigns to your app.

You can edit the Base URL for testing in "MediaBrixInterstitial.m":

```[MediaBrix initMediaBrixDelegate:callbackDelegate withBaseURL:@"BASE_URL" withAppID:_APP_ID];```

It is important to ensure that after testing, the Release build of your app uses the Production Base URL. **If you release your app using the Test Base URL, your app will not receive payable MediaBrix ads.**

