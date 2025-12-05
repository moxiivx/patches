#!/bin/bash

#------------------------------------------
#                patches
#------------------------------------------

patch1="$HOME/patches/patches/a53_avium/0001-add-avium-stuff.patch"
patch2="$HOME/patches/patches/a53_avium/0002-del-sfc-nfs-from-file-contexts.patch"
patch3="$HOME/patches/patches/a53_avium/0003-change-dimens.patch"
patch4="$HOME/patches/patches/a53_avium/0004-add-blur-flag.patch"
patch5="$HOME/patches/patches/a53_avium/0005-patch-libepicoperator.c.patch"

#------------------------------------------
#             dirs to copy to
#------------------------------------------

a53x_dt="$HOME/roms/avium/device/samsung/a53x/"
s5e8825_common_dt="$HOME/roms/avium/device/samsung/s5e8825-common/"

#-----------------------------------------------------------------------
#          copy patches to the dirs where we apply the patches
#-----------------------------------------------------------------------

echo "copying patches to expected dirs.."
cp "$patch1" "$a53x_dt"
cp "$patch2" "$s5e8825_common_dt"
cp "$patch3" "$a53x_dt"
cp "$patch4" "$a53x_dt"
cp "$patch2" "$s5e8825_common_dt"

#-------------------------------------------
#              apply patches
#-------------------------------------------

cd "$a53x_dt"

echo "applying a53x patches.."
git am "$patch1" || git am --abort
git am "$patch3" || git am --abort
git am "$patch4" || git am --abort

cd "$s5e8825_common_dt"

echo "applying s5e8825-common patches.."
git am "$patch2" || git am --abort
git am "$patch5" || git am --abort

echo "done!"
