### Usage:

1. Include the module in your Titanium project.

2. Add this to tiapp.xml (using example app's url scheme):

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

3. Init the module and connect to twitter:

```
var OAuth = require('org.beuckman.oauth.io');

OAuth.initWithKey({publicKey:"WmKGOEutadU6jZ8agshVaz1VMiM"});

function connectTwitter() {
    OAuth.connect({provider:"twitter"});
}
```
