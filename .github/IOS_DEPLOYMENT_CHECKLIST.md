# iOS Deployment Checklist

Use this checklist to ensure you've completed all steps for iOS deployment.

## Pre-Deployment Setup

### Apple Developer Account
- [ ] Active Apple Developer Program membership ($99/year)
- [ ] Two-factor authentication enabled
- [ ] Access to App Store Connect
- [ ] Access to Apple Developer Portal

### App Store Connect
- [ ] App created in App Store Connect
- [ ] Bundle ID configured and matches Xcode project
- [ ] App information completed (name, description, category)
- [ ] Screenshots prepared (required sizes)
- [ ] App icon uploaded (1024x1024px)
- [ ] Privacy policy URL provided
- [ ] Support URL provided
- [ ] Age rating completed
- [ ] App Review information filled out

### Certificates & Profiles
- [ ] Apple Distribution certificate created
- [ ] Certificate exported as .p12 file
- [ ] .p12 password saved securely
- [ ] App Store provisioning profile created
- [ ] Provisioning profile downloaded
- [ ] Team ID noted
- [ ] Bundle ID confirmed

### App Store Connect API
- [ ] API Key created in App Store Connect
- [ ] API Key (.p8 file) downloaded
- [ ] Issuer ID noted
- [ ] Key ID noted
- [ ] API Key has "App Manager" role

### GitHub Repository Setup
- [ ] Repository created
- [ ] Workflow files added (.github/workflows/ios-deploy.yml)
- [ ] ExportOptions.plist configured
- [ ] All GitHub Secrets added (see below)

## GitHub Secrets Configuration

### Required Secrets
- [ ] `APPLE_CERTIFICATES_P12` (Base64 encoded .p12)
- [ ] `APPLE_CERTIFICATES_PASSWORD` (Certificate password)
- [ ] `PROVISIONING_PROFILE_BASE64` (Base64 encoded .mobileprovision)
- [ ] `APPSTORE_ISSUER_ID` (From App Store Connect API)
- [ ] `APPSTORE_API_KEY_ID` (From App Store Connect API)
- [ ] `APPSTORE_API_PRIVATE_KEY` (Content of .p8 file)

### Optional Secrets
- [ ] `API_BASE_URL` (Your production API endpoint)
- [ ] `SENTRY_DSN` (For crash reporting)
- [ ] `SLACK_WEBHOOK_URL` (For build notifications)
- [ ] `SSH_PRIVATE_KEY` (If using private dependencies)

## Project Configuration

### Xcode Project
- [ ] Project opens without errors
- [ ] Signing & Capabilities configured
- [ ] Team selected
- [ ] Bundle Identifier matches App Store Connect
- [ ] Version number set in pubspec.yaml
- [ ] Build number will be auto-incremented by GitHub Actions

### Flutter Configuration
- [ ] pubspec.yaml has correct app name and version
- [ ] iOS deployment target set (minimum iOS 12.0)
- [ ] All dependencies compatible with iOS
- [ ] App icons configured in Assets.xcassets
- [ ] Launch screen configured

### Info.plist Configuration
- [ ] CFBundleDisplayName set
- [ ] CFBundleIdentifier correct
- [ ] NSCameraUsageDescription (if using camera)
- [ ] NSPhotoLibraryUsageDescription (if using photos)
- [ ] NSLocationWhenInUseUsageDescription (if using location)
- [ ] Any other required permission descriptions

## Pre-Launch Checklist

### Testing
- [ ] App builds successfully locally
- [ ] All features tested on physical iOS device
- [ ] App tested on multiple iOS versions
- [ ] App tested on different screen sizes (iPhone SE to Pro Max)
- [ ] Dark mode appearance verified
- [ ] App tested on iPad (if supporting)
- [ ] Memory leaks checked
- [ ] App Store review guidelines reviewed

