# AUR Compromised Package Checker

Simple script to check whether any AUR package installed on your Arch Linux system appears in a public list of packages associated with the AUR compromise incident.

This project was designed for quick use, including by people with limited Arch Linux experience.

## What this script does

The script:

- lists installed `foreign` packages using `pacman -Qm`
- compares those packages against a built-in public package list
- shows whether any match was found
- tries to locate references to matched packages in `pacman.log`

## What this script does not do

This script does not prove by itself that your machine was infected.

It only compares installed package names against a public list of suspicious or compromised packages. If a match is found, you should investigate further.

## Requirements

To use the script, you need:

- Arch Linux or a derivative with `pacman`
- Bash
- `base64`
- `gzip`

## How to use

First, make the script executable if it is not already:

```bash
chmod +x check-aur-compromise.sh
```

Then run:

```bash
./check-aur-compromise.sh
```

### Show all installed AUR packages

```bash
./check-aur-compromise.sh --show-foreign
```

This command shows packages installed outside the official repositories, usually AUR packages or manually installed packages.

### Show the built-in package list

```bash
./check-aur-compromise.sh --show-builtins
```

This command shows every package name the script uses as its built-in reference list.

### Use a custom list

If you want to test another list, create a file with one package name per line and run:

```bash
./check-aur-compromise.sh --list my-list.txt
```

## How to interpret the result

### When no package is found

If you see something like:

```text
No installed package matched the compromised package list.
```

it means the script did not find any overlap between your installed AUR packages and the list used for the check.

### When one or more packages are found

If the script lists potentially compromised packages, it means package names installed on your system match names in the monitored list.

In that case, the recommended next steps are:

- review the package carefully
- check when it was installed
- inspect your AUR helper cache
- remove the package if there is a real suspicion
- rotate credentials if you believe malicious code may have been executed

## Example

```bash
./check-aur-compromise.sh --show-foreign
./check-aur-compromise.sh
```

## Source of the built-in package list

The built-in package list was created from the public package listing associated with the AUR incident and referenced by the Arch Linux community.

Sources used:

- Official Arch Linux incident notice: https://archlinux.org/news/active-aur-malicious-packages-incident/
- Public `aur-general` discussion thread: https://lists.archlinux.org/archives/list/aur-general@lists.archlinux.org/thread/FGXPCB3ZVCJIV7FX323SBAX2JHYB7ZS4/
- Public note containing the package list: https://md.archlinux.org/s/SxbqukK6IA

## Important

The public list used by this script should not be treated as final proof of compromise.

It is meant for initial triage only. Proper confirmation requires additional investigation.
