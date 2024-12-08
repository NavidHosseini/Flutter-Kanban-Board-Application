
# Flutter Kanban Board Application

A feature-rich Flutter application for managing tasks using a Kanban board interface. It includes a timer for task tracking, task history, commenting functionality, localization, theming, Firebase Analytics integration, and follows Test-Driven Development (TDD) practices.

---

## Features

### 1. Kanban Board
- Organize tasks into "To Do," "In Progress," and "Done" columns.
- Drag-and-drop functionality for seamless task management.

### 2. Timer
- Start/stop/reset/end a timer for individual tasks to track time spent.
- Display total time spent on tasks in the task history.

### 3. Task History
- View completed tasks with details:
  - Time spent.
  - Completion date.
  - Associated comments.

### 4. Commenting System
- Add and view comments for tasks.

### 5. Localization
- Multilingual support for a diverse audience.
- Dynamically adjusts the UI text based on language preferences.

### 6. Theming
- Support for multy themes.
- Customize app appearance for user comfort.

### 7. Firebase Analytics
- Track user interactions and app usage.
- Gather insights for improving user experience.

### 8. Test-Driven Development (TDD)
- Ensures high code quality with robust unit test.

---

## Prerequisites

- **Flutter SDK**: [Install Flutter](https://flutter.dev/docs/get-started/install)
- **Code Editor**: Visual Studio Code (recommended) or Android Studio with Flutter plugin.
- **Device/Emulator**: Physical device or Android/iOS emulator.

---

## How to Run the App

1. **Clone or Extract the Project**
   - Clone the repository or extract the project files.

2. **Open the Project**
   - Use Visual Studio Code or your preferred IDE to open the project.

3. **Install Dependencies**
   ```bash
   flutter pub get
   ```

4. **Run the App**
   ```bash
   flutter run
   ```
   - To run on a specific device:
     ```bash
     flutter run -d <device_id>
     ```
   - List available devices:
     ```bash
     flutter devices
     ```

5. **Test the App**
   - Run tests:
     ```bash
     flutter test
     ```

---

## Folder Structure

- **add_task**: Module for adding new tasks to the Kanban board.
- **kanban**: Handles the main Kanban board UI and interactions.
- **task_detail**: Manages task details, including comments and timer.

---
