# twrp device tree for nokia Lumia 930 (martini)


```
repo init -u git://github.com/minimal-manifest-twrp/platform_manifest_twrp_omni.git -b twrp-6.0
repo sync
```

To Build:
```
cd <source-dir>
source build/envsetup.sh
lunch twrp_martini-userdebug
make clean
mka recoveryimage
```
