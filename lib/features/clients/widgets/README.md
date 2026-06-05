# Clients Widgets

This directory contains reusable widget components for the clients feature.

## Widgets Index

### 1. ActionButton
A circular action button with hover effects and icon support for both Material Icons and HugeIcons.

**Usage:**
```dart
ActionButton(
  icon: Icons.history,
  onTap: () => print('History tapped'),
  size: 36,
  iconColor: AppColors.textMutedDark,
)
```

### 2. AvatarFallback
Displays user initials as an avatar fallback when no image is available.

**Usage:**
```dart
AvatarFallback(
  name: 'John Doe',
  size: 48,
  backgroundColor: Color(0xFF1E2024),
)
```

### 3. ClientCard
The main client list item card displaying client information, status, revenue, and action buttons.

**Usage:**
```dart
ClientCard(
  client: client,
  onHistoryTap: () => viewClientHistory(client.id),
  onDownloadTap: () => downloadClientData(client),
  onNotificationTap: () => sendNotification(client),
  onCardTap: () => navigateToClientDetails(client),
)
```

### 4. ClientsEmptyState
Displayed when no clients are found, with optional action button.

**Usage:**
```dart
ClientsEmptyState(
  message: 'No clients found',
  actionText: 'Add Your First Client',
  onAction: () => navigateToNewClient(),
)
```

### 5. ClientsSearchBar
Search bar with integrated "Add Client" button.

**Usage:**
```dart
ClientsSearchBar(
  controller: searchController,
  hintText: 'Search clients...',
  onChanged: (query) => filterClients(query),
  onAddClient: () => navigateToNewClient(),
)
```

### 6. GlassCard
Glass morphism card with blur effect, used as a container for other widgets.

**Usage:**
```dart
GlassCard(
  child: YourContent(),
  borderRadius: 16,
  padding: EdgeInsets.all(16),
)
```

### 7. GridMeshPainter
Custom painter for grid mesh background effects.

**Usage:**
```dart
CustomPaint(
  painter: GridMeshPainter(
    color: Colors.white,
    strokeWidth: 1.0,
    step: 24.0,
  ),
)
```

### 8. StatusTag
Displays client status with appropriate colors for different status types.

**Usage:**
```dart
// Automatic from status string
StatusTag.fromStatus(client.status)

// Manual creation
StatusTag.settled()
StatusTag.pending()
StatusTag.overdue()
```

## Importing

Import all widgets at once:
```dart
import 'package:morla/features/clients/widgets/index.dart';
```

Or import individual widgets:
```dart
import 'package:morla/features/clients/widgets/client_card.dart';
```

## Utilities

The `utils/format_utils.dart` file contains formatting functions used across widgets:
- `FormatUtils.formatCurrency()` - Format currency values
- `FormatUtils.getInitials()` - Get initials from names
- `FormatUtils.formatDate()` - Format dates to readable strings