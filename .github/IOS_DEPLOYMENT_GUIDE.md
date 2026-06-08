# iOS App Store Deployment Guide

This guide explains how to set up automated iOS builds and deployment to Apple App Store using GitHub Actions without needing a MacBook.

## Prerequisites

Before setting up the workflow, you need:

1. **Apple Developer Account** ($99/year)
2. **App Store Connect Access**
3. **Xcode Project Configuration** (already done in your project)

## Step 1: Create App in App Store Connect

1. Log in to [App Store Connect](https://appstoreconnect.apple.com)
2. Go to "My Apps" → Click the "+" button → "New App"
3. Fill in the required information:
   - **Platform**: iOS
   - **Name**: BillKit
   - **Primary Language**: English
   - **Bundle ID**: Select your bundle ID (e.g., `com.yourcompany.BillKit`)
   - **SKU**: A unique identifier (e.g., `BillKit-ios-001`)
4. Complete app information, screenshots, and privacy details

## Step 2: Generate App Store Connect API Key

1. In App Store Connect, go to **Users and Access** → **Keys** (under Integrations)
2. Click "+" to generate a new key
3. Give it a name (e.g., "GitHub Actions Deploy")
4. Select **App Manager** role
5. Click **Generate**
6. **Download the API Key (.p8 file)** - you can only download it once!
7. Note down:
   - **Issuer ID** (shown at the top)
   - **Key ID** (shown next to your key name)

## Step 3: Create Certificates and Provisioning Profiles

### Option A: Using Xcode on a Mac (One-time setup)

1. Open your project in Xcode on any Mac
2. Go to **Signing & Capabilities**
3. Enable **Automatically manage signing**
4. Select your Team
5. Build the project once to generate certificates
6. Export the certificates:
   - Open **Keychain Access**
   - Find "Apple Distribution" certificate
   - Right-click → Export → Save as `.p12` file
   - Set a strong password

### Option B: Using Fastlane Match (Recommended)

```bash
# Install fastlane
gem install fastlane

# Navigate to iOS directory
cd ios

# Initialize match
fastlane match init

# Generate certificates and profiles
fastlane match appstore
```

## Step 4: Export Provisioning Profile

1. Go to [Apple Developer Portal](https://developer.apple.com/account/resources/profiles)
2. Find your **App Store** provisioning profile
3. Download it
4. Convert to Base64:
   ```bash
   base64 -i YourProfile.mobileprovision | pbcopy
   ```

## Step 5: Configure GitHub Secrets

Go to your GitHub repository → **Settings** → **Secrets and variables** → **Actions**

Add the following secrets:

### Required Secrets:

1. **APPLE_CERTIFICATES_P12**
   - The certificate file exported in Step 3, converted to Base64
   ```bash
   base64 -i Certificates.p12 | pbcopy
   ```

2. **APPLE_CERTIFICATES_PASSWORD**
   - The password you set when exporting the certificate

3. **PROVISIONING_PROFILE_BASE64**
   - The provisioning profile from Step 4 (already in Base64)

4. **APPSTORE_ISSUER_ID**
   - The Issuer ID from Step 2

5. **APPSTORE_API_KEY_ID**
   - The Key ID from Step 2

6. **APPSTORE_API_PRIVATE_KEY**
   - Content of the `.p8` file from Step 2
   ```bash
   cat AuthKey_XXXXXXXXXX.p8 | pbcopy
   ```

### Optional Secrets:

7. **API_BASE_URL**
   - Your production API URL (e.g., `https://api.BillKit.com`)

8. **SENTRY_DSN** (if using Sentry)
   - Your Sentry DSN for crash reporting

9. **SLACK_WEBHOOK_URL** (optional)
   - Slack webhook for build notifications

## Step 6: Update Configuration Files

### Update `ios/ExportOptions.plist`:

```xml
<key>teamID</key>
<string>YOUR_TEAM_ID</string> <!-- Replace with your Team ID -->

<key>provisioningProfiles</key>
<dict>
    <key>com.yourcompany.BillKit</key> <!-- Replace with your Bundle ID -->
    <string>BillKit App Store Profile</string> <!-- Replace with your profile name -->
</dict>
```

### Update `ios/Runner.xcodeproj/project.pbxproj`:

Ensure your project has the correct:
- Development Team ID
- Bundle Identifier
- Code Signing Identity set to "Apple Distribution"

## Step 7: Trigger the Workflow

### Automatic Triggers:

- **Push to `main` branch** → Deploys to TestFlight
- **Create a tag `v1.0.0`** → Deploys to both TestFlight and App Store
- **Pull Request** → Builds only (no deployment)

### Manual Trigger:

1. Go to **Actions** tab in GitHub
2. Select "iOS Build and Deploy" workflow
3. Click "Run workflow"
4. Choose deployment target (TestFlight or App Store)

## Step 8: Monitor the Build

1. Go to **Actions** tab in your GitHub repository
2. Click on the running workflow
3. Monitor each step:
   - ✅ Build iOS App
   - ✅ Deploy to TestFlight
   - ✅ Deploy to App Store (for releases)

## Step 9: TestFlight Distribution

After successful TestFlight deployment:

1. Go to [App Store Connect](https://appstoreconnect.apple.com)
2. Navigate to **TestFlight**
3. The build will appear under "Builds" (may take 5-15 minutes to process)
4. Add internal/external testers
5. Submit for Beta review if using external testers

## Step 10: App Store Submission

For production release:

1. Create a tag: `git tag v1.0.0 && git push origin v1.0.0`
2. Workflow automatically deploys to App Store
3. Go to App Store Connect → Your App
4. The build will appear under "Build" section
5. Complete all required information:
   - Screenshots
   - Description
   - Keywords
   - Support URL
   - Privacy Policy URL
6. Click "Submit for Review"

## Troubleshooting

### Certificate Issues

```bash
# Check if certificate is valid
security find-identity -v -p codesigning

# Import certificate manually
security import Certificates.p12 -P YOUR_PASSWORD
```

### Provisioning Profile Issues

- Ensure the Bundle ID matches exactly
- Verify the provisioning profile includes your signing certificate
- Check that the profile hasn't expired

### Build Failures

1. Check Flutter/Xcode version compatibility
2. Verify all secrets are correctly set
3. Review CocoaPods dependencies
4. Check workflow logs for specific errors

### App Store Connect API Issues

- Verify API key hasn't expired (valid for ~1 year)
- Check API key has correct permissions (App Manager role)
- Ensure Issuer ID and Key ID are correct

## Version Bumping Strategy

### For Patch Updates (1.0.1 → 1.0.2):
```bash
# Update pubspec.yaml
version: 1.0.2+10

git commit -am "chore: bump version to 1.0.2"
git push origin main  # Deploys to TestFlight only
```

### For Production Releases:
```bash
# Create and push tag
git tag v1.0.2
git push origin v1.0.2  # Deploys to both TestFlight and App Store
```

## Best Practices

1. **Always test on TestFlight first** before App Store submission
2. **Use semantic versioning** (MAJOR.MINOR.PATCH)
3. **Keep certificates and profiles secure** - rotate annually
4. **Monitor crash reports** using Sentry or Firebase Crashlytics
5. **Update changelog** in App Store Connect for each release
6. **Respond to reviews** promptly to maintain good ratings

## Security Notes

- Never commit certificates or provisioning profiles to git
- Use GitHub Secrets for all sensitive data
- Rotate API keys annually
- Use separate certificates for development and distribution
- Enable two-factor authentication on Apple Developer account

## Costs

- **Apple Developer Program**: $99/year (required)
- **GitHub Actions**: ~2000 minutes/month free (macOS runners use 10x minutes)
- **Additional minutes**: ~$0.08/minute for macOS runners

## Support

For issues related to:
- **GitHub Actions**: Check workflow logs and Actions documentation
- **Apple App Store**: Contact Apple Developer Support
- **Code Signing**: Review Apple's Code Signing documentation

## Useful Commands

```bash
# Check Flutter iOS build locally
flutter build ios --release

# Check Xcode project configuration
xcodebuild -showBuildSettings -workspace ios/Runner.xcworkspace -scheme Runner

# Validate IPA before upload
xcrun altool --validate-app -f build/ios/ipa/*.ipa -t ios --apiKey KEY_ID --apiIssuer ISSUER_ID

# List provisioning profiles
security find-identity -v -p codesigning
```

## Additional Resources

- [Apple Developer Documentation](https://developer.apple.com/documentation/)
- [App Store Connect Help](https://help.apple.com/app-store-connect/)
- [Flutter iOS Deployment](https://docs.flutter.dev/deployment/ios)
- [Fastlane Documentation](https://docs.fastlane.tools/)
- [GitHub Actions for iOS](https://github.com/apple-actions)

---

**Last Updated**: December 2024
**Maintained By**: BillKit Development Team
