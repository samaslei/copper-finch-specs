# Business Logic v1.1 (Proposed)

## Project Details

- **Company/team:** Akadi
- **Project code name:** Copper Finch
- **Project short code:** CF
- **Product name:** Akadi
- **Short description:** A practical academic hub that helps students understand their current grades, see what grades they need, and keep study work on track.
- **Long description:** Akadi brings term and subject organization, grade and GWA tracking, target-grade planning, deadlines, exams, and focus sessions into one student-owned workspace. It turns scattered academic information into a clear view of current standing and next actions. Students can start locally as guests and create an account when they want cloud backup and synchronization.

## Product Positioning

### Target users

Students who want a simple, private way to organize their subjects and deadlines and understand how their grades are progressing, without setting up a complex learning-management system.

### Student problem

Grades, due dates, and study plans are often spread across portals, notes, and calendars. Students have difficulty seeing their overall standing, understanding the effect of remaining grades, and knowing what to work on next.

### Value proposition

Akadi combines academic organization with transparent grade calculations: keep the term organized, know where grades stand, and plan around upcoming work in one place.

### Product principles

1. **Useful immediately:** core features work without requiring an account.
2. **Calculations are explainable:** show the inputs, grading scale, and formula used; do not imply predictions are guaranteed outcomes.
3. **Student-owned records:** collect only what is needed to provide the service and make account sync optional.
4. **Fast to use:** prioritize a clear overview and short paths to adding grades and work.

## MVP Outcomes and Scope

The MVP is complete when a student can:

1. Create a term and its subjects, then record grades using the supported grading setup.
2. See subject standing and term GWA, and calculate the grade needed on remaining work to reach a chosen target when sufficient inputs are available.
3. Add and update tasks, deadlines, exams, and quizzes, then see what is upcoming.
4. Run a focus timer while using the app, with elapsed/countdown time remaining coherent when the browser tab is backgrounded where supported.
5. Return to the dashboard and understand current academic standing and the next due work.
6. Use guest data locally, or sign in to synchronize supported academic records across sessions/devices.

The MVP is an organizer and calculator, not a school system of record, an automatic grade importer, or a guarantee of future academic performance.

## User Levels

| User level | Description and permissions |
| --- | --- |
| Administrator / Developer | Maintains the service, reviews feedback and bug reports, manages releases, and monitors backend health. For MVP, these tasks use the Supabase dashboard and version-controlled release notes; no admin console is required. Access to user data is limited to operational need. |
| Authenticated Student | Uses student features, manages account settings, and may sync supported records to their account. Can export or delete their account data. |
| Guest Student | Uses core student features with data stored locally on the current browser/device. Guest data is not synced and may be lost if local browser storage is cleared. Can choose to create an account. |

There is no separate teacher, parent, or institution role in the MVP.

## Core Workflows

### 1. Set up an academic workspace

Create a term, enter its dates and grading scale, and add subjects. The app provides a useful empty state prompting the student to add a subject or upcoming work.

### 2. Track and plan grades

Enter or revise grade records for a subject. The app displays the current calculated result and GWA using the selected scale and documented rules. Where the student provides the necessary remaining-grade inputs and target, the app calculates the required result. Missing or incomplete inputs are identified; the app does not invent weights or grades.

### 3. Keep upcoming work visible

Add a task, deadline, exam, or quiz with a title, subject (optional where appropriate), due date/time, and completion state. The dashboard presents upcoming items in due-date order and allows marking work complete or editing/deleting it.

### 4. Focus on a study session

Start, pause, resume, and end a focus timer. The timer remains coherent when switching tabs where browser capabilities allow. Session history or advanced productivity analytics are not required for MVP.

### 5. Return and review

The dashboard summarizes the selected/current term, subject grade status, GWA where calculable, and nearest upcoming work. Empty, incomplete, and no-active-term states are handled clearly.

## MVP Features and Access

