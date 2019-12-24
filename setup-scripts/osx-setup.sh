#!/usr/local/bin/bash

###############################################################################
# Keybaord
###############################################################################

# Binding Caps-lock to Control
keyboard_id="$(ioreg -n IOHIDKeyboard -r | grep -e VendorID\" -e ProductID | tr -d \"\|[:blank:] | cut -d\= -f2 | tr '\n' -)"
#defaults -currentHost write -globalDomain "com.apple.keyboard.modifiermapping.${keyboard_id}0" '(
defaults write GlobalPreferences "com.apple.keyboard.modifiermapping.${keyboard_id}0" '(
{
  HIDKeyboardModifierMappingDst = 2;
  HIDKeyboardModifierMappingSrc = 0;
})'
# This I found is a way to make the above take effect but it doesn't seem to work...
#sudo cp ~/Library/Preferences/ByHost/.GlobalPreferences.*.plist /var/root/Library/Preferences/ByHost

# Make function keys use normal F1-F12 as default
defaults write -g com.apple.keyboard.fnState -bool true

# Disable smart quotes as they’re annoying when typing code
defaults write NSGlobalDomain NSAutomaticQuoteSubstitutionEnabled -bool false

# Disable smart dashes as they’re annoying when typing code
defaults write NSGlobalDomain NSAutomaticDashSubstitutionEnabled -bool false

###############################################################################
# Finder
###############################################################################

# Show hidden files and file extensions by default
defaults write com.apple.finder AppleShowAllFiles -bool true
defaults write NSGlobalDomain AppleShowAllExtensions -bool true

# Show status bar in Finder
defaults write com.apple.finder ShowStatusBar -bool true

# Finder: show path bar
defaults write com.apple.finder ShowPathbar -bool true

# Display full POSIX path as Finder window title
defaults write com.apple.finder _FXShowPosixPathInTitle -bool true

# When performing a search, search the current folder by default
defaults write com.apple.finder FXDefaultSearchScope -string "SCcf"

# Disable the warning when changing a file extension
defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false

# enable airdrop
defaults write com.apple.NetworkBrowser DisableAirDrop -bool NO

###############################################################################
# Spaces
###############################################################################

# Disable Dashboard
defaults write com.apple.dashboard mcx-disabled -bool true

# Don’t show Dashboard as a Space
defaults write com.apple.dock dashboard-in-overlay -bool true

# Don’t automatically rearrange Spaces based on most recent use
defaults write com.apple.dock mru-spaces -bool false

###############################################################################
# Chrome
###############################################################################

# Disable the all too sensitive backswipe on trackpads
defaults write com.google.Chrome AppleEnableSwipeNavigateWithScrolls -bool false
defaults write com.google.Chrome.canary AppleEnableSwipeNavigateWithScrolls -bool false
defaults write com.google.Chrome.plist AppleEnableSwipeNavigateWithScrolls -bool false


# Disable the all too sensitive backswipe on Magic Mouse
defaults write com.google.Chrome AppleEnableMouseSwipeNavigateWithScrolls -bool false
defaults write com.google.Chrome.canary AppleEnableMouseSwipeNavigateWithScrolls -bool false

###############################################################################
# SizeUp.app                                                                  #
###############################################################################

# Start SizeUp at login
defaults write com.irradiatedsoftware.SizeUp StartAtLogin -bool true

# Don’t show the preferences window on next start
defaults write com.irradiatedsoftware.SizeUp ShowPrefsOnNextStart -bool false

###############################################################################
# Other
###############################################################################

# Require password immediately after sleep or screen saver.
defaults write com.apple.screensaver askForPassword -int 1
defaults write com.apple.screensaver askForPasswordDelay -int 0

# Allow text-selection in Quick Look
defaults write com.apple.finder QLEnableTextSelection -bool true

# Avoid creating .DS_Store files on network volumes
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true

# Disable Notification Center and remove the menu bar icon
launchctl unload -w /System/Library/LaunchAgents/com.apple.notificationcenterui.plist 2> /dev/null

killall Finder
