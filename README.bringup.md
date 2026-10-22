# Martini: LineageOS 17.1 bring-up

This is an Android 10 device tree based on the existing Hammerhead port. The
hardware/boot-image reference is the local `twrp-6.0` device tree, commit
`35a221f`, and its built `recovery.img`. A bootable recovery establishes a
hardware reference; it does not validate the Android framework or vendor HALs.

## Boot configuration

- Keep the TWRP boot image format: header version 0, 2048-byte pages,
  base `0x10100000`, kernel offset `0x00008000`, tags offset `0x02000000`,
  ramdisk offset `0x02200000`, and an appended DTB (`zImage-dtb`). The resulting
  load addresses match the existing TWRP image: kernel `0x10108000`,
  tags `0x12100000`, ramdisk `0x12300000`.
- Use TWRP's 32 MiB boot/recovery image limits and `RGBX_8888` recovery format.
- Use the Android 10 kernel/config already selected here:
  `kernel/nokia/martini`, `lineageos_martini_defconfig`. Do not substitute
  TWRP's Android 6 kernel/config for the Android 10 kernel.
- Pass `androidboot.hardware=martini`. Both Android init and recovery select
  `init.${ro.hardware}.rc`; first-stage fs_mgr also selects `fstab.<hardware>`.
  The former `qcom` argument did not match the installed Martini files and
  could prevent `/system` from mounting before second-stage init.
- Pass `androidboot.bootdevice=msm_sdcc.1` and select the working `ttyHSL0`
  console. Keep the existing permissive bring-up setting; enforcing SELinux
  still needs device validation.

## Android 10 integration

The `/system` fstab entry retains `first_stage_mount`, with `fstab.martini` in
both the first-stage ramdisk and vendor configuration. Vendor files remain
under `/system/vendor` (the build system's default), without adding a separate
vendor image. TWRP's vendor/verity entries must not be copied wholesale into
this configuration.

The kernel uses the legacy `android_usb` gadget. Device USB actions cover
MTP/PTP/RNDIS/MIDI, while Android 10's common `init.usb.rc` supplies adb-only,
accessory and disconnect actions. The device script mounts FunctionFS and
keeps the existing ADB compatibility settings. The USB configfs command-line
claim was removed because this kernel does not implement that USB interface.
Recovery receives its own device-node permissions file.

`kernel-headers/linux/msm_audio_calibration.h` is the original compatibility
header restored from this repository's HEAD. It supplies the metadata type
used by the selected AOSP Qualcomm audio HAL; it does not add a new kernel
calibration driver or establish audio runtime compatibility.

The lights service registers backlight support even when the Hammerhead RGB
LED nodes are absent. RGB light types are advertised only when all of their
required files are open. Light states start cleared, so the first battery or
notification update does not inspect uninitialized state.

## Build and device validation

From the Android source root, in a configured build shell:

```sh
source build/envsetup.sh
lunch lineage_martini-userdebug
m -j8 audio.primary.msm8974 android.hardware.light@2.0-service.hh bootimage
# Build recovery separately when needed:
m -j8 recoveryimage
```

Do not erase the output directory to resolve the missing header. Android's
build configuration discovers the restored device `kernel-headers` directory.

Before installing images, confirm the physical partition layout from the
working TWRP. The system/userdata/cache image limits and the userdata encryption
metadata path still come from the existing port: the TWRP tree does not give
actual sizes or prove the presence of the metadata partition. Keep these
settings pending the device's partition listing rather than guessing values.
The inherited raw firmware partition entries and OTA radio/bootloader hooks
also need a separate audit against the actual Nokia layout before using them.

Capture serial output and, once available, `adb logcat -b all` and `adb shell
dmesg`. Check first-stage system mounting, device init loading, `/data` and
`/cache`, USB ADB, SurfaceFlinger and backlight. The vendor tree still contains
Hammerhead-derived binaries/configuration (including camera, sensors and
firmware), so their presence in a successful build does not prove they work on
Martini. Full Android startup and peripheral support require hardware tests.
