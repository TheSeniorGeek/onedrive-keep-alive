# OneDrive Keep Alive for macOS

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![Platform](https://img.shields.io/badge/Platform-macOS-lightgrey.svg)](https://apple.com/macos)
[![YouTube](https://img.shields.io/badge/YouTube-The%20Senior%20Geek-red.svg)](https://youtube.com/@TheSeniorGeek)

An automated, lightweight background utility designed to keep Microsoft OneDrive running reliably on macOS by monitoring its process and restarting it automatically if it crashes, closes, or silently hangs.

---

## 📺 Video Walkthrough

> 🎬 **Tutorial Coming Soon!** 
A complete video walkthrough and setup demonstration will be available shortly on **[The Senior Geek YouTube Channel](https://youtube.com/@TheSeniorGeek)**.

---

## ✨ Features

- **Automatic Health Monitoring:** Continually verifies that the OneDrive process is alive.
- **Smart 60-Second Cooldown:** Waits before restarting to let lingering locks and file handles release cleanly.
- **8-Hour Auto-Exit Safety:** Designed for background batch syncing without running indefinitely.
- **Single-Instance Protection:** Prevents duplicate processes if clicked multiple times.
- **Zero Dependencies:** Native macOS Zsh script—no extra runtimes or packages required.

---

## 🚀 Quick Start Guide

### Direct Download 

1. Download [`OneDrive_Keep_Alive.command`](OneDrive_Keep_Alive.command) to your **Downloads** folder.
2. Open the Terminal app
3. Make the file executable by entering the following in Terminal:
     ```bash
        chmod +x ~/Downloads/OneDrive_Keep_Alive.command

4. Double-click OneDrive_Keep_Alive.command in Finder to run.

## How to Stop the Script
Press Ctrl + C inside the open Terminal window at any time.
Closing the Terminal window will also terminate the monitoring loop.

## Contributing & Community
Suggestions, bug reports, and pull requests are welcome! If you encounter issues or have ideas to improve the utility:

Open an Issue on GitHub.

Submit a Pull Request with your enhancements.

## License
Distributed under the MIT License. See LICENSE for more information.
