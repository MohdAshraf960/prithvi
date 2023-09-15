# Carbon Footprint Tracker Mobile App Software Document

## Table of Contents
1. **Introduction**
   1.1 Purpose
   1.2 Scope
   1.3 Document Conventions
   1.4 Intended Audience
   1.5 References

2. **Login Page**
   - 2.1 Description
   - 2.2 Functionality
   - 2.3 User Interface
   - 2.4 Authentication and Security

3. **SignUp Page**
   - 3.1 Description
   - 3.2 Functionality
   - 3.3 User Interface
   - 3.4 User Registration

4. **Dashboard**
   - 4.1 Description
   - 4.2 Functionality
   - 4.3 User Interface
   - 4.4 Navigation

5. **Home Page**
   - 5.1 Description
   - 5.2 Functionality
   - 5.3 User Interface
   - 5.4 Displaying Carbon Footprint Data

6. **Category Page**
   - 6.1 Description
   - 6.2 Functionality
   - 6.3 User Interface
   - 6.4 Viewing Categories and Questions

7. **Question Page**
   - 7.1 Description
   - 7.2 Functionality
   - 7.3 User Interface
   - 7.4 Answering Survey Questions

8. **Calculation Page**
   - 8.1 Description
   - 8.2 Functionality
   - 8.3 Calculating Carbon Footprint
   - 8.4 Displaying Results

9. **Ways to Improve Page**
   - 9.1 Description
   - 9.2 Functionality
   - 9.3 User Interface
   - 9.4 Earning Points

10. **Profile Page**
    - 10.1 Description
    - 10.2 Functionality
    - 10.3 User Interface
    - 10.4 User Profile and Survey History

## 1. Introduction

### 1.1 Purpose
The purpose of this document is to outline the software requirements and functionality of the Carbon Footprint Tracker mobile app.

### 1.2 Scope
The Carbon Footprint Tracker app aims to help users monitor and reduce their carbon footprint. It includes features such as user registration, a dashboard, survey categories, survey questions, carbon footprint calculations, point earning, and user profiles.

### 1.3 Document Conventions
- UI: User Interface
- UX: User Experience

### 1.4 Intended Audience
This document is intended for developers, designers, and project stakeholders involved in the development of the Carbon Footprint Tracker mobile app.

### 1.5 References
List any relevant documents, standards, or external resources used in the development of this app.

## 2. Login Page

### 2.1 Description
The Login Page provides access to registered users by authenticating their credentials.

### 2.2 Functionality
- Users can enter their username and password to log in.
- Password reset and account recovery options should be available.
- Secure authentication methods should be implemented.

### 2.3 User Interface
- Username and password input fields.
- "Forgot Password?" option.
- "Sign Up" link for new users.

### 2.4 Authentication and Security
Implement strong encryption and security measures to protect user data.

## 3. SignUp Page

### 3.1 Description
The SignUp Page allows new users to register for the app.

### 3.2 Functionality
- Users can provide required information, including username, password, and email.
- Verification of email addresses should be implemented.

### 3.3 User Interface
- Registration form with fields for username, password, email, and any other necessary details.
- "Already have an account?" link to navigate to the Login Page.

### 3.4 User Registration
Upon successful registration, store user information securely and provide access to the app's features.

## 4. Dashboard

### 4.1 Description
The Dashboard is the main screen users see after logging in, providing access to various app functionalities.

### 4.2 Functionality
- Display user data such as points earned, recent survey summaries, and quick links to other app sections.
- Implement navigation to Home Page, Category Page, and Profile Page.

### 4.3 User Interface
- Summary of user data and achievements.
- Navigation buttons to access different app sections.

### 4.4 Navigation
Users can navigate to Home Page, Category Page, and Profile Page from the Dashboard.

## 5. Home Page

### 5.1 Description
The Home Page displays a graph of carbon footprint data and lists recent survey summaries.

### 5.2 Functionality
- Retrieve and display user-specific carbon footprint data.
- Show a graph illustrating carbon footprint changes over time.
- List recent survey summaries with links to view more details.

### 5.3 User Interface
- Graphical representation of carbon footprint data.
- List of recent survey summaries.

### 5.4 Displaying Carbon Footprint Data
Fetch and display carbon footprint data from the user's account.

## 6. Category Page

### 6.1 Description
The Category Page lists survey categories, and users can select a category to answer related questions.

### 6.2 Functionality
- Display a list of survey categories.
- Allow users to select a category to view related questions.

### 6.3 User Interface
- List of survey categories.
- Category selection options.

### 6.4 Viewing Categories and Questions
Users can explore categories and select a category to answer associated survey questions.
## 7. Question Page

### 7.1 Description
The Question Page presents survey questions related to the selected category for users to answer.

### 7.2 Functionality
- Display survey questions based on the selected category.
- Allow users to answer questions.
- Provide navigation options to move between questions.

### 7.3 User Interface
- List of survey questions.
- Input fields or options for answering questions.
- Navigation controls to move between questions.

### 7.4 Answering Survey Questions
Users can answer survey questions, and the app should save their responses for later calculations.

## 8. Calculation Page

### 8.1 Description
The Calculation Page processes user survey responses and calculates their carbon footprint based on the selected category.

### 8.2 Functionality
- Compute carbon footprint based on survey responses.
- Display results and provide recommendations for reducing carbon footprint.

### 8.3 Calculating Carbon Footprint
Utilize the survey data to calculate the user's carbon footprint, considering the selected category and their responses.

### 8.4 Displaying Results
Show the user's calculated carbon footprint and offer suggestions for reducing it.

## 9. Ways to Improve Page

### 9.1 Description
The Ways to Improve Page provides users with actionable recommendations to reduce their carbon footprint.

### 9.2 Functionality
- Display a list of improvement actions.
- Allow users to select actions to earn points.
- Update the user's point total.

### 9.3 User Interface
- List of improvement actions with point values.
- User selection and points earned display.

### 9.4 Earning Points
Users can choose actions to improve their carbon footprint, and the app should reward them with points.

## 10. Profile Page

### 10.1 Description
The Profile Page contains user profile information and a history of completed surveys.

### 10.2 Functionality
- Display user profile details.
- List the history of surveys with links to view details.

### 10.3 User Interface
- User profile information.
- List of completed surveys with access links.

### 10.4 User Profile and Survey History
Users can view and update their profiles, as well as review their survey history.

