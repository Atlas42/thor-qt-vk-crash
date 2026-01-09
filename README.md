# QT+Vulkan crash test on Nvidia Thor

This repository provides a simple example that produce a vulkan driver error on the Nvidia Thor device

## Prerequisites:

- NVidia Thor or Orin dev kit, up-to date as of 25/10/14
  - Thor: Tegra R38.2.1 (Jetpack 7.0)
  - Thor: Tegra R38.4.0 (Jetpack 7.1)
  - Orin: Tegra R36.4.7 
- Qt 6.8.3, extracted to `./Qt` form Qt-thor-7-0.tar.gz, Qt-thor-7-1.tar.gz or Qt-orin.tar.gz:
  - `$ tar xvf Qt-thor-7-1.tar.gz`
- Qt dependencies:
  - `$ sudo apt install libvulkan-dev libx11-xcb1 libfontconfig1-dev libfreetype6-dev libx11-dev libx11-xcb-dev libxext-dev libxfixes-dev libxi-dev libxrender-dev libxcb1-dev libxcb-glx0-dev libxcb-keysyms1-dev libxcb-image0-dev libxcb-shm0-dev libxcb-icccm4-dev libxcb-sync-dev libxcb-xfixes0-dev libxcb-shape0-dev libxcb-randr0-dev libxcb-render-util0-dev libxcb-util-dev libxcb-xinerama0-dev libxcb-xkb-dev libxkbcommon-dev libxkbcommon-x11-dev libxcb-cursor-dev libpulse-dev`

## Run sample

Start with the qml interpreter:

    $ ./Qt/bin/qml -style Universal -r vulkan Main.qml

Then click on the `Open` button.

Observed behavior:
- The interface hangs, the button disappear or display garbage triangles
- After a few seconds those messages appears:
```
Device loss detected in vkQueueSubmit()
Graphics device lost, cleaning up scenegraph and releasing RHI
```
- `dmesg` show those errors:
```
[ 3265.471356] tegra-mc 8108020000.memory-controller: dispr: non-secure read @0x0000fffffffffa00: EMEM address decode error (EMEM decode error)
[ 3265.471391] tegra-mc 8108020000.memory-controller: ptcr: @0x0000000000000000: Read response with poison bit error status:0
[ 3265.481159] tegra-mc 8108020000.memory-controller: dispr: non-secure read @0x0000fffffffffe00: EMEM address decode error (EMEM decode error)
[ 3265.493729] tegra-mc 8108020000.memory-controller: dispr: non-secure read @0x0000fffffffff600: EMEM address decode error (EMEM decode error)
[ 3265.506301] tegra-mc 8108020000.memory-controller: dispr: non-secure read @0x0000fffffffffb00: EMEM address decode error (EMEM decode error)
[ 3265.518874] tegra-mc 8108020000.memory-controller: dispr: non-secure read @0x0000fffffffffc00: EMEM address decode error (EMEM decode error)
[ 3265.531480] tegra-mc 8108020000.memory-controller: ptcr: @0x0000000000000000: Read response with poison bit error status:0
[ 3265.542672] arm-smmu-v3 8806000000.iommu: EVTQ overflow detected -- events lost
[ 3265.549999] arm_smmu_evtq_thread: 25830 callbacks suppressed
[ 3265.550001] arm-smmu-v3 8806000000.iommu: event 0x10 received:
[ 3265.555549] arm-smmu-v3 8806000000.iommu: 	0x0000090000000010
[ 3265.555550] arm-smmu-v3 8806000000.iommu: 	0x0000020800000000
[ 3265.555551] arm-smmu-v3 8806000000.iommu: 	0x0000007ffd105a00
[ 3265.555552] arm-smmu-v3 8806000000.iommu: 	0x0000000000000000
```

## Notes

- The problem only appened when using vulkan, not opengl
- Removing some part of the test will make it work
