info_version_xkeen() {
	VERSION=$(curl -s "$XKEEN_API_URL" | jq -r '.tag_name' | sed 's/v//')
	XKEEN_GITHUB_VERSION="$VERSION"
}