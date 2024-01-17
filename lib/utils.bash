#!/usr/bin/env bash

set -euo pipefail

GH_REPO="https://github.com/shorebirdtech/shorebird"
TOOL_NAME="shorebird"
TOOL_TEST="shorebird --version"

fail() {
	echo -e "asdf-$TOOL_NAME: $*"
	exit 1
}

curl_opts=(-fsSL)

# NOTE: You might want to remove this if shorebird is not hosted on GitHub releases.
if [ -n "${GITHUB_API_TOKEN:-}" ]; then
	curl_opts=("${curl_opts[@]}" -H "Authorization: token $GITHUB_API_TOKEN")
fi

sort_versions() {
	sed 'h; s/[+-]/./g; s/.p\([[:digit:]]\)/.z\1/; s/$/.z/; G; s/\n/ /' |
		LC_ALL=C sort -t. -k 1,1 -k 2,2n -k 3,3n -k 4,4n -k 5,5n | awk '{print $2}'
}

list_github_tags() {
	git ls-remote --tags --refs "$GH_REPO" |
		grep -o 'refs/tags/.*' | cut -d/ -f3- |
		sed 's/^v//' # NOTE: You might want to adapt this sed to remove non-version strings from tags
}

list_all_versions() {
	# Change this function if shorebird has other means of determining installable versions.
	list_github_tags
}

download_release() {
	local version url
	version="$1"

	url="${GH_REPO}.git"

	echo "* Downloading $TOOL_NAME release $version..."
	git clone --depth 1 --branch "v$version" "$url" "$ASDF_DOWNLOAD_PATH"
}

install_version() {
	local install_type="$1"
	local version="$2"
	local install_path="${3%/bin}"

	if [ "$install_type" != "version" ]; then
		fail "asdf-$TOOL_NAME supports release installs only"
	fi

	(
		mkdir -p "$install_path"

		local tool_cmd
		tool_cmd="$(echo "$TOOL_TEST" | cut -d' ' -f1)"

    # shorebird downloads and caches its internal flutter version on first use
    "$ASDF_DOWNLOAD_PATH/bin/$tool_cmd"

		cp -r "$ASDF_DOWNLOAD_PATH"/.git "$install_path"
		cp -r "$ASDF_DOWNLOAD_PATH"/* "$install_path"

		# avoid file permission override when asdf core deletes the download folder
		rm -rf "$ASDF_DOWNLOAD_PATH"/.git

		test -x "$install_path/bin/$tool_cmd" || fail "Expected $install_path/bin/$tool_cmd to be executable."

		echo "$TOOL_NAME $version installation was successful!"
	) || (
		rm -rf "$install_path"
		fail "An error occurred while installing $TOOL_NAME $version."
	)
}
