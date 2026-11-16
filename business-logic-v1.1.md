# Business Logic v1.1

## Project Details

- **Company/team:** Akadi
- **Project code name:** Copper Finch
- **Project short code:** CF
- **Product name:** Akadi: Student Hub
- **Short description:** A student-first academic hub for Philippine university grading, deadlines, exams, and focused study.
- **Long description:** Akadi helps university students keep academic work in one place and make sense of grades on the 1.00–5.00 scale. Students can organize terms and subjects, record midterm and final grades, understand semester and cumulative GWA, and see what final grade they need to pass or reach a target. Deadlines, exams, and a Pomodoro timer and stopwatch complete the everyday workflow. Guests can use the app on-device; an account enables backup and supported cross-device sync.

## Product Positioning

### Target users

Primary users are university students in the Philippines who track their own grades and academic work, especially students whose schools use a 1.00–5.00 scale, units, INC, and DRP.

### Student problem

Most students calculate standing by hand and scatter deadlines and exam dates across portals, chats, and notes. Generic percentage or GPA tools may not reflect the local scale, subject units, incomplete grades, or dropped subjects. Students need a quick, understandable answer to “where do I stand?” and “what do I need next?”

### Value proposition and differentiation

Akadi combines a locally relevant grade and GWA calculator with the practical tools students use every week. Its distinguishing value is transparent planning on the Philippine grading scale—including weighted midterm/final grades, units, incomplete(INC), and dropped(DRP)— Calculated results are estimates and may differ from a school’s official records. Deadlines stay actionable as a checklist, exams are presented as events, and Pomodoro timer or stopwatch sessions associated with a subject.

### Product principles

1. Useful before signup; account creation is for cloud services, not a gate to core use.
2. Show grading inputs, weights, scale, exclusions, and assumptions alongside calculated results.
3. Student records are private and under student control.
4. Keep the main actions fast: review standing, add work, and start a Pomodoro timer or stopwatch session.
5. Akadi is a planning tool for students. The grades and academic standing issued by the student’s university are the official results.

### MVP promise and limits

A student can set up a term, enter supported grades, understand current standing and GWA, plan a target where inputs allow, and keep upcoming academic work visible. Akadi does not import grades from school systems, guarantee outcomes, or replace an official transcript.

## MVP Outcomes and Scope

MVP is complete when a student can:

1. Create and manage terms and subjects, including subject units and the supported grading setup.
2. Record or revise grades and see subject standing, term GWA, and cumulative GWA when calculable.
3. See a required final-term grade to pass or reach a chosen supported target, or a clear “not reachable” result, when inputs are sufficient.
4. Add, edit, complete, and delete deadlines/tasks, exams, and quizzes; distinguish actionable work from date-based events.
5. Use a Pomodoro timer with configurable work and break intervals or a stopwatch for open-ended study time. Start, pause, resume, and end sessions, and tag them to a subject. Keep timer values accurate when returning to the app.
6. View an overview of the selected/current term, grade status, GWA, and nearest upcoming work.
7. Use locally stored guest data or sign in for supported backup and synchronization, with clear recovery and data-control paths.

The MVP is an organizer and calculator, not a school system of record or a guaranteed forecast.

## User Levels

| User level | Description and permissions |
| --- | --- |
| Administrator / Developer | Maintains the service, handles releases and operational support through existing hosting/Supabase tools. Access to student records is limited to operational need; no admin console is required. |
| Authenticated Student | Uses student features, manages account settings, and synchronizes supported records. Can delete their account and associated data. |
| Guest Student | Uses core features with data stored on the user's device/browser. Data is not synced and may be lost if local storage is cleared. Can choose to create an account for backup and synchronization. |

No teacher, parent, or university role is included.

## Core Workflows

### 1. Start a term

Create a term, set dates, choose the supported grading setup, and add subjects and units. A useful empty state directs the student to add a subject or upcoming work.

### 2. Understand and plan grades

Enter midterm and final-term grades and their weights as defined by the selected setup. The app shows the calculation basis and rounded result. The target calculator shows the final-term grade required to pass or meet a selected target, or indicates when the target is unreachable. Missing inputs produce a clear request for the missing information rather than an invented assumption.

For the initial Philippine university setup, the app supports grades from 1.00 through 3.00 and 5.00, subject units, weighted midterm/final results, and documented GWA rules. INC remains pending and DRP is excluded from GWA. An INC may be resolved to its actual grade. Any INC lapse or term archival behavior must be defined before release; the app does not silently convert an INC or alter historical results.

### 3. Keep work visible

Create tasks, deadlines, exams, and quizzes with a title, date/time, optional subject, and status. Tasks and deadlines can be completed; exams are upcoming events and cannot be marked complete before they occur. The app shows upcoming items in date order and allows editing or deletion.

### 4. Pomodoro timer and stopwatch

Start, pause, resume, and end a Pomodoro timer or stopwatch session, with the option to tag it to a subject. Timer values remain accurate when the user returns to the app. Notifications, PiP, and Wake Lock are optional.

