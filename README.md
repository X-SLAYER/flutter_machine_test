# Flutter Machine Test - Dynamic Form Application

### Dynamic Form Generation
- Fully auto-generated forms from API responses
- field rendering based on JSON configuration
- Support for multiple field types (text, dropdown, date)

### Custom Validation Package
- Used a library i created for custom validation library inspired by [EzValidator](https://pub.dev/packages/ez_validator)
- Type-safe schema validation
- Declarative validation rules
- Reusable validation logic across forms

### Architecture
- **Presentation Layer**: UI components with Riverpod state management (MVVM)
- **Domain Layer**: Business logic and services call
- **Data Layer**: Repository pattern with local storage (SharedPreferences)

### Additional Features
- Multi-language support (English, Arabic, French)
- RTL layout support for Arabic
- Theme switching (Light/Dark mode)
- Local data persistence
- Smooth animations and transitions

## Tech Stack

- **State Management**: Riverpod
- **Local Storage**: SharedPreferences
- **Localization**: i18n with RTL support
- **Architecture**: Clean Architecture pattern + MVVM

## Screens

- Splash Screen
- Home Screen (Service listing)
- Dynamic Leave Request Form
- My Requests (Saved submissions)
- Request Details
- Settings (Theme & Language)

## APIs Integrated

- Dynamic Form API (field configuration)
- Leave Types API (dropdown data)
- Leave Delegations API (dropdown data)
