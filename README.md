
# react-native-audio-kit

## Getting started

`$ npm install react-native-audio-kit --save`

### Mostly automatic installation

`$ react-native link react-native-audio-kit`

### Manual installation


#### iOS

1. In XCode, in the project navigator, right click `Libraries` ➜ `Add Files to [your project's name]`
2. Go to `node_modules` ➜ `react-native-audio-kit` and add `RNAudioKit.xcodeproj`
3. In XCode, in the project navigator, select your project. Add `libRNAudioKit.a` to your project's `Build Phases` ➜ `Link Binary With Libraries`
4. Run your project (`Cmd+R`)<

#### Android

1. Open up `android/app/src/main/java/[...]/MainActivity.java`
  - Add `import com.reactlibrary.RNAudioKitPackage;` to the imports at the top of the file
  - Add `new RNAudioKitPackage()` to the list returned by the `getPackages()` method
2. Append the following lines to `android/settings.gradle`:
  	```
  	include ':react-native-audio-kit'
  	project(':react-native-audio-kit').projectDir = new File(rootProject.projectDir, 	'../node_modules/react-native-audio-kit/android')
  	```
3. Insert the following lines inside the dependencies block in `android/app/build.gradle`:
  	```
      compile project(':react-native-audio-kit')
  	```

#### Windows
[Read it! :D](https://github.com/ReactWindows/react-native)

1. In Visual Studio add the `RNAudioKit.sln` in `node_modules/react-native-audio-kit/windows/RNAudioKit.sln` folder to their solution, reference from their app.
2. Open up your `MainPage.cs` app
  - Add `using Cl.Json.RNAudioKit;` to the usings at the top of the file
  - Add `new RNAudioKitPackage()` to the `List<IReactPackage>` returned by the `Packages` method


## Usage
```javascript
import RNAudioKit from 'react-native-audio-kit';

// TODO: What do with the module?
RNAudioKit;
```
  