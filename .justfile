# vim: set syntax=just:
set dotenv-load := false


default:
    @just -lu


sdsa_date_override := ""
sdsa_archive_dir := "~/misc/sdsa-membership"


# Run spotipy random command
spotify-random:
    #!/usr/bin/env bash
    set -e
    . activate spotipy
    spotify-random


# Determine the most recent monday
_most-recent-monday override="":
    #!/usr/bin/env python3
    override = "{{ override }}"

    # Short-circuit if an override is provided
    if override:
        print(override)
        exit()

    import datetime
    today = datetime.date.today()
    weekday = today.weekday()
    # If today is a Monday, just return the date
    if weekday == 0:
        monday = today
    # Otherwise, use the weekday to determine the most recent Monday
    else:
        monday = today - datetime.timedelta(days=today.weekday())
    print(monday.isoformat())

# Unzip, archive, and import the latest SDSA roster data
sdsa-import:
    #!/usr/bin/env bash
    set -e
    . ~/.bashrc
    source_path=~/Downloads/seattle_membership_list
    unzip -o $source_path.zip -d ~/Downloads/
    target_path={{ sdsa_archive_dir }}/seattle_membership_list_$(just _most-recent-monday {{ sdsa_date_override }}).csv
    mv $source_path.csv $target_path
    . activate sdsa-member-importer
    cd ~/git/sdsa-member-importer
    which python
    DEBUG='' python sdsa_member_importer/main.py $target_path
    rm $source_path.zip