### 5. Review and maintain records

The dashboard shows the selected/current term, subject standing, GWA when available, incomplete status, and nearest upcoming work. It includes empty, no-active-term, and incomplete-data states. Students can correct entries; any archival rule will preserve history while allowing documented INC resolution.

### 6. Account and data controls

Explain guest data storage before use and account sync before signup. Provide account deletion in-app and through a public web page if required by the distribution platform.

## MVP Features and Access

| Feature | Guest | Authenticated student | Admin |
| --- |:---:|:---:|:---:|
| Dashboard and academic overview | Yes | Yes | Operational only |
| Terms, subjects, grades, GWA, target planner | Yes | Yes | No |
| Tasks, deadlines, exams, and quizzes | Yes | Yes | No |
| Pomodoro timer and stopwatch with subject tag | Yes | Yes | No |
| Account, backup/sync, and deletion | No | Yes | Operational controls only |
| Feedback and bug reporting | Yes | Yes | Review via existing tools |
| Public help, privacy information, and release notes | Yes | Yes | Maintained by team |

Core student workflows work without authentication on the current device. Sync requires an account and connectivity. The initial product is free; no ads or monetization are part of MVP.

## Business Rules

1. Terms, subjects, and records belong to one student; server records are isolated by account.
2. Grade calculations follow a documented, selected grading setup. The initial setup is the Philippine 1.00–5.00 scale with midterm/final weights and subject units; do not imply it matches every university.
3. GWA uses the configured grade-to-point rules and subject units. DRP is excluded; pending INC is excluded until resolved. The app shows which subjects are included and why.
4. Target calculations use current grade, target, and remaining weight only when all required values exist. Show the formula and assumptions, and label the answer as a planning estimate. 
5. Store enough precision for consistent calculations; document rounding and use the same examples as acceptance cases across client/server implementations.
6. INC remains pending until resolved. If the team implements lapse-to-5.00 behavior or archive locking, define its trigger, student notice, and correction path explicitly before release. DRP is excluded from GWA and must not be treated as a completed grade.
7. Tasks and deadlines can be completed; exams are events and cannot be marked complete before their scheduled time. Date-only entries remain date-only; timed entries display in the user’s local time zone.
8. Edit, completion, deletion, and archive actions update all affected summaries consistently. Recoverable sync failures never silently discard local changes.

## System Requirements

1. The app shall store guest academic records on the user's device.

2. The app shall allow core guest features to work without an internet connection.

3. The app shall require an internet connection for account access and data synchronization.

4. The app shall ensure that signed-in students can access only their own academic records.

5. The app shall allow students to delete their accounts and associated data.

6. The app shall keep Pomodoro countdowns and stopwatch elapsed time accurate when users return to the app.

7. The app shall provide a keyboard-accessible interface with readable content, clear labels, and form error messages.

8. The app shall provide basic privacy information, grading guidance, and a feedback contact.

## Privacy and Trust

- Collect only account, academic, and operational data necessary for described features.
- Keep guest data local unless the student chooses an account/sync flow.
- Explain what account sync stores and how account deletion works before registration.
- Do not sell identifiable academic records or use them for advertising. Any future secondary use requires separate review and appropriate notice/consent.
- Publish privacy and terms pages before registration/public release. Review applicable privacy law, including the Philippine Data Privacy Act where relevant, with qualified guidance before launch.

## MVP Success Measures

Use privacy-conscious usage measures to learn whether the core promise works:

1. **Activation:** new users who create a term and add a subject.
2. **Grade value:** activated users who record grades and view a calculated standing/GWA.
3. **Planning value:** users who use the target-grade calculator and can understand the result, including the required grade, calculation basis, or why the target is unreachable.
4. **Academic work tracking:** users who add or complete a task or add an exam.
5. **Reliability and trust:** calculation discrepancies, data-loss reports, sync failures, and recurring user feedback.

Set numerical targets after a small pilot. Use overall usage statistics to evaluate the app; do not use students' grades or academic records for this purpose.

## Out of Scope for MVP

Automatic school/LMS import, social or collaborative features, AI recommendations, ads, calendar integration, component-level gradebooks, administrative features for universities and teachers, advanced analytics, and a dedicated admin console. Browser notifications, PiP, Wake Lock, and advanced focus history are also optional.

## Release Readiness

Before release, confirm that:

- The target launch platform(s), guest/account behavior, and supported grading setup are stated consistently in the product and store/landing copy.
- A guest can complete the core workflows and understands local data limitations.
- Grade, GWA, INC/DRP, rounding, and target calculations have agreed rules, reviewed worked examples, and shared acceptance cases.
- Authenticated users can access only their records and can delete their account and associated data; sync conflict and failure recovery are clear.
- Deadline and exam states are distinct; dashboard empty, populated, and incomplete states are usable.
- Privacy information, terms, help/feedback route, and required public account deletion path are available.
- Core flows have been exercised on the intended launch devices/browsers, with no known data-loss or calculation issue.
















