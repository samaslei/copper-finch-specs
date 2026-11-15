# Business Logic 
 
## Project Details 
 - Company/Team Name: Akadi - Project Code Name: Copper Finch - Project Short Code: CF - Short Description: An academic hub providing predictive grade tracking and integrated study workflows - Long Description: 
  Akadi is a application for organizing academic terms and subjects, calculating gradeds and GWA, tracking focus sessions and upcoming work, and reviewing academic history.
 
## User Levels 
 
> Note: Modify/rename the list of users based on the actual users that you expect to use the 
system. 
 
| User Level              | Description | 
| ----------------------- | ----------- | 
| A. Administrator / Developer | Responsible for maintaining and managing the academic hub. Their responsibilities include reviewing user-submitted bug reports and feedback, managing application releases, preparing release notes, monitoring the backend and database, and maintaining the application's security and functionality. For the MVP, administrative tasks are handled through the Supabase dashboard and version-controlled release note files rather than a dedicated administrator interface. | 
| B. Authenticated User (Student)        | Registered student who has access to all the academic hub's features, including grade tracking, predictive grade calculations, focus sessions, deadline management, exam scheduling, academic analytics, and archival. Additionally, they can manage their account and synchronize academic data with the backend, allowing them to access their records across supported sessions and devices. Their academic records also benefit from server-side validation and database protections.  |  
| C. Guest                | Unauthenticated user who can access and use the academic hub without creating an account. They can manage academic terms, subjects, grades, deadlines, exams, and quizzes; use focus sessions; track and predict grades; view academic analytics; and access release notes and developer feedback forms. Their academic data is stored locally on their device and is not synchronized with an online account. | 
 
## System Requirements 
 
1. The app shall require access to local storage to save and maintain users' academic records and application data.

2. The app shall require an internet connection to support user authentication, cloud synchronization, and online services.

3. The app shall allow users to enable notifications to receive reminders about upcoming deadlines and academic activities.

4. The app shall support background timer execution to maintain accurate focus session countdowns even when users switch applications.

5. The app shall support Picture-in-Picture (PiP) mode to allow users to view their focus timer while using other applications, where supported.

6. The app shall support modern web browsers with JavaScript and IndexedDB capabilities.

7. The app shall support Screen Wake Lock to prevent the device screen from turning off during active focus sessions, where supported.
 
## Required Solution Layers 
 
1. Security and privacy by design. Data Privacy Act compliance, location protection, retention 
limits, no per-user trails, aggregation thresholds, and consent for any data resale. 
 
## MVP Features and Access 
 
> See the User Levels table for reference. 
 
| Feature               | Access      | 
| --------------------- | ----------- | 
| 1. Dashboard and Academic Overview                    | A,B,C   | 
| 2. Grade Tracking and Predictive Grade Calculations   | B,C     | 
| 3. Focus Sessions (Pomodoro and Timer)                | B,C    | 
| 4. Deadline and Task Management                       | B,C     |
| 5. Exam and Quiz Scheduling                           | B,C     | 
| 6. Academic Term and Subject Management               | B,C     | 
| 7. Account and Administrative Management              | A,B    | 

## Notes - PWA/offline support, native apps, Web Push, component-level grading (quizzes/activities weighting), social features, AI features, calendar sync are all out of scope for MVP. 