#!/bin/bash

#------------------------------------------
#                patches
#------------------------------------------

patch1="$HOME/patches/patches/a53_avium/0001-add-avium-stuff.patch"
patch2="$HOME/patches/patches/a53_avium/0002-del-sfc-nfs-from-file-contexts.patch"
patch3="$HOME/patches/patches/a53_avium/0003-change-dimens.patch"
patch4="$HOME/patches/patches/a53_avium/0004-add-blur-flag.patch"
patch5="$HOME/patches/patches/a53_avium/0005-patch-libepicoperator.c.patch"
patch6="$HOME/patches/patches/a53_avium/0006-fix-libsec-ril-missing-lib.patch"
patch7="$HOME/patches/patches/a53_avium/0007-hmm.patch"

#------------------------------------------
#             moved to dir patches
#------------------------------------------

patch1_a="$HOME/roms/avium/device/samsung/a53x/0001-add-avium-stuff.patch"
patch2_a="$HOME/roms/avium/device/samsung/s5e8825-common/0002-del-sfc-nfs-from-file-contexts.patch"
patch3_a="$HOME/roms/avium/device/samsung/a53x/0003-change-dimens.patch"
patch4_a="$HOME/roms/avium/device/samsung/a53x/0004-add-blur-flag.patch"
patch5_a="$HOME/roms/avium/device/samsung/s5e8825-common/0005-patch-libepicoperator.c.patch"
patch6_a="$HOME/roms/avium/vendor/samsung/s5e8825-common/0006-fix-libsec-ril-missing-lib.patch"
patch7_a="$HOME/roms/avium/device/samsung/s5e8825-common/0007-hmm.patch"

#------------------------------------------
#             dirs to copy to
#------------------------------------------

a53x_dt="$HOME/roms/avium/device/samsung/a53x/"
s5e8825_common_dt="$HOME/roms/avium/device/samsung/s5e8825-common/"
vendor_s5e8825_dt="$HOME/roms/avium/vendor/samsung/s5e8825-common/"

#-----------------------------------------------------------------------
#          copy patches to the dirs where we apply the patches
#-----------------------------------------------------------------------

echo "copying patches to expected dirs.."
cp "$patch1" "$a53x_dt"
cp "$patch2" "$s5e8825_common_dt"
cp "$patch3" "$a53x_dt"
cp "$patch4" "$a53x_dt"
cp "$patch5" "$s5e8825_common_dt"
cp "$patch6" "$vendor_s5e8825_dt"
cp "$patch7" "$s5e8825_common_dt"

#-------------------------------------------
#              apply patches
#-------------------------------------------

cd "$a53x_dt"

echo "applying a53x patches.."
git am "$patch1_a" || git am --abort
git am "$patch3_a" || git am --abort
git am "$patch4_a" || git am --abort

cd "$s5e8825_common_dt"

echo "applying s5e8825-common patches.."
git am "$patch2_a" || git am --abort
git am "$patch5_a" || git am --abort
git am "$patch7_a" || git am --abort

cd "$vendor_s5e8825_dt"

echo "applying s5e8825-common vendor patches.."
git am "$patch6_a" || git am --abort

echo "remove applied patches.."

cd "$a53x_dt"

echo "removing a53x patches.."
rm -rf "$patch1_a"
rm -rf "$patch3_a"
rm -rf "$patch4_a"

cd "$s5e8825_common_dt"

echo "removing s5e8825-common patches.."
rm -rf "$patch2_a"
rm -rf "$patch5_a"
rm -rf "$patch7_a"

cd "$vendor_s5e8825_dt"

echo "removing s5e8825-common vendor patches.."
rm -rf "$patch6_a"

echo "done!"
