# Good Budget

A budget monitor or expense tracker Flutter application that persists data with Hive NoSQL database. This cross platform application is available on Android, iOS & Web. Both expenses and income are tracked.

### Android App Demonstration

<a href='https://github.com/Sherida101/GoodBudget/releases/download/v1.0.0/goodBudgetDemo.apk'>Download Good Budget Android apk</a>

Star ⭐ the repository if you like what you see 😉.

## 📽📸 &ensp;Preview

|                                                  Light Theme                                                  |                                                  Dark Theme                                                   |
| :-----------------------------------------------------------------------------------------------------------: | :-----------------------------------------------------------------------------------------------------------: |
| <a href="https://www.youtube.com/watch?v=71g1mIcm2-U" target="_blank"><img src="appDemo.gif" width="350"></a> | <a href="https://www.youtube.com/watch?v=71g1mIcm2-U" target="_blank"><img src="appDemo.gif" width="350"></a> |

## Screens

|                **Light Theme - Home**                 |                 **Dark Theme - Home**                  |             **Light Theme - Add Transaction**             |             **Dark Theme - Add Transaction**              |
| :---------------------------------------------------: | :----------------------------------------------------: | :-------------------------------------------------------: | :-------------------------------------------------------: |
| <img src="screenshots/lightTheme_home_screen.png"  /> | <img src="screenshots/darkTheme_home_screen.png"    /> | <img src="screenshots/lightTheme_add_transaction.png"  /> | <img src="screenshots/darkTheme_add_transaction.png"   /> |

## Features

- [✅] Add, edit or delete an expense transaction
- [✅] Add, edit or delete an income transaction
- [✅] Save data to Hive database
- [✅] Dark theme support
- [✅] Splash screen
- [❌] Sort transactions by date and name
- [❌] Search

## Steps to Generate Hive Models
1. **Add dependencies to dev_dependencies**
    dev_dependencies:
    
        hive_generator: ^1.1.3 # <-- this line
        
        build_runner: ^2.2.1   # <-- this line

2. **Add model files that contain the part keyword with the correct file name**

    e.g. If the file that contains the hive model is named `transaction.dart`, it   
         should contain this line:

    `part 'transaction.g.dart';`

3. **In the terminal of the project directory, run build_runner to re-generate the model files**

    $ flutter pub run build_runner build --delete-conflicting-outputs

## ✨ Requirements

- Any Operating System (ie. MacOS X, Linux, Windows)
- Any IDE with Flutter SDK installed (ie. IntelliJ, Android Studio, VSCode etc)
- Knowledge of Dart, Flutter and Hive database

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://flutter.dev/docs/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://flutter.dev/docs/cookbook)

For help getting started with Flutter, view our
[online documentation](https://flutter.dev/docs), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

## ⚡&ensp;Social Media

[<img align="center" alt="Sherida Providence | YouTube" width="28px" src="https://firebasestorage.googleapis.com/v0/b/web-johannesmilke.appspot.com/o/other%2Fsocial%2Fyoutube.png?alt=media" />](https://www.youtube.com/obAZ9eizOU77HaEoLn0jHA?sub_confirmation=1)&ensp;YouTube: [@Sherida Providence](https://www.youtube.com/obAZ9eizOU77HaEoLn0jHA?sub_confirmation=1 "YouTube Sherida Providence")

[<img align="center" alt="Aaliyah Providence | Facebook" width="28px" src="https://firebasestorage.googleapis.com/v0/b/web-johannesmilke.appspot.com/o/other%2Fsocial%2Ffacebook.png?alt=media" />](https://www.facebook.com/smileysherida)&ensp;Facebook: [@Aaliyah Providence](https://www.facebook.com/smileysherida "Facebook Aaliyah Providence")

[<img align="center" alt="AaliyahProvidence | LinkedIn" width="28px" src="https://firebasestorage.googleapis.com/v0/b/web-johannesmilke.appspot.com/o/other%2Fsocial%2Flinkedin.png?alt=media" />](https://linkedin.com/in/aaliyah-providence-0355b321a/)&ensp;LinkedIn: [@Aaliyah Providence](https://linkedin.com/in/aaliyah-providence-0355b321a/ "LinkedIn Aaliyah Providence")

[<img align="center" alt="Sherida101 | GitHub" width="28px" src="https://firebasestorage.googleapis.com/v0/b/web-johannesmilke.appspot.com/o/other%2Fsocial%2Fgithub.png?alt=media" />](https://github.com/Sherida101)&ensp;GitHub: [@Sherida101](https://github.com/Sherida101 "GitHub Sherida101")

# References 👏🏻

- Concept was taken from [Johannes Milke's Hive Database project](https://github.com/JohannesMilke/hive_database_example).
