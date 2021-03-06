# quiz_app

A quiz-app bundled with Provider package for state management.

## Implemented Features

- MVVM (Provider+ChangeNotifiers) state sharing and state managing solution
- Fully featured localization / internationalization (i18n):
    - Pluralization support
    - Static keys support with automatic string constants generation using the following command:
        - `flutter pub run build_runner build --delete-conflicting-outputs`
    - Supports both languageCode (en) and languageCode_countryCode (en_US) locale formats
    - Automatically save & restore the selected locale
    - Full support for right-to-left locales
    - Fallback locale support in case the system locale is unsupported
    - Supports both inline or nested JSON
- NOSQL database integration (SEMBAST)
- Light/Dark theme configuration
- Dynamic Themes changing using Provider
- Automatic font selection based on the thickness of the glyphs applied.
- API client configuration
- DEV/STAGE/PROD application configuration
- Multilevel configurable logger
- Static analysis tool integration (flutter_lints package + custom rules config)
- Common widgets sharing and reusing example

## Course Work:
https://docs.google.com/document/d/13r1c5ow6TjXw-0BH5R8YzwD85fAOZIfm/edit# 