### Content & Metadata
- [ ] App description written (up to 4000 characters)
- [ ] Keywords selected (max 100 characters, comma-separated)
- [ ] Promotional text written (170 characters)
- [ ] What's New text for this version
- [ ] Screenshots for all required sizes:
  - 6.7" Display (iPhone 15 Pro Max)
  - 6.5" Display
  - 5.5" Display
  - 12.9" iPad Pro (if supporting iPad)

### Legal & Compliance
- [ ] Privacy policy URL accessible
- [ ] Terms of service URL accessible
- [ ] COPPA compliance verified (if targeting children)
- [ ] Export compliance information completed
- [ ] Content rights verified (no copyright infringement)

## Deployment Steps

### First-Time Deployment
- [ ] Run setup script: `bash .github/scripts/setup-secrets.sh`
- [ ] All secrets added to GitHub
- [ ] ExportOptions.plist updated with Team ID
- [ ] Test build triggered manually from GitHub Actions
- [ ] Build completes successfully
- [ ] App appears in TestFlight

### Regular Updates
- [ ] Version number bumped in pubspec.yaml
- [ ] CHANGELOG.md updated
- [ ] What's New text prepared
- [ ] Code committed and pushed
- [ ] Tag created for release: `git tag v1.0.X`
- [ ] Tag pushed: `git push origin v1.0.X`
- [ ] GitHub Actions workflow started automatically
- [ ] Build successful in GitHub Actions
- [ ] App uploaded to TestFlight
- [ ] TestFlight build processed
- [ ] Internal testing completed
- [ ] Submitted for App Store review

## Post-Deployment

### TestFlight
- [ ] TestFlight testers invited
- [ ] External testing submitted for review (if applicable)
- [ ] Feedback collected from testers
- [ ] Bugs fixed before App Store submission

### App Store Submission
- [ ] Final TestFlight build selected
- [ ] All app information verified
- [ ] Screenshots verified
- [ ] Submitted for review
- [ ] App Store review team notified
- [ ] Contact information verified

### After Approval
- [ ] Release date set (immediate or scheduled)
- [ ] App released to App Store
- [ ] Social media announcement prepared
- [ ] Support channels ready
- [ ] Crash reporting monitoring active
- [ ] User reviews monitored
- [ ] Analytics configured and monitored

## Troubleshooting

### Common Issues
- [ ] Certificate expired → Generate new certificate
- [ ] Provisioning profile invalid → Regenerate profile
- [ ] Build fails → Check Xcode/Flutter versions
- [ ] Code signing error → Verify Team ID and Bundle ID
- [ ] API key expired → Generate new API key
- [ ] TestFlight processing stuck → Wait or contact Apple Support

### Support Resources
- [ ] Apple Developer Documentation bookmarked
- [ ] App Store Connect Help bookmarked
- [ ] Flutter iOS deployment guide bookmarked
- [ ] GitHub Actions documentation bookmarked

## Maintenance Schedule

### Weekly
- [ ] Check App Store reviews
- [ ] Monitor crash reports
- [ ] Review analytics

### Monthly
- [ ] Check certificate expiration dates
- [ ] Review API key expiration
- [ ] Update dependencies if needed

### Annually
- [ ] Renew Apple Developer Program membership
- [ ] Rotate certificates and profiles
- [ ] Generate new API keys
- [ ] Review and update app metadata

---

## Quick Commands

```bash
# Build locally
flutter build ios --release

# Run setup script
bash .github/scripts/setup-secrets.sh

# Create release tag
git tag v1.0.0
git push origin v1.0.0

# Check build status
# Go to: https://github.com/YOUR_USERNAME/YOUR_REPO/actions
```

## Emergency Contacts

- **Apple Developer Support**: https://developer.apple.com/support/
- **App Store Connect Support**: https://help.apple.com/app-store-connect/
- **GitHub Support**: https://support.github.com/

---

**Last Updated**: December 2024
**Version**: 1.0
