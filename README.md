# MaxGames

This is a little mobile application developed using Swift and some frameworks, that consists in do a GET request and retrieven a list of games and show it in a TableView, as well the detail of a game. Also, there is a screen to show user data. The reason this app was built was just for education and participation in a selection process a iOS developer at Tokenlab.

### Development tools:
- Xcode 9.1
- API for downloading data

### iOS:
- 11 or higher
Copyright © 2017 Gabriel Catice. All rights reserved.


### About architecture

This projet was built following the MVP project standard, who basically consists:

#### Data modeling and services layer:
- A class to implement services who will connect with a backend / API through web requests, and then, parsing the result into a Swift JSON Object,
- The model who will be used as a form to fit the object parsed from JSON

#### Scene and flow layer:
- The **Presenter**, who has the function to intermediate an make the connection between the view and the data came from data and services layer. 
- The **View**, who will receive formatted data from the presenter and then shows it to the user on his screen. The view will receive user interactions events and will send it to presenter if needed.
- The communication between View and Presenter is wrapped in two data types. The view will request things to presenter by passing a **Request** object and Presenter will response with a **ViewModel** object.
- The Response object should wrap the parametters needed to request something and the ViewModel wraps all formatted data ready to be shown to the user. Simple code organization.
- Using the protocol orientation hype, the Presenter doesn't have known about the View that are using it (the presenter), and vice-versa. The presenter only knows some Displaying Logic Methods exposed by the **Display Logic Protocol**, otherwise the View will know only some Presentation Logic Methods, exposed by **Presentation Logic Protocol**. It can be acheieved by using protocol oriented programming. Using this paradigm the presenter will be able to handle any object as a View, since this object implements the Display Logic Protocol. Worth the analogue.
 
