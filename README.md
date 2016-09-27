# MediaBrix Google DFP/AdMob Adapters - iOS

MediaBrix has created a Google DFP/AdMob adapter that allows publishers, using Google DFP/AdMob as their central ad server, to mediate the MediaBrix network as another demand source.

##Prerequisites
* MediaBrix App ID and Zone Name
* MediaBrix SDK Integration ([download/clone here](https://github.com/mediabrix/mediabrix-ios-sdk))
* Google DFP/AdMob SDK Integration
* [Google DFP](https://developers.google.com/mobile-ads-sdk/docs/dfp/android/custom-events)/[AdMob Mediation Setup](https://support.google.com/admob/answer/3083407?hl=en&ref_topic=3063091)

##Mediation Parameters
When creating the custom event network for [Google DFP](https://developers.google.com/mobile-ads-sdk/docs/dfp/android/custom-events)/[AdMob Mediation Setup](https://support.google.com/admob/answer/3083407?hl=en&ref_topic=3063091) you will need to add the following to the "Parameter" feild in this format: 
```
{"zone": "provided_by_mediabrix", "appID": "provided_by_mediabrix"}
```

**Step 1:** Add the following files to your project ([which can be found here](https://github.com/mediabrix/mediabrix-ios-sdk)):
 * MediaBrix.h
 * libMediaBrix.a 

**Step 2** In "Link Binary with Libraries" press the "+" button to add libxml2.tbd

**Step 3:** Download **MediaBrixInterstitial.h** and **MediaBrixInterstitial.m** from [here](https://github.com/mediabrix/mediabrix-ios-googleads-adapter)
