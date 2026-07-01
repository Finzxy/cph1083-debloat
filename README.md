# CPH1803 Debloat

ADB debloat scripts for **OPPO A3s (CPH1803)** running ColorOS. No root required.

## Requirements

- ADB installed and in PATH
- USB Debugging enabled on device
- Device connected via USB

## Usage

**Linux / macOS**
```bash
bash remove.sh
```

**Restore everything**
```bat
bash remove.sh    # Linux / macOS
```

> Uses `pm uninstall -k --user 0` — packages are disabled, not deleted. Safe to restore anytime.
