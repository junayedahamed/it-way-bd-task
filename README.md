# api_task



 Those values are manually added that will not update there incomplete state to complete because we make a update call on api if that success then we update it locally .... Here our manually added tasks are not posted in DB so it will return status code of 500 that's why we could not update it's status
 
 ## File Stucture
```

📦lib
 ┣ 📂src
 ┃ ┣ 📂model
 ┃ ┃ ┗ 📜task_model.dart
 ┃ ┣ 📂services
 ┃ ┃ ┗ 📜api_services.dart
 ┃ ┗ 📂view
 ┃ ┃ ┣ 📂widget
 ┃ ┃ ┃ ┗ 📜add_task_dialogue.dart
 ┃ ┃ ┗ 📜home_screen.dart
 ┗ 📜main.dart
 ```

# Steps

 ```
 git clone https://github.com/junayedahamed/it-way-bd-task.git

 cd it-way-bd-task

flutter pub get
flutter run

 ```