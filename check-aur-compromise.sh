#!/usr/bin/env bash
set -euo pipefail

LIST_FILE=""
CHECK_LOG=1
SHOW_FOREIGN=0
SHOW_BUILTINS=0

load_builtin_list() {
  printf '%s' "$BUILTIN_LIST_GZ_B64" | base64 -d | gzip -dc
}

BUILTIN_LIST_GZ_B64='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'

usage() {
  cat <<'EOF'
Usage:
  check-aur-compromise.sh [--list FILE] [--no-log] [--show-foreign] [--show-builtins] [--help]

Description:
  Lists installed AUR packages and checks whether any of them appear in a
  compromised package list.

Options:
  --list FILE     Use an alternative package list file instead of the built-in list.
  --no-log        Do not search for evidence in pacman.log.
  --show-foreign  Show all detected foreign/AUR packages.
  --show-builtins Show the built-in list and exit.
  --help          Show this help message.

List file format:
  One package name per line.
  Empty lines and comments starting with '#' are ignored.

Built-in list:
  The script includes the large public package listing for the June 2026 AUR
  incident, extracted from the public note referenced by the aur-general
  discussion. Use --list to override it.

Exit status:
  0  No compromised package found, or empty list with no comparison.
  1  One or more compromised packages found.
  2  Usage error, missing dependency, or invalid file.
EOF
}

die() {
  printf 'Error: %s\n' "$*" >&2
  exit 2
}

while (($# > 0)); do
  case "$1" in
    --list)
      (($# >= 2)) || die "missing path after --list"
      LIST_FILE="$2"
      shift 2
      ;;
    --no-log)
      CHECK_LOG=0
      shift
      ;;
    --show-foreign)
      SHOW_FOREIGN=1
      shift
      ;;
    --show-builtins)
      SHOW_BUILTINS=1
      shift
      ;;
    --help|-h)
      usage
      exit 0
      ;;
    *)
      die "unknown option: $1"
      ;;
  esac
done

command -v pacman >/dev/null 2>&1 || die "pacman not found"

if ((SHOW_BUILTINS == 1)); then
  printf 'Built-in monitored compromised package list:\n'
  while IFS= read -r line || [[ -n "$line" ]]; do
    line="${line%%#*}"
    line="${line#"${line%%[![:space:]]*}"}"
    line="${line%"${line##*[![:space:]]}"}"
    [[ -n "$line" ]] || continue
    printf '  - %s\n' "$line"
  done <<< "$(load_builtin_list)"
  exit 0
fi

mapfile -t INSTALLED_FOREIGN < <(pacman -Qm 2>/dev/null || true)

declare -A COMPROMISED=()
if [[ -n "$LIST_FILE" ]]; then
  [[ -r "$LIST_FILE" ]] || die "cannot read list file: $LIST_FILE"
  LIST_SOURCE="$LIST_FILE"
  LIST_CONTENT="$(<"$LIST_FILE")"
else
  LIST_SOURCE="built-in list in script"
  LIST_CONTENT="$(load_builtin_list)"
fi

while IFS= read -r line || [[ -n "$line" ]]; do
  line="${line%%#*}"
  line="${line#"${line%%[![:space:]]*}"}"
  line="${line%"${line##*[![:space:]]}"}"
  [[ -n "$line" ]] || continue
  COMPROMISED["$line"]=1
done <<< "$LIST_CONTENT"

if ((${#INSTALLED_FOREIGN[@]} == 0)); then
  printf 'No installed AUR/foreign package was found by "pacman -Qm".\n'
  exit 0
fi

if ((SHOW_FOREIGN == 1)); then
  printf 'Installed AUR/foreign packages:\n'
  for entry in "${INSTALLED_FOREIGN[@]}"; do
    printf '  - %s\n' "$entry"
  done
  printf '\n'
fi

if ((${#COMPROMISED[@]} == 0)); then
  printf 'Warning: the compromised package list is empty: %s\n' "$LIST_SOURCE"
  printf 'Nothing was compared. Fill the file with one package name per line.\n'
  exit 0
fi

declare -a MATCHES=()
for entry in "${INSTALLED_FOREIGN[@]}"; do
  pkg="${entry%% *}"
  ver="${entry#* }"
  if [[ -n "${COMPROMISED[$pkg]:-}" ]]; then
    MATCHES+=("${pkg} ${ver}")
  fi
done

printf 'List source: %s\n' "$LIST_SOURCE"
printf 'Installed foreign packages: %d\n' "${#INSTALLED_FOREIGN[@]}"
printf 'Monitored compromised packages: %d\n' "${#COMPROMISED[@]}"

if ((${#MATCHES[@]} == 0)); then
  printf '\nNo installed package matched the compromised package list.\n'
  printf 'Warning: this is only reliable if the list in use is correct and up to date.\n'
  exit 0
fi

printf '\nPotentially compromised packages found:\n'
for entry in "${MATCHES[@]}"; do
  printf '  - %s\n' "$entry"
done

if ((CHECK_LOG == 1)); then
  for log_path in /var/log/pacman.log /var/log/pacman.log.*; do
    [[ -r "$log_path" ]] || continue
    for entry in "${MATCHES[@]}"; do
      pkg="${entry%% *}"
      if grep -Fq "$pkg" "$log_path"; then
        printf '  log: %s contains references to %s\n' "$log_path" "$pkg"
      fi
    done
  done
fi

printf '\nRecommendation: remove the listed packages, review your AUR helper PKGBUILD/cache, and rotate credentials if malicious code may have been executed.\n'
exit 1
