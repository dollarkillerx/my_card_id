# Student ID Card System Design

## Context
Build a student ID card management app in Flutter. Users can view, add, and manage multiple student ID cards with multi-language support (Chinese, Japanese, English).

## Pages & Navigation
- **Bottom Tab Bar** with 2 tabs: 学生证 (Cards) | 设置 (Settings)

### Tab 1: My Student Cards
- **Swipeable card carousel** (PageView) with dot indicator
- Each card shows: avatar, name (from card data or placeholder), institution, principal, validity status badge (valid/expired based on dates), date range
- **Empty state**: icon + hint text to go to settings to add
- **Visual style**: Modern minimalist — white card, rounded corners, indigo accent (#6366f1)

### Tab 2: Settings
- **Grouped list** (iOS settings style)
- Section "学生证管理": Add Student Card → navigates to form page
- Section "通用": Language → navigates to language selection page

### Add Student Card Form (push route)
- Back button, title
- Avatar picker (tap to select from gallery via image_picker)
- Fields: institution name (text), principal (text), start date (date picker), end date (date picker)
- Save button → validate → persist → pop back

### Language Selection (push route)
- Back button, title
- Radio list: 中文 / 日本語 / English
- Selection applies immediately, persisted to SharedPreferences

## Data Model
```dart
class StudentCard {
  String id;           // UUID
  String institution;  // e.g. "北京大学"
  String principal;    // e.g. "王五"
  DateTime startDate;
  DateTime endDate;
  String? avatarPath;  // local file path
}
```
- Status (valid/expired) computed from `endDate` vs `DateTime.now()`

## Storage
- **SharedPreferences** for card list (JSON-encoded) and language preference
- Avatar images saved to app documents directory

## Internationalization
- `flutter_localizations` + `intl` package
- 3 locales: zh, ja, en
- ARB files for each locale

## Dependencies
- `image_picker` — gallery photo selection
- `shared_preferences` — local persistence
- `intl` — date formatting & i18n
- `uuid` — unique card IDs

## Verification
1. Run `flutter run` on simulator
2. Switch between tabs
3. Add a student card with all fields + avatar
4. Verify card appears in carousel with correct data
5. Verify expired card shows expired badge
6. Switch language and confirm all UI text updates
