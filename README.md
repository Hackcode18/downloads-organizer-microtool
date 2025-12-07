# downloads-organizer-microtool
downloads-organizer-microtool/ ├─ .kiro/ │  └─ config.json ├─ src/ │  └─ organizer.py ├─ README.md ├─ requirements.txt ├─ .gitignore └─ LICENSE      # optional but recommended (MIT)
# Downloads Organizer Micro-Tool

> "I hate cleaning my messy Downloads folder, so I built this."

This project is a small **micro-tool** that automatically organizes files in your **Downloads** folder into subfolders based on file type. It can also optionally **rename** files into a clean, consistent pattern.

Built as part of the **AI for Bharat – Kiro Week 1 Micro-Tools Challenge**.

---

## ✨ Features

- Groups files into folders like:
  - `Organized/Images`
  - `Organized/PDFs`
  - `Organized/Documents`
  - `Organized/Archives`
  - `Organized/Others`
- Optional **renaming** with timestamps:
  - `pdf_2025-12-07_13-45-12_01.pdf`
  - `image_2025-12-07_09-30-00_01.jpg`
- **Dry-run mode** by default (safe: shows what would happen)
- Cross-platform (Linux, macOS, Windows)

---

## 🧠 Problem

My `Downloads` folder kept turning into a junkyard of:

- PDFs
- images and screenshots
- zip files
- random installers

Every few days I had to manually:

1. Select files by type  
2. Create folders  
3. Move and rename everything  

It was boring, repetitive, and easy to procrastinate.

---

## ✅ Solution

I wrote a simple Python script that:

1. Scans the Downloads folder  
2. Detects the file type from its extension  
3. Decides a **group** (Images, PDFs, Documents, etc.)  
4. Moves the file into `Downloads/Organized/<Group>/`  
5. Optionally renames the file to a clean, timestamp-based name  

Now, instead of cleaning manually, I just run **one command**.

---

## 📦 Installation

### 1. Clone the repository

```bash
git clone https://github.com/<your-username>/downloads-organizer-microtool.git
cd downloads-organizer-microtool
