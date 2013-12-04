// This is a test harness for your module
// You should do something interesting in this harness 
// to test out the module and to provide instructions 
// to users on how to use it by example.


// open a single window
var win = Ti.UI.createWindow({
	backgroundColor:'white'
});
var label = Ti.UI.createLabel();
win.add(label);
win.open();


var OAuth = require('org.beuckman.oauth.io');
Ti.API.info("module is => " + OAuth);

OAuth.init({publicKey:"WmKGOEutadU6jZ8agshVaz1VMiM"});

var twitterButton = Ti.UI.createButton({
    title: "Connect Twitter"
});
twitterButton.addEventListener("click", function(){
    OAuth.connect({provider:"twitter"});
});

win.add(twitterButton);
