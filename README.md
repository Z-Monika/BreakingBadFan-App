# Code Academy 2021 - Project 1 - BreakingBadFan-App


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

![576vibtNZGvQJBSDv3THrD](https://user-images.githubusercontent.com/48261482/109027010-05a2ee00-76c9-11eb-8f32-ab29f20e9c7e.jpg)

Logged in user is  remembered between application restarts, until the user logs out.


## Home scene

![fTeWHgtXVRkraSD1HD7RSg](https://user-images.githubusercontent.com/48261482/109027212-38e57d00-76c9-11eb-8f15-438d1b9862e2.jpg)


## Episodes scene

![fTeWHgtXVRkraSD1HD7RSg-2](https://user-images.githubusercontent.com/48261482/109027352-5c102c80-76c9-11eb-90b6-3919796236cb.jpg)

The screen displays the list of episodes grouped by seasons. Upon selecting an episode, episode detail scene is presented to the user. It provides  further details about the episode and a list of characters that appeared in the selected episode. If user selects a character, he/she is taken to the character detail view, where character's famous quotes are displayed. 


## Filter Episodes scene

![geVQcBdaM6oabqYdtnWg3A](https://user-images.githubusercontent.com/48261482/109027416-70542980-76c9-11eb-8dc3-90a5e2a5f837.jpg)


User can filter episodes by multiple criteria. Notably by:

- Season
- From and to air dates
- Character appearances


## Characters scene

The screen displays the list of characters grouped alphabetically. When character is selected user is provided with further details about the character as well as character's favorite quotes. Upon selecting a character, character detail scene is presented to the user, where character's famous quotes are displayed. 

## Filter Characters scene

User can filter characters by multiple criteria. Notably by:

- Character life status (i.e. alive or deceased)
- Season fetures

## Episode details scene

![geVQcBdaM6oabqYdtnWg3A-2](https://user-images.githubusercontent.com/48261482/109027481-806c0900-76c9-11eb-993d-98028aaed1fd.jpg)

Episode detail scene provides further details about the episode to the user and a list of characters that appeared in the selected episode. Upon selecting a character, character detail scene is presented to the user, where character's famous quotes are displayed. 


## Character details scene

![geVQcBdaM6oabqYdtnWg3A-3](https://user-images.githubusercontent.com/48261482/109027530-91b51580-76c9-11eb-8fa6-a1e7e0d38125.jpg)

Character detail scene provides further details about the character to the user and a list of character's famous quotes. User can save favorite quotes.  If a quote is already included among user's favotires, a filled heart icon is displayed next to the quote. 

## Quotes Scene

The quotes scene has theee sections: 


Displays `UITableView` with 3 sections (should not show empty sections). 
- **Top 3 favorite quotes**. It displays the quote and the number of users who have liked this quote. 
- **User own quotes**. 
- **A random quote**. It loads a random quotes from the API. 


# Release
The work was submitted for revision on **2021-03-08**
