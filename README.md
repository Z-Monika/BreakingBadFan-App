# Code Academy 2021 - Project 1 
# BreakingBadFan-App

The main idea of the Breaking Bad Fan iOS application is to allow users to explore episodes and characters of the show. In the App, users can save and revisit their favorite quotes of the show's characters. They can also see which quotes are most liked by the other users of the application. 

The Breaking Bad Fan Application was developed following the requirements provided by CodeAcademy iOS Advanced Course. The aim was to demonstrate the skills and principles learned during the first part of the course. These, among others, include: 

- Standard UIKit Framework Elements
- Creating UI Elements using Xibs and Storyboards
- Networking
- Parsing Data with JSON
- Delegate Pattern
- Data Persistence using User Defaults and Keychain

This application uses Breaking Bad API: @ https://breakingbadapi.com.     

# Screens

## Registration/Login and Home screen

<img src="https://github.com/Z-Monika/BreakingBadFan-App/blob/main/BreakingBadFanAppScreens/Registration_Login_scene.png" height="500"> <img src="https://github.com/Z-Monika/BreakingBadFan-App/blob/main/BreakingBadFanAppScreens/Home_scene.png" height="500">

The logged in user is remembered between application restarts, until the user logs out.

## Episodes and Episode details screen

The screen displays the list of episodes grouped by seasons. Upon selecting an episode, an episode detail screen is presented to the user. It provides further details about the episode and a list of characters that appeared in the selected episode. If the user selects a character, he/she is taken to the character detail view, where the famous quotes of the character are displayed. 

<img src="https://github.com/Z-Monika/BreakingBadFan-App/blob/main/BreakingBadFanAppScreens/Episodes_scene.png" height="500"> <img src="https://github.com/Z-Monika/BreakingBadFan-App/blob/main/BreakingBadFanAppScreens/Episode_details_scene.png" height="500">

## Filter Episodes screen

A user can filter episodes by multiple criteria, such as:
- Season
- Airing dates
- Character appearances

<img src="https://github.com/Z-Monika/BreakingBadFan-App/blob/main/BreakingBadFanAppScreens/Filter_episodes_scene.png" height="500">

## Characters and Character details screens

This screen displays the list of characters grouped alphabetically. When a character is selected, the user is provided with the character detail screen. It offers further details about the character and a list of character's famous quotes. Here, a user can save their favorite quotes.  If a quote is already included among user's favorites, a filled heart icon is displayed next to the quote. 

<img src="https://github.com/Z-Monika/BreakingBadFan-App/blob/main/BreakingBadFanAppScreens/Characters_scene.png" height="500"> <img src="https://github.com/Z-Monika/BreakingBadFan-App/blob/main/BreakingBadFanAppScreens/Character_details_scene.png" height="500">

## Filter Characters screen

A user can filter characters by multiple criteria, such as:
- Character life status (i.e. alive or deceased)
- Season fetures

<img src="https://github.com/Z-Monika/BreakingBadFan-App/blob/main/BreakingBadFanAppScreens/Filter_characters_sce%20ne.png" height="500">

## Quotes Screen

The quotes screen has theee sections: 
- **Top 3 favorite quotes**. It displays thee most liked quotes and the number of users who have liked each of these quotes. 
- **User own quotes**. 
- **A random quote**. It loads a random quotes from the API. 
The user can manage their quotes, by deleting quotes from already saved ones and/or adding news ones from the Top 3 list and/or from the random quote section.

<img src="https://github.com/Z-Monika/BreakingBadFan-App/blob/main/BreakingBadFanAppScreens/Quotes_scene.png" height="500">

# Release

The work was submitted for revision on **2021-03-08**.
