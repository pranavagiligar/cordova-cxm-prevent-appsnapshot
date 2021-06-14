# cordova-plugin-screenprivacy-cxm

## Installation
`cordova plugin add cordova-plugin-app-switcher-privacy-cxm`

#### For local setup
  1. clone the repository to cordova directory 
  2. cordova plugin add ./cordova-plugin-app-switcher-privacy-cxm

## Note: in android there is no callback from system when app pushed to recently opened apps. The feature implemented is using lifecycle method of android activity (onPause and onResume) to create a work around system which is might not work in some devices [refer this for more details](https://stackoverflow.com/questions/43274289/android-customizing-recent-apps-thumbnail-screenshot-by-default#answer-49340273)

## Usage

```js
document.addEventListener("deviceready", onDeviceReady, false);
// To enable screenshot
function onDeviceReady() {
  window.plugins.appswitcher.unblock(successCallback, errorCallback);
}
// To block screenshot
function onDeviceReady() {
  window.plugins.appswitcher.block(successCallback, errorCallback);
}

// {"message": "success message"}
function successCallback(result) {
  console.log(result);
}

// {"message": "failure message"}
function errorCallback(error) {
  console.log(error);
}
```