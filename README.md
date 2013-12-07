### Purpose

A Titanium module to implement the [OAuth.io iOS SDK](https://github.com/oauth-io/oauth-ios)

### Usage

- Register at [OAuth.io](https://oauth.io/signup) and create an app. Create apps on the requested service develper sites and copy the keys into your OAuth.io app with the [Key Manager](https://oauth.io/key-manager).

- Include this module in your Titanium project.

- Fill in your custom URL scheme and add this to your project's tiapp.xml (using example app url scheme):

```xml
<ios>
    <plist>
        <key>CFBundleURLTypes</key>
        <array>
            <dict>
                <key>CFBundleURLName</key>
                <string>localhost</string>
                <key>CFBundleURLSchemes</key>
                <array>
                    <string>myappname</string>
                </array>
            </dict>
        </array>
    </plist>
</ios>
```

- Init the module and connect to twitter:

```javascript
var OAuth = require('org.beuckman.oauth.io');

OAuth.initWithKey({publicKey:"WmKGOEutadU6jZ8agshVaz1VMiM"});

OAuth.addEventListener("auth", function(e){
	Ti.API.info(e);
	var tokens = Ti.App.Properties.getObject("oauthio", {});
	tokens[e.provider] = {
		oauth_token: e.oauth_token,
		oauth_token_secret: e.oauth_token_secret
	};
	Ti.App.Properties.setObject("oauthio", tokens);
});


function connectTwitter() {
    OAuth.connect({provider:"twitter"});
}
```
