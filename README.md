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
Outils pour un voyage à New York. 
 - conversion Euro <-> Dollar, 
 - traduction entre les langues de l'UE et l'anglais, 
 - météo locale pour New York et la destination saisie.

En cas d'erreur de saisie, d'erreur de connexion ou de réception de données erronées, une alerte informe l'utilisateur.


English version :

Tools for a trip to New York. 
 - Euro <-> Dollar conversion, 
 - translation between EU languages and English, 
 - local weather for New York and the destination to be entered

In the event of an input error, a connection error or incorrect data being received, an alert informs the user.

## Features

Premier onglet :
- L'utilisateur saisit un montant et obtient sa conversion en appuyant sur le bouton "convertir".
- Un montant en Euro peut être converti en Dollar, et vice versa.
- Le taux de conversion est actualisé une fois par jour, et enregistré dans l'appareil de l'utilisateur.
- Un bouton permet d'inverser les devises.
 

Deuxième onglet :
- Par défaut, la traduction se fait du français vers l'anglais, ou vice versa.
- Chaque bouton de langue propose une liste des langues de l'Union européenne.
- L'utilisateur sélectionne la langue d'origine et la langue de traduction.
- Un bouton permet d'obtenir la traduction du texte saisi dans la langue sélectionnée.

Troisième onglet :
- Dès l'ouverture de la page, la météo de New York s'affiche.
- L'utilisateur peut comparer avec la météo de la destination de son choix.


English version :

Fist tab :
- The user enters an amount and gets the conversion by pressing the "convert" button.
- An amount in Euro can be converted into Dollar, and vice versa.
- The conversion rate is updated once a day and stored in the user's device.
- A button allows to reverse the currencies.
 

Second tab :
- By default, the translation is from French to English, or vice versa.
- Each language button offers a list of the languages of the European Union.
- The user selects the original language and the language of the translation.
- A button provides a translation of the text entered in the selected language.

Third tab :
- As soon as the page is opened, the weather for New York is displayed.
- The user can compare with the weather of the destination of his choice.

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

Depuis votre terminal, clonez ce dépôt avec la commande git suivante :

From your terminal, clone this repository with the following git command :

```
$ git clone https://github.com/fredMilloh/TravelTools
```

Cette application utilise les API suivantes :

This application uses the following APIs :

Convert : https://fixer.io/

Translate : https://cloud.google.com/translate/docs/

Weather : https://openweathermap.org/current

Projet sans clés API. Ajoutez vos clés API.

Project without API keys. Add your API keys.

Supprimez le fichier ConfigKeys et ajoutez un nouveau "fichier de paramètres de configuration" au projet.

Delete the ConfigKeys file and add a new "configuration settings file" to the project.

Nommez-le *ConfigKeys*.

Name it *ConfigKeys*.

Définir les configurations (Debug, Release) dans le projet, avec ce fichier de configuration.

Set the configurations (Debug, Release) in the project, with this configuration file.

Ajoutez vos clés API aux clés suivantes :

Add your API values to the following keys :

CONVERT_API_KEY = 

TRANSLATE_API_KEY = 

WEATHER_API_KEY =


## License

[MIT License](https://github.com/fredMilloh/Instagrid/blob/master)

----------------------------------------------------------------------------------------

création d'une application, dans le cadre d'un projet d'étude.

application coded from scratch, as part of a study project.

