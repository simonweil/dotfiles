#!/usr/local/bin/bash

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
