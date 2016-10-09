# iOS StarterKit

## iOS StarterKit Introduction
This `iOS StarterKit` based on：

* IDE：Xcode8
* Language：Swift3
* Build tool：fastlane
* Dependency management：Carthage
* Code style check：SwiftLint
* Unit test framework: Quick + Nimble
* CI:
    - Jenkins
    - TBD: GoCD
* Beta testing platform：
    - HockeyAPP
    - TBD：蒲公英

## Admin Setup (codebase manager)

#### Apple ID
   Apply account for apple developer program

#### Testing devices
   Get all the testing device’s UUID

#### HockeyAPP Setup
   1. Register a HockeyApp account
   2. Create an app manually in HockeyApp (with your project bundle identifier)

#### Fastlane match Setup

```
Reference: `Usage` - `Setup` at `https://github.com/fastlane/fastlane/tree/master/match`
```

   1. Create a **private** repo (name it something like certificates)
   2. Write all the testing device’s UUID in the `./devices.txt` file of your projects
   3. Run ‘match init’ with the private repo URL
   4. Modify Matchfile: app_identifier, username, URL
   5. Run ‘match adhoc'
   6. Run `fastlane add_devices` every time new device is added into the file

#### Jenkins Setup

1. Install Jenkins

	```
	Download jenkins.war from https://jenkins.io/
	```

2. Start Jenkins

	```
	java -jar jenkins.war
	```

3. Install required Jenkins plugins: `Pipeline` and `Git Plugin`

	Install from jenkins console: `Manage Jenkins` -> `Manage Plugins`

4. Generate Credential

	Generate from jenkins console: `Credentials` -> `Global credentials` -> `Add Credentials`

5. Create new project

	Create from jenkins console: `New Item` -> Choose `pipeline style`

6. Configure project

	Configure from jenkins console: `Build Triggers` -> Choose Pipeline defination `Pipleline script from SCM` -> Fill the form with the created credential.


## Setup Development Environment (developer)

* Install Xcode 8
* Install rbenv
* Install Carthage

	```
	brew install carthage
	```
* Install Fastlane

	```
	gem install fastlane --verbose
	```
* Install SwiftLint

	```
	brew install swiftlint
	```

## Init Project (developer)
* Clone the iOS StartKit Repo

	```
	git clone https://github.com/iossocket/StartKit.git
	note: we will move it to a ThoughtWorks private repo later.
	```

* Install Carthage, and then run:

	```
	carthage update --platform iOS
	```

## Working flow (developer)
* Run `fastlane checkin` locally everytime before `git push`
* CI will trigger `fastlane beta` after every `git push` and deploy the successful build package to HockeyApp
* Run `fastlane add_devices` every time new device is added into the file (codebase manager)





## Other Recommendations

```
- Code Structure: MVVM (VIPPER for complex data flow)

- Local database: Realm

- Data analysis:

    - Mixpanel, Nielsen

    - 友盟（国内）

- Push notifications

    - SNS

    - 友盟 （国内）

- Login or sharing by third party library such as facebook, WeChat: Use the official SDK for each

- Testing
    - Unit Test: Cover all the view model、utils, etc.
    - Functional Testing: Cover the main business scenarios.
    - UI Automation Testing: According to the functionality of the app, and the benefit/cost of your team.

- Common libraries

    - Security scanning: danger

    - Network: Alamofire

    - JSON-Model mapper: ObjectMapper

    - Spinning: SVProgressHUD

    - Image cache: Kingfisher

    - Autolayout: SnapKit

- Other good libraries

    - Access keychain library: KeychainAccess

    - Date formatter library: iso-8601-date-formatter

    - Time formatter library: TimeAgo

    - Form library: XLForm

    - Keyboard library: IQKeyboardManager

    - Logging: XCGLogger

    - Data cache: Haneke

    - JSON parse: SwiftyJSON
```

