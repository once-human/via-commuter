#!/bin/bash

# Create temporary directory
mkdir -p temp_icons

# Convert original logo to PNG with transparency and proper sizing
magick assets/images/via_logo.png -background none -resize 192x192 temp_icons/icon_xxxhdpi.png
magick assets/images/via_logo.png -background none -resize 144x144 temp_icons/icon_xxhdpi.png
magick assets/images/via_logo.png -background none -resize 96x96 temp_icons/icon_xhdpi.png
magick assets/images/via_logo.png -background none -resize 72x72 temp_icons/icon_hdpi.png
magick assets/images/via_logo.png -background none -resize 48x48 temp_icons/icon_mdpi.png

# Create mipmap directories
mkdir -p android/app/src/main/res/mipmap-xxxhdpi
mkdir -p android/app/src/main/res/mipmap-xxhdpi
mkdir -p android/app/src/main/res/mipmap-xhdpi
mkdir -p android/app/src/main/res/mipmap-hdpi
mkdir -p android/app/src/main/res/mipmap-mdpi

# Copy regular icons
cp temp_icons/icon_xxxhdpi.png android/app/src/main/res/mipmap-xxxhdpi/ic_launcher.png
cp temp_icons/icon_xxhdpi.png android/app/src/main/res/mipmap-xxhdpi/ic_launcher.png
cp temp_icons/icon_xhdpi.png android/app/src/main/res/mipmap-xhdpi/ic_launcher.png
cp temp_icons/icon_hdpi.png android/app/src/main/res/mipmap-hdpi/ic_launcher.png
cp temp_icons/icon_mdpi.png android/app/src/main/res/mipmap-mdpi/ic_launcher.png

# Create round icons with proper transparency
magick temp_icons/icon_xxxhdpi.png -background none -gravity center -extent 192x192 -alpha set -channel A -evaluate set 100% +channel -size 192x192 xc:none -draw "roundrectangle 0,0,192,192,96,96" -compose SrcIn -composite android/app/src/main/res/mipmap-xxxhdpi/ic_launcher_round.png
magick temp_icons/icon_xxhdpi.png -background none -gravity center -extent 144x144 -alpha set -channel A -evaluate set 100% +channel -size 144x144 xc:none -draw "roundrectangle 0,0,144,144,72,72" -compose SrcIn -composite android/app/src/main/res/mipmap-xxhdpi/ic_launcher_round.png
magick temp_icons/icon_xhdpi.png -background none -gravity center -extent 96x96 -alpha set -channel A -evaluate set 100% +channel -size 96x96 xc:none -draw "roundrectangle 0,0,96,96,48,48" -compose SrcIn -composite android/app/src/main/res/mipmap-xhdpi/ic_launcher_round.png
magick temp_icons/icon_hdpi.png -background none -gravity center -extent 72x72 -alpha set -channel A -evaluate set 100% +channel -size 72x72 xc:none -draw "roundrectangle 0,0,72,72,36,36" -compose SrcIn -composite android/app/src/main/res/mipmap-hdpi/ic_launcher_round.png
magick temp_icons/icon_mdpi.png -background none -gravity center -extent 48x48 -alpha set -channel A -evaluate set 100% +channel -size 48x48 xc:none -draw "roundrectangle 0,0,48,48,24,24" -compose SrcIn -composite android/app/src/main/res/mipmap-mdpi/ic_launcher_round.png

# Clean up
rm -rf temp_icons 