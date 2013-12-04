### Usage:

- Register at [OAuth.io](https://oauth.io/signup) and create an app. Create apps on the requested service develper sites and copy the keys into your OAuth.io app with the Key Manager.

- Include the module in your Titanium project.

- Add this to tiapp.xml (using example app's url scheme):

```
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

```
var OAuth = require('org.beuckman.oauth.io');

OAuth.initWithKey({publicKey:"WmKGOEutadU6jZ8agshVaz1VMiM"});

function connectTwitter() {
    OAuth.connect({provider:"twitter"});
}
```