| Feature | Guest | Authenticated student | Admin |
| --- |:---:|:---:|:---:|
| Dashboard and academic overview | Yes | Yes | Operational access only |
| Academic terms and subjects | Yes | Yes | No |
| Grade tracking, GWA, and target-grade calculation | Yes | Yes | No |
| Tasks, deadlines, exams, and quizzes | Yes | Yes | No |
| Focus timer | Yes | Yes | No |
| Account, sync, and data controls | No | Yes | Operational controls only |
| Feedback and bug reporting | Yes | Yes | Review through existing operational tools |
| Release notes | Yes | Yes | Maintained in version-controlled files |

All student features work without authentication using local storage. Sync requires an account and internet access. Guest-to-account migration should be offered during account creation where feasible; the outcome must be clearly communicated, and duplicate/conflicting data must not be silently overwritten.

## Business Rules

1. A student may organize multiple terms and subjects; records belong to the student and relevant term/subject.
2. Grade calculations use an explicitly selected and documented grading scale and formula. The app must not assume one institution's grading rules apply to every student.
3. GWA is calculated only when required subject grades and scale mappings are present. Explain excluded or incomplete subjects and the calculation basis.
4. A target-grade calculation is shown only when the required current, remaining, and weighting inputs exist. Label the result as a planning estimate and expose its assumptions.
5. Dates and times are displayed in the user's local time zone. Items without a time can be treated as date-only deadlines.
6. Deleting or completing a record updates the dashboard and related calculations consistently.
7. A failed sync must not silently discard local edits; show sync status and a recoverable error.

## System Requirements

1. Support modern browsers with JavaScript and IndexedDB (or the selected local persistence mechanism).
2. Persist guest records locally and provide clear messaging that local data is device/browser-specific and can be removed by clearing browser storage.
3. Support authentication and cloud synchronization for signed-in students; core local academic organization remains usable when offline, while sync and other online services require connectivity.
4. Validate inputs and enforce per-user access controls on server-stored records. Protect data in transit and at rest using platform capabilities.
5. Provide account data export and deletion, and a documented retention policy for account and operational data.
6. Use least-privilege operational access. Do not collect precise location or create per-user behavioral tracking for advertising or data resale.
7. Focus countdown accuracy must not depend solely on repeated background execution. Recalculate from timestamps after tab visibility changes or resume. Wake Lock and Picture-in-Picture may be used where supported but are not release blockers.
8. Notifications are optional. In-app upcoming-work visibility is required; browser notifications are not a dependency for core deadline management.
9. The interface must support keyboard navigation, readable contrast, and clear labels for form errors and calculation assumptions.

## Privacy and Trust

- Collect only account, academic, and operational data needed for the stated features.
- Keep guest data on the device; do not transmit it unless the student chooses an account/sync flow.
- Do not sell identifiable academic data or use it for advertising. Any future aggregated use requires a separate privacy review and appropriate user notice/consent.
- Publish plain-language privacy and data deletion information before account registration.
- Apply applicable privacy law, including the Philippine Data Privacy Act where relevant, with retention and access practices documented before launch.

## MVP Success Measures

Measure whether the product delivers its core value with privacy-conscious, aggregate metrics:

1. **Activation:** proportion of new users who create a term and add a subject.
2. **Core value reached:** proportion of activated users who record a grade and view a calculated standing/GWA.
3. **Organization use:** proportion of activated users who add or complete an upcoming item.
4. **Reliability:** calculation errors, data-loss reports, and sync failures.
5. **Qualitative feedback:** recurring friction reported through the in-app feedback channel.

Use aggregate counts where practical; do not retain individual academic histories for product analytics. Define targets after a small pilot establishes a baseline.

## Out of Scope for MVP

Native apps, PWA installation guarantees, Web Push, calendar integration, automatic LMS/portal imports, social or collaborative features, AI recommendations, component-level weighted gradebooks, institution administration, advanced analytics, and dedicated admin UI. Revisit only when user evidence shows a clear need and the core workflows are reliable.

## Release Readiness

Before MVP release, confirm that:

- A guest can complete the core workflows and understands local data limitations.
- Grade/GWA and target calculations have documented rules, representative examples, and clear incomplete-input behavior.
- Authenticated users can access only their own synced records and can export/delete account data.
- Editing, completion, deletion, offline use, and sync recovery preserve consistent records.
- The dashboard presents useful empty, populated, and incomplete states.
- Privacy information, support/feedback route, and release notes are available.
