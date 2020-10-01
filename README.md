# UVA Accessibility
This app will serve as a resource to persons on grounds in need of accessibility accomodations. It will have functionalities to show their location on accessible pathways on Grounds, connect them to SDAC resources, and allow them to report any barrier to access.

## Photo Documentation

### SDAC Resources Screens
<img src="/ResourcePage1.png" width="200"> <img src="/ResourcePage2.png" width="200"> <img src="/ResourcePage3.png" width="200">
The SDAC resource were stored and pulled from a Firebase database that allows for resources added to be updated in the app in real time. Upon choosing a category the subcategories are presented in a new screen embedded in the navigation controller, where the user can click on their desired resource and be routed to the proper website.

### Accessible GPS Screen
<img src="/Navigation.png" width="200">
On the GPS screen the user can see their current location in relation to the accessibility maps that were overlayed on to the Google Maps platform. If this product were to be picked up for further development and deployment, I would suggest research into how to enable walking directions specific to the accesible pathways displayed on these maps.

### Report Barrier to Access Screen
<img src="/Report.png" width="200"> <img src="/Report2.png" width="200"> <img src="/Report3.png" width="200">
The Barrier Reporting screen allows the user to choose their UVA Affilation and barrier type from segmented control buttons, fill in their description, location, and contact info with text fields, and upload or take a photo of the barrier (which will then appear on the screen to show users upload was successful). An alertcontroller was used to verify proper data entry, not allowing a user to submit their form without filling in all the fields fully and properly (though photo was left optional). When the form is successfully submitted it will draft and send an email to facility management with the information provided by the user. Additionally, the user's UVA affiliation and email are stored in a key-value pair and then auto-filled for each additional report, under the assumption that most iPhones have one sole user.
