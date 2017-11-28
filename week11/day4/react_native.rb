Three ways to build a Mobile App:
    1.) Native Code ( Swift (IOS) / Java (Android SDK) )
    2.) HTML5 -> App contains web browser. Packaged with Cordova. 
    3.) React Native. 

Require XCode. 
React.js - Flexbox - ES6.
 
Setup Global npm install -g create-react-native-app
brew install watchman

yarn global add create-reacte-native-app

Create Local Project:
create-react-native-app timer
Download Expo App. 
Have both phone and computer on same network
cd directory
yarn start 
yarn start --ios

app.js = homepage of app. 

Stylesheet should be treated as a Javascript Object. 

Flexbox: 
    justifyContent: flex-start = top of container 
                    flex-end = end of container 
                    center = middle of container 
    alignItems: flex-start = left of container 
                flex-end = right of container
                center = center of container  
    changing flexDirection: row will change this. 

TouchableHighlight

const startDate = new Date();
new Data() - startDate()