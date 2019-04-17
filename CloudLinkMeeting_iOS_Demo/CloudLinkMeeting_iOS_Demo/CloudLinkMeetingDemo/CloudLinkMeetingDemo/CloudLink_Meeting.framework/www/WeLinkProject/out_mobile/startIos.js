window.readyCordova = false;
var language = {};
document.addEventListener("deviceready",onDeviceReady1, false);

function onDeviceReady1(){
  window.readyCordova = true;
  var script = document.createElement("script");
  script.type = "text/javascript";
  script.src = "./WeLinkProject/out_mobile/js/main.js";
  document.getElementsByTagName("head")[0].appendChild(script);
}
window.showCallViewFullScreen = function showCallViewFullScreen(bFull, bVideo) {
  window.cordova.exec(null, null,"OCJSBridge", "showCallViewFullScreen", [bFull, bVideo]);
}
