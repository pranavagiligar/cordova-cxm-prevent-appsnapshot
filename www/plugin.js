var plugin = {
  unblock: function (successCallback, errorCallback) {
    cordova.exec(successCallback, errorCallback, 'appswitcher', 'unblock', []);
  },
  block: function (successCallback, errorCallback) {
    cordova.exec(successCallback, errorCallback, 'appswitcher', 'block', []);
  }
}

cordova.addConstructor(function () {
  if (!window.plugins) {window.plugins = {};}
  window.plugins.appswitcher = plugin;
  return window.plugins.appswitcher;
});