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

### Scene and flow layer:
- The presenter, who has the function to intermediate an make the connection between the view and the data came from data and services layer. The presenter also provides protocols to hide and show methods of which the view will be able to see and implement its extension. Still, it has the function to parse data came from model to a model view, who will fit perfectly the logic shown in the view 
- The view, who will receive data from the presenter and then shows it to the user on his screen. The view also extends a protocol from presenter to be able to make request and then continue the flow
 
