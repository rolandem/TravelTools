# Le Baluchon

## Table of Contents

-   [Introduction](https://github.com/fredMilloh/TravelTools#introduction)
-   [Features](https://github.com/fredMilloh/TravelTools#features)
-   [Screenshots](https://github.com/fredMilloh/TravelTools#screenshots)
-   [IDE](https://github.com/fredMilloh/TravelTools#ide)
-   [Skills](https://github.com/fredMilloh/TravelTools#skills)
-   [How to use](https://github.com/fredMilloh/TravelTools#how-to-use)
-   [License](https://github.com/fredMilloh/TravelTools#license)


## Introduction
Tools for a trip to New York. 
 - Euro <-> Dollar conversion, 
 - translation between EU languages and English, 
 - local weather for New York and the destination to be entered

In the event of an input error, a connection error or incorrect data being received, an alert informs the user.

## Features

Fist tab :
- The user enters an amount and gets the conversion by pressing the "convert" button.
- An amount in Euro can be converted into Dollar, and vice versa.
- The conversion rate is updated once a day, and kept in the UserDefaults.
- A button allows to reverse the currencies.
 

Second tab :
- By default, the translation is from French to English, or vice versa.
- Each language button offers a list of the languages of the European Union.
- The user selects the original language and the language of the translation.
- The translate button provides a translation of the text entered in the selected language.

Third tab :
- As soon as the page is opened, the weather for New York is displayed.
- The user can compare the weather of the destination of his choice.

## Screenshots

<img width="200" alt="EcranConvert" src="https://user-images.githubusercontent.com/47221695/151048925-42ef2308-cd96-45d8-8da0-9327c67bfeec.png"><img width="200" alt="EcranConvertErreur" src="https://user-images.githubusercontent.com/47221695/151048943-1675fd7b-a880-45e5-8c3e-d47afee5d032.png">
<img width="200" alt="Translate2" src="https://user-images.githubusercontent.com/47221695/151049256-2c1f95ed-6f6c-4a84-949c-e481f34320a3.png"><img width="200" alt="Translate3" src="https://user-images.githubusercontent.com/47221695/151049301-6f1efa36-f6b5-470b-b237-30f264c987d9.png"><img width="205" alt="Translate5" src="https://user-images.githubusercontent.com/47221695/151050521-1591dc6b-af46-4837-a49e-cb9c5fcff11e.png"><img width="200" alt="Translate6" src="https://user-images.githubusercontent.com/47221695/151050806-bf4d28a4-14ba-4e38-bd7a-e78c20420584.png">
<img width="205" alt="Capture d’écran 2022-01-25 à 21 05 35" src="https://user-images.githubusercontent.com/47221695/151051257-1761fbd8-e79f-47e6-91f7-5aef839f11e6.png"><img width="200" alt="EcranMeteoErreur404" src="https://user-images.githubusercontent.com/47221695/151051288-9f349259-3a8b-46dd-854e-8f7ad4e61bc1.png">

## IDE

-   Swift 5
-   iOS deployment target 11
-   Xcode 13.2

## Skills
-   Singleton Pattern
-   Delegate Pattern
-   URLSession
-   URLComponents
-   URLProtocol
-   DataMocks
-   UserDefaults
-   UIAlertController
-   UITabBarController
-   UITableView
-   Storyboard Reference
-   AVKit/AVPlayer
-   Unit test XCTestCase, and UITests
-   Code coverage

## How To Use

From your terminal, clone this repository with the following git command :

```
$ git clone https://github.com/fredMilloh/TravelTools
```

This application uses the following APIs :

Convert : https://fixer.io/

Translate : https://cloud.google.com/translate/docs/

Weather : https://openweathermap.org/current

Project without API keys. Add your API keys.

Delete the ConfigKeys file and add a new "configuration settings file" to the project.

Name it *ConfigKeys*.

Set the configurations (Debug, Release) in the project, with this configuration file.

Add your API values to the following keys :

CONVERT_API_KEY = 

TRANSLATE_API_KEY = 

WEATHER_API_KEY =


## License

[MIT License](https://github.com/fredMilloh/Instagrid/blob/master)

----------------------------------------------------------------------------------------

application coded from scratch, as part of a study project.

