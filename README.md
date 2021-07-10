# lets_talk_money

## Getting Started
This project was developed for android and ios using flutter and firebase. It is a simple chat applicatin that allows users to be anonymously logged in when the application first starts, but then later change their profile info.

### Resources used in guiding the development of this project:
- [FlutterFire Overview](https://firebase.flutter.dev/docs/overview/)
- [A Chat Application — Flutter & Firebase](https://medium.com/flutter-community/a-chat-application-flutter-firebase-1d2e87ace78f)
- [Building Chat App in Flutter with Firebase](https://medium.com/flutter-community/building-chat-app-in-flutter-with-firebase-888b6222fe20)
- [Flutter App Testing Codelab](https://codelabs.developers.google.com/codelabs/flutter-app-testing?hl=en#0)
- [Admob Ads in Flutter Codelab](https://codelabs.developers.google.com/codelabs/admob-ads-in-flutter?hl=en#0)


## Running Integration Test
Run the Command:

    flutter drive --driver integration_test/integration_test.dart --target integration_test/app_test.dart

## Admob Ads
Ads won't run until account gets approved which could take either 24 hrs or 2 weeks. 

- Banner app shows up on the home page
- Interstitial ad shows up in profile settings
- Reward ad shows up when user sends a message

## Dependencies and Plugins
### Google and Firebase:
Make sure google-services.json file is downloaded and added to android/app folder
Inside 'build.gradle' file under the 'android/app' folder, add these implementations in the 'dependencies' section:

    implementation "org.jetbrains.kotlin:kotlin-stdlib-jdk7:$kotlin_version"
    implementation platform('com.google.firebase:firebase-bom:28.2.0')
    implementation 'com.google.android.gms:play-services-auth:19.0.0'
    implementation 'com.google.firebase:firebase-auth'
    implementation 'com.google.android.gms:play-services-ads:20.2.0' 
    
Inside the 'build.gradle' file under the 'android' folder, add these to the 'dependencies' section:

    classpath 'com.android.tools.build:gradle:4.1.2'
    classpath "org.jetbrains.kotlin:kotlin-gradle-plugin:$kotlin_version"
    classpath 'com.google.gms:google-services:4.3.8'
    
 ## Demo Video 
 Demo videos will be uploaded once account is approved.
 
https://user-images.githubusercontent.com/77403985/125169638-21d79100-e179-11eb-9a09-ec841791fca9.mp4

<img width="1433" alt="Screen Shot 2021-07-10 at 10 23 09 AM" src="https://user-images.githubusercontent.com/77403985/125169669-43387d00-e179-11eb-9134-c9c3a1ce772f.png">
<img width="1155" alt="Screen Shot 2021-07-10 at 12 26 30 PM" src="https://user-images.githubusercontent.com/77403985/125169877-37998600-e17a-11eb-9b9e-719abb0eca56.png">

https://user-images.githubusercontent.com/77403985/125169959-952dd280-e17a-11eb-8c92-f983634f0c54.mp4

<img width="1433" alt="Integration Test (Android)" src="https://user-images.githubusercontent.com/77403985/125169979-aecf1a00-e17a-11eb-8d4b-0895a57ebc59.png">



 
