1)
In your terminal:

mkdir downloads-organizer-microtool
cd downloads-organizer-microtool
git init

2)
Create the .kiro directory and config: mkdir .kiro

3)
Create file: .kiro/config.json

{
  "projectName": "downloads-organizer-microtool",
  "description": "A Python micro-tool that automatically organizes and optionally renames files in the Downloads folder.",
  "toolsUsed": ["Python", "Kiro"],
  "challenge": "AI for Bharat - Kiro Week 1 Micro-Tools"
}

4)
Create the main script

Create folder:
mkdir src

5)
Create file: src/organizer.py

import os
import shutil
from datetime import datetime
from pathlib import Path
import argparse

# Map file extensions to groups
FILE_GROUPS = {
    "Images": [".png", ".jpg", ".jpeg", ".gif", ".bmp", ".webp"],
    "PDFs": [".pdf"],
    "Documents": [".doc", ".docx", ".txt", ".md", ".rtf", ".odt"],
    "Spreadsheets": [".xls", ".xlsx", ".csv", ".ods"],
    "Archives": [".zip", ".rar", ".7z", ".tar", ".gz"],
    "Executables": [".exe", ".msi", ".dmg", ".AppImage", ".sh", ".bat"],
    "Others": []  # fallback group
}


def get_group_for_extension(ext: str) -> str:
    """
    Return the group name based on the file extension.
    If no match, return 'Others'.
    """
    ext = ext.lower()
    for group, exts in FILE_GROUPS.items():
        if ext in exts:
            return group
    return "Others"


def generate_new_name(file_path: Path, group: str) -> str:
    """
    Generate a new filename based on:
    - group (e.g. PDFs -> 'pdf')
    - file modification time
    - an index to avoid collisions

    Example:
      pdf_2025-12-07_13-45-12_01.pdf
    """
    timestamp = datetime.fromtimestamp(file_path.stat().st_mtime)
    base_prefix = group[:-1].lower() if group.endswith("s") else group.lower()
    date_str = timestamp.strftime("%Y-%m-%d_%H-%M-%S")
    ext = file_path.suffix.lower()

    index = 1
    while True:
        new_name = f"{base_prefix}_{date_str}_{index:02d}{ext}"
        if not (file_path.parent / new_name).exists():
            return new_name
        index += 1


def organize_downloads(downloads_dir: Path, dry_run: bool = True, rename: bool = True):
    """
    Organize files in the given downloads_dir into subfolders under 'Organized/'.

    - If dry_run is True: only print what would be done.
    - If rename is True: files are renamed to a clean pattern.
    """
    if not downloads_dir.exists() or not downloads_dir.is_dir():
        raise ValueError(f"{downloads_dir} is not a valid directory")

    organized_root = downloads_dir / "Organized"
    actions = []

    for item in downloads_dir.iterdir():
        # Skip directories (including Organized itself)
        if item.is_dir():
            if item.name == "Organized":
                continue
            # For now, we ignore subdirectories
            continue

        group = get_group_for_extension(item.suffix)
        target_dir = organized_root / group
        target_dir.mkdir(parents=True, exist_ok=True)

        if rename:
            new_name = generate_new_name(item, group)
        else:
            new_name = item.name

        target_path = target_dir / new_name
        actions.append((item, target_path))

    # Execute or simulate actions
    for src, dst in actions:
        if dry_run:
            print(f"[DRY RUN] Would move: {src} -> {dst}")
        else:
            print(f"Moving: {src} -> {dst}")
            shutil.move(str(src), str(dst))

    print(f"\nTotal files processed: {len(actions)}")
    if dry_run:
        print("Dry run complete. Re-run with --apply to perform changes.")


def parse_args():
    parser = argparse.ArgumentParser(
        description="Automatically organize your Downloads folder into subfolders by file type."
    )
    parser.add_argument(
        "--downloads-dir",
        type=str,
        default=str(Path.home() / "Downloads"),
        help="Path to the Downloads directory (default: ~/Downloads)",
    )
    parser.add_argument(
        "--apply",
        action="store_true",
        help="Actually move/rename files (otherwise, dry-run only).",
    )
    parser.add_argument(
        "--no-rename",
        action="store_true",
        help="Do not rename files, only move them into grouped folders.",
    )
    return parser.parse_args()


def main():
    args = parse_args()
    downloads_dir = Path(args.downloads_dir).expanduser().resolve()
    dry_run = not args.apply
    rename = not args.no_rename

    print(f"Using Downloads directory: {downloads_dir}")
    print(f"Dry run: {dry_run}")
    print(f"Renaming enabled: {rename}")
    print("-" * 60)

    organize_downloads(downloads_dir, dry_run=dry_run, rename=rename)


if __name__ == "__main__":
    main()

6)
Add requirements.txt

We’re using only Python standard library, so you can either leave it empty or specify a version note.

Create: requirements.txt

# Standard library only. Requires Python 3.8+.

7)
Add .gitignore

Create: .gitignore

# Python
__pycache__/
*.pyc
*.pyo
*.pyd
.env
venv/
.env/
.venv/

# OS
.DS_Store
Thumbs.db

# DO NOT ignore .kiro
# .kiro/

8)
Create: LICENSE

MIT License

Copyright (c) 2025 <Your Name>

Permission is hereby granted, free of charge, to any person obtaining a copy
...
