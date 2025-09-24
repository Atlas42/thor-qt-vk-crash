# QT+Vulkan crash test on Nvidia Thor

This repository provides a simple example that produce a vulkan driver error on the Nvidia Thor device

## Prerequisites:

- NVidia Thor dev kit
- Tegra R38.2.1, up-to date as of 25/09/24
- Qt 6.9.2, installed from:
  - https://download.qt.io/official_releases/online_installers/qt-online-installer-linux-arm64-online.run
  - Installed with minimal options

## Run sample

Start with the qml interpreter:

    $ ~/Qt/6.9.2/gcc_arm64/bin/qml -style Universal -r vulkan Player.qml

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
