#!/bin/bash

# Setup Script for GitHub Secrets (iOS Deployment)
# This script helps you prepare the values needed for GitHub Secrets

set -e

echo "================================================"
echo "iOS Deployment Secrets Setup Helper"
echo "================================================"
echo ""

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Function to encode file to base64
encode_file() {
    local file=$1
    if [[ "$OSTYPE" == "darwin"* ]]; then
        base64 -i "$file"
    else
        base64 -w 0 "$file"
    fi
}

echo -e "${YELLOW}Step 1: Certificate (.p12 file)${NC}"
echo "Please provide the path to your .p12 certificate file:"
read -r cert_path

if [ -f "$cert_path" ]; then
    echo -e "${GREEN}✓ Certificate file found${NC}"
    cert_base64=$(encode_file "$cert_path")
    echo ""
    echo "APPLE_CERTIFICATES_P12 (copy this to GitHub Secrets):"
    echo "---"
    echo "$cert_base64"
    echo "---"
    echo ""
else
    echo -e "${RED}✗ Certificate file not found${NC}"
    exit 1
fi

echo -e "${YELLOW}Step 2: Certificate Password${NC}"
echo "Please enter the password for your .p12 certificate:"
read -rs cert_password
echo ""
echo "APPLE_CERTIFICATES_PASSWORD:"
echo "$cert_password"
echo ""

echo -e "${YELLOW}Step 3: Provisioning Profile${NC}"
echo "Please provide the path to your .mobileprovision file:"
read -r profile_path

if [ -f "$profile_path" ]; then
    echo -e "${GREEN}✓ Provisioning profile found${NC}"
    profile_base64=$(encode_file "$profile_path")
    echo ""
    echo "PROVISIONING_PROFILE_BASE64 (copy this to GitHub Secrets):"
    echo "---"
    echo "$profile_base64"
    echo "---"
    echo ""
else
    echo -e "${RED}✗ Provisioning profile not found${NC}"
    exit 1
fi

echo -e "${YELLOW}Step 4: App Store Connect API Key${NC}"
echo "Please provide the path to your .p8 API key file:"
read -r api_key_path

if [ -f "$api_key_path" ]; then
    echo -e "${GREEN}✓ API key file found${NC}"
    api_key_content=$(cat "$api_key_path")
    echo ""
    echo "APPSTORE_API_PRIVATE_KEY (copy this to GitHub Secrets):"
    echo "---"
    echo "$api_key_content"
    echo "---"
    echo ""
else
    echo -e "${RED}✗ API key file not found${NC}"
    exit 1
fi

echo -e "${YELLOW}Step 5: App Store Connect Credentials${NC}"
echo "Please enter your App Store Connect Issuer ID:"
read -r issuer_id
echo "APPSTORE_ISSUER_ID: $issuer_id"
echo ""

echo "Please enter your App Store Connect API Key ID:"
read -r api_key_id
echo "APPSTORE_API_KEY_ID: $api_key_id"
echo ""

echo -e "${YELLOW}Step 6: Team Information${NC}"
echo "Please enter your Apple Team ID:"
read -r team_id
echo "TEAM_ID: $team_id"
echo ""

echo "Please enter your Bundle Identifier (e.g., com.yourcompany.BillKit):"
read -r bundle_id
echo "APP_BUNDLE_ID: $bundle_id"
echo ""

echo -e "${YELLOW}Step 7: Optional Configurations${NC}"
echo "API Base URL (press Enter to skip):"
read -r api_url
if [ -n "$api_url" ]; then
    echo "API_BASE_URL: $api_url"
fi
echo ""

echo "Sentry DSN (press Enter to skip):"
read -r sentry_dsn
if [ -n "$sentry_dsn" ]; then
    echo "SENTRY_DSN: $sentry_dsn"
fi
echo ""

echo "Slack Webhook URL for notifications (press Enter to skip):"
read -r slack_webhook
if [ -n "$slack_webhook" ]; then
    echo "SLACK_WEBHOOK_URL: $slack_webhook"
fi
echo ""

# Create a summary file
summary_file="github-secrets-summary.txt"
cat > "$summary_file" << EOF
================================================
GitHub Secrets Summary for iOS Deployment
================================================
Generated: $(date)

Required Secrets:
-----------------
APPLE_CERTIFICATES_P12: [Base64 encoded - see above]
APPLE_CERTIFICATES_PASSWORD: $cert_password
PROVISIONING_PROFILE_BASE64: [Base64 encoded - see above]
APPSTORE_ISSUER_ID: $issuer_id
APPSTORE_API_KEY_ID: $api_key_id
APPSTORE_API_PRIVATE_KEY: [P8 file content - see above]

Team Configuration:
-------------------
TEAM_ID: $team_id
APP_BUNDLE_ID: $bundle_id

Optional Secrets:
-----------------
API_BASE_URL: ${api_url:-"(not set)"}
SENTRY_DSN: ${sentry_dsn:-"(not set)"}
SLACK_WEBHOOK_URL: ${slack_webhook:-"(not set)"}

Next Steps:
-----------
1. Go to your GitHub repository
2. Navigate to Settings → Secrets and variables → Actions
3. Click "New repository secret" for each secret above
4. Copy and paste the values
5. Update ios/ExportOptions.plist with your Team ID and Bundle ID
6. Push to main branch or create a tag to trigger deployment

⚠️  IMPORTANT: Keep this file secure and delete it after setup!

EOF

echo -e "${GREEN}================================================${NC}"
echo -e "${GREEN}Setup Complete!${NC}"
echo -e "${GREEN}================================================${NC}"
echo ""
echo "A summary has been saved to: $summary_file"
echo ""
echo -e "${YELLOW}Next Steps:${NC}"
echo "1. Go to: https://github.com/YOUR_USERNAME/YOUR_REPO/settings/secrets/actions"
echo "2. Add each secret listed above"
echo "3. Update ios/ExportOptions.plist with your Team ID"
echo "4. Push changes or create a tag to trigger deployment"
echo ""
echo -e "${RED}⚠️  Important: Delete $summary_file after copying secrets!${NC}"
echo ""
