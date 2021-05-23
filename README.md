# Code Academy 2021 - Project 1 
# BreakingBadFan-App

The main idea of Breaking Bad Fan iOS application is to allow users to explore episodes and characters of the show. In the App users can save and revisit their favorite quotes as well as those of other users of the application. 

The Breaking Bad Fan Application was developed following the requirements provided by CodeAcademy iOS advanced course. The aim was to demonstrate the skills and principles learned during the first part of the course. These, among others, include: 

Standard UIKit Framework Elements
Creating UI Elements using Xibs and Storyboards
Networking
Parsing Data with JSON
Delegate Pattern
Data Persistence using User Defaults and Keychain

This application uses Breaking Bad API: @ https://breakingbadapi.com.     

# Scenes

## Registration/Login scene
Logged in user is  remembered between application restarts, until the user logs out.

<img src="https://github.com/Z-Monika/BreakingBadFan-App/blob/main/BreakingBadFanAppScreens/Registration_Login_scene.png" height="500"> <img src="https://github.com/Z-Monika/BreakingBadFan-App/blob/main/BreakingBadFanAppScreens/Home_scene.png" height="500">

## Home scene

<img src="https://github.com/Z-Monika/BreakingBadFan-App/blob/main/BreakingBadFanAppScreens/Home_scene.png" height="500">

## Episodes scene

The screen displays the list of episodes grouped by seasons. Upon selecting an episode, episode detail scene is presented to the user. It provides  further details about the episode and a list of characters that appeared in the selected episode. If user selects a character, he/she is taken to the character detail view, where character's famous quotes are displayed. 

<img src="https://github.com/Z-Monika/BreakingBadFan-App/blob/main/BreakingBadFanAppScreens/Episodes_scene.png" height="500">

## Filter Episodes scene

User can filter episodes by multiple criteria. Notably by:

- Season
- From and to air dates
- Character appearances

<img src="https://github.com/Z-Monika/BreakingBadFan-App/blob/main/BreakingBadFanAppScreens/Filter_episodes_scene.png" height="500">

## Characters scene

The screen displays the list of characters grouped alphabetically. When character is selected user is provided with further details about the character as well as character's favorite quotes. Upon selecting a character, character detail scene is presented to the user, where character's famous quotes are displayed. 

<img src="https://github.com/Z-Monika/BreakingBadFan-App/blob/main/BreakingBadFanAppScreens/Characters_scene.png" height="500">

## Filter Characters scene

User can filter characters by multiple criteria. Notably by:

- Character life status (i.e. alive or deceased)
- Season fetures

<img src="https://github.com/Z-Monika/BreakingBadFan-App/blob/main/BreakingBadFanAppScreens/Filter_characters_sce%20ne.png" height="500">

## Episode details scene

Episode detail scene provides further details about the episode to the user and a list of characters that appeared in the selected episode. Upon selecting a character, character detail scene is presented to the user, where character's famous quotes are displayed. 

<img src="https://github.com/Z-Monika/BreakingBadFan-App/blob/main/BreakingBadFanAppScreens/Episode_details_scene.png" height="500">

## Character details scene

Character detail scene provides further details about the character to the user and a list of character's famous quotes. User can save favorite quotes.  If a quote is already included among user's favotires, a filled heart icon is displayed next to the quote. 

<img src="https://github.com/Z-Monika/BreakingBadFan-App/blob/main/BreakingBadFanAppScreens/Character_details_scene.png" height="500">

## Quotes Scene

The quotes scene has theee sections: 

Displays `UITableView` with 3 sections (should not show empty sections). 
- **Top 3 favorite quotes**. It displays the quote and the number of users who have liked this quote. 
- **User own quotes**. 
- **A random quote**. It loads a random quotes from the API. 

<img src="https://github.com/Z-Monika/BreakingBadFan-App/blob/main/BreakingBadFanAppScreens/Quotes_scene.png" height="500">

# Release

The work was submitted for revision on **2021-03-08**
