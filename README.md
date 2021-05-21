# Code Academy 2021 - Project 1

In this project you will be making a Breaking Bad Fan iOS application. The goal is to demonstrate the skills and principles you learned in the first part of the course. 

The main idea of Breaking Bad Fan iOS application is to allow users to explore episodes and characters of the show. Save and see favorite quotes of other users of the application. 

Details of each scene will be provided. Some are stricter and some allow for flexibility and choices. Every corner case of this application is not described and you should follow principles described in the “General” section and follow good practices that we talked about during our classes. 

Mockups of some views are provided as well. They show general ideas of views but give you flexibility to decide on fonts, colors, sizes, spacing, namings and other design characteristics. More broader requirements of design can be found in the “UI” section. 

This application uses Breaking Bad API, documentation can be found @ https://breakingbadapi.com.     
It is part of the task to understand which API endpoints to use to fulfil the requirements. 

# Scenes

## Registration/Login scene
When `UISegmentedControl` is on Login selection, two fields should be shown - username and password. 
When Register is selected, the 3rd text field appears for password confirmation. 

![576vibtNZGvQJBSDv3THrD](https://user-images.githubusercontent.com/48261482/109027010-05a2ee00-76c9-11eb-8f32-ab29f20e9c7e.jpg)

- Submit button should be disabled if any of the shown fields are empty.
- After clicking the submit button we should check if such a user exists (in login scenario).
- If the user exists and the password is correct, dismiss the login scene and open home scene.
- If a user exists and the password is incorrect, show an alert identifying the problem.
- After clicking the submit button in the registration scenario, we should check if this username is not taken already.
- If it is not taken, we should check if passwords match and if they are safe (at least 8 characters, contains uppercase & lowercase, contains both numbers and letters, at least one special character (non alpha-numerical)).
- If all checks pass, we should create a new user and open home scene. If not, we should show an alert identifying the problem.

Logged in users should be remembered between application restarts, until the user logs out.


## Home scene

![fTeWHgtXVRkraSD1HD7RSg](https://user-images.githubusercontent.com/48261482/109027212-38e57d00-76c9-11eb-8f15-438d1b9862e2.jpg)

- Should display title and username
- Show buttons to open episodes, characters, favourite quotes scenes and a button for logout. 
- Favourite quotes button should be disabled, if no quotes are saved.
- Logout button should forget the current user and return to the Login/Registration scene.

## Episodes scene

![fTeWHgtXVRkraSD1HD7RSg-2](https://user-images.githubusercontent.com/48261482/109027352-5c102c80-76c9-11eb-90b6-3919796236cb.jpg)

- When opened, fetch API for all Breaking Bad episodes. 
- Loading indicator should be shown until the API request completes.
- After loading completes, populate UITableView with all the received episodes, showing title and episode number. 
- Episodes should be grouped in table view sections by season. When the cell is pressed, the episode details scene is opened.
- On top of the screen there is a filter button, when the button is pressed, Filter Episodes popup view is opened.

## Filter Episodes popup

![geVQcBdaM6oabqYdtnWg3A](https://user-images.githubusercontent.com/48261482/109027416-70542980-76c9-11eb-8dc3-90a5e2a5f837.jpg)

- There are text fields to filter episodes by season, from air date and to air date. 
- There is a list of characters. You can select none, some or all characters. If multiple characters are selected, we will be filtering for episodes that either one or another character is selected.
- If any of the fields are empty or no characters selected, they are ignored in filtering.
- There should be “Apply” button. After clicking, filter popup is closed and the episode details scene is reloaded with an applied filter.

Suggestion: Delegate pattern could be used to notify episodes scene about applied filter.

## Characters scene
- When opened, fetch API for all Breaking Bad characters.
- Loading indicator should be shown until the API request completes.
- After loading completes, populate `UITableView` with all the received characters, showing name. When the cell is pressed, the character details scene is opened.
- On top of the scene there is a filter button, when the button is pressed, the Filter Characters pop up view is opened.

## Filter Characters Pop Up

- There is a UI element to filter episodes by status (either Deceased or Alive). Use appropriate UI elements to select between 2 values.
- There is a list of season numbers (appearance). 
- Users can select none, some or all seasons.
- If any of the fields are empty or no seasons selected, they are ignored in filtering.
- There is a “Apply” button. After clicking, filter popup is closed and the episode scene is reloaded with an applied filter.
- UI similar to Episodes Filter Pop Up.

Suggestion: Delegate pattern could be used to notify characters scene about applied filter.

## Episode details scene

![geVQcBdaM6oabqYdtnWg3A-2](https://user-images.githubusercontent.com/48261482/109027481-806c0900-76c9-11eb-993d-98028aaed1fd.jpg)

- Displays header with episode title, season, episode number, airing date at the top of the screen. 
- Below the header list of characters is displayed. 
- When the cell is pressed, the character details scene is opened.

## Character details scene

![geVQcBdaM6oabqYdtnWg3A-3](https://user-images.githubusercontent.com/48261482/109027530-91b51580-76c9-11eb-8fa6-a1e7e0d38125.jpg)

- Display header with character name and birthday. 
- When opened, should fetch API for quotes of this particular character. 
- Below the header display list of quotes. When the cell is pressed, the quote is saved as favorite for the currently logged in user. Display heart icon to visually show if a quote is saved as favorite or not (https://icons8.com can be used). If it is saved as a favorite - it should be filled with red color, if not - empty. 
- After selection, the heart icon should update.  For example https://icons8.com/icon/set/heart/ios-filled--red  and https://icons8.com/icon/set/heart/ios--black 


## Quotes Scene

Displays `UITableView` with 3 sections (should not show empty sections). 
- **Top 3 favorite quotes**. Cell should display the quote and the number of users who have favorited this quote. Should be sorted from highest count to lowest. Heart icon should be displayed in order for the current user to have an ability to save or remove it from his/hers favorites. If it is already in your favorites, a heart icon should indicate that.
- **Your quotes**. Cell should display quote. Swiping right on the cell should remove it from favorites.
- **Random quote**. It should load random quotes from the API. Heart icon should be displayed in order for the user to have an ability to save or remove it from his/hers favorites. If it is already in favorites, icons should indicate that.

# Technical Requirements

## General
- This is your time to shine by writing as clean as you can
- Do not forget about Swift style guides (either Ray Wenderlich - https://github.com/raywenderlich/swift-style-guide or Google - https://google.github.io/swift/) 
- Use proper naming, code structure and spacing
- Do not forget about access control (`private`, `internal`, `public` etc.)
- Use subclassing, where it is relevant and needed
- Try to make your code easy to understand just by looking at it, avoid massive functions
- Try to think of all possible failure scenarios, so your application would be without any surprises if something goes wrong
- Use extensions, split huge functions into smaller ones (if possible, of course)
- When you finish some part of the functionality, take a look of what you have already written and check if you can refactor something and make it look cleaner
- Handle all the errors through the application - user should know if something goes wrong
- Differentiate between structs and classes by situation (do not mix them - use `struct` where struct is best, use `class` where class is best)
- Functions with clear purpose, without unexpected side-effects
- Use “weak” when needed

## Networking
- API layer should be separated from other parts of application
- Using `URLSession`, `Encodable`/`Decodable`
- Separate data structure for building endpoint URLs
- Using `URLQueryItems` to build URLs with query parameters
- Networking methods should provide both data and errors.
- Error handling. API methods should always notify about its failures or successes.

## Storage
- Storage layer should be separated from other parts of application
- Use `UserDefaults` and `Keychain` (you can import 3rd party library for Keychain, we have been using https://github.com/evgenyneu/keychain-swift during lectures)

## UI
- Application should only support `Vertical` orientation
- Application should support all screen sizes, all required elements should fit
- Use either `Storyboards` or `Xib` files (open choice)
- Views or Constraints should be set inside interface builder
- Aim for consistent colors and consistent spacing
- All shared functionality between view controllers should be moved to parent view controller, which would be subclassed by child view controllers
- You can use https://icons8.com/ or any other icon website for images

# Evaluation
You will get **3 marks**.

1. **User side** - we will be your application users and see if we can break them. We will check if everything works as expected, there are no unhandled scenarios, there are no crashes or other things that could affect user experience
2. **Code functionality** - this is similar to user functionality testing but this time we will go into your code and check if everything is handled correctly code-wise. We will check if you used appropriate things for specific tasks, if there are no loopholes, if everything is handled correctly etc. In other words, we will check how you implement requirements code-wise.
3. **Code cleanliness** - in this part we will check is your code clean. Do you split your functions, do you use extensions, if code is structured correctly, if you use proper naming, is styling okay etc.

Bonus points from QuizApp will be divided into code functionality and user side parts. One point each

# Deadline
The work needs to be sent as an archive to Arnas via Teams private message until **2021-03-08**
