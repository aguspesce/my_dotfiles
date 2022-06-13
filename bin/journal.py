"""
Script to manage a journal
"""
import datetime
import subprocess
from pathlib import Path

path_docs = Path.home() / "Documentos"
path_journal = path_docs / "journal"
# Create the journal directory
if not path_journal.exists():
    path_journal.mkdir()

# Create month directory
path_month = path_journal / "{}".format(datetime.date.today().month)
if not path_month.exists():
    path_month.mkdir()


def _open_nvim(*fnames):
    """
    Open the files in neovim.
    """
    # -O opens multiple files with vertical splits
    args = ["nvim", "-O"]
    args.extend(fnames)
    subprocess.run(args, check=True)


def _new_journal():
    """
    Create a new journal entry from the template.
    """
    today = datetime.date.today()
    weekday = today.weekday()  # Monday is 0
    week = {
        name: today.replace(day=today.day - weekday + i).strftime("%a | %d %b")
        for i, name in enumerate(["mon", "tue", "wed", "thu", "fri"])
    }
    journal = JOURNAL_TEMPLATE.format(
        weekof=today.replace(day=today.day - weekday).isoformat(),
        **week,
    )
    return journal


JOURNAL_TEMPLATE = """
# Week of {weekof}
## Reminders
### {mon}
### {tue}
### {wed}
### {the}
### {fri}
---
## Notes

---
### Brain bump

---
> **Fill out on Monday and Friday.** Reflect on your overall feelings about
> your week, what you accomplished, the people who helped you the most, and
> also the people that you helped. Take your time filling these out.
>
> **Instructions:**
> - (x) Past event
> - ( ) Upcoming event
> - [ ] Incomplete task
> - [x] Completed task
---
""".strip()

today = datetime.date.today()
weekday = today.weekday()  # Monday is 0
monday = today.replace(day=today.day - weekday)
weekof = monday.isoformat()

# Path to the week file
fname = path_month / f"{weekof}.md"
# Create the week file if it doesn't exist
if not fname.exists():
    journal = _new_journal()
    fname.write_text(journal.format(weekof=weekof))

# Open the file
_open_nvim(fname)
