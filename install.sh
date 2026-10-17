```bash
#!/usr/bin/env bash
#
# Pontic Greek — fcitx5 input method installer
# Per-user installation; no root privileges required.
#

set -Eeuo pipefail

readonly ROOT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
readonly SRC_DIR="${ROOT_DIR}/src"

readonly M17N_DIR="${HOME}/.m17n.d"
readonly INPUT_METHOD_DIR="${XDG_DATA_HOME:-"${HOME}/.local/share"}/fcitx5/inputmethod"

readonly LAYOUT="${SRC_DIR}/pnt-greek.mim"
readonly CONFIG="${SRC_DIR}/m17n_pnt_greek.conf"

info() {
    printf '[INFO] %s\n       %s\n' "$1" "$2"
}

success() {
    printf '[ OK ] %s\n       %s\n' "$1" "$2"
}

warn() {
    printf '[WARN] %s\n       %s\n' "$1" "$2" >&2
}

die() {
    printf '[ERR ] %s\n       %s\n' "$1" "$2" >&2
    exit 1
}

check_files() {
    [[ -f "$LAYOUT" ]] ||
        die \
            "Klavye düzeni bulunamadı: $LAYOUT" \
            "Δε βρέθηκε η διάταξη πληκτρολογίου: $LAYOUT"

    [[ -f "$CONFIG" ]] ||
        die \
            "Yapılandırma dosyası bulunamadı: $CONFIG" \
            "Δε βρέθηκε το αρχείο ρυθμίσεων: $CONFIG"
}

check_m17n() {
    local path

    for path in \
        /usr/lib/fcitx5/m17n.so \
        /usr/lib64/fcitx5/m17n.so \
        /usr/lib/*/fcitx5/m17n.so
    do
        [[ -f "$path" ]] && return 0
    done

    warn \
        "fcitx5-m17n modülü bulunamadı." \
        "Δεν βρέθηκε η μονάδα fcitx5-m17n."

    printf '       Arch / Manjaro : sudo pacman -S fcitx5-m17n\n'
    printf '       Debian / Ubuntu: sudo apt install fcitx5-m17n\n'
    printf '       Fedora         : sudo dnf install fcitx5-m17n\n'
    printf '\n'

    warn \
        "Kuruluma devam ediliyor; modül olmadan giriş yöntemi çalışmayabilir." \
        "Η εγκατάσταση συνεχίζεται· χωρίς τη μονάδα, η μέθοδος εισαγωγής ενδέχεται να μη λειτουργεί."
}

install_files() {
    info \
        "Kurulum dizinleri hazırlanıyor..." \
        "Προετοιμασία των καταλόγων εγκατάστασης..."

    mkdir -p -- "$M17N_DIR" "$INPUT_METHOD_DIR"

    install -m 644 -- "$LAYOUT" \
        "${M17N_DIR}/pnt-greek.mim"

    install -m 644 -- "$CONFIG" \
        "${INPUT_METHOD_DIR}/m17n_pnt_greek.conf"

    success \
        "Klavye düzeni kuruldu." \
        "Η διάταξη πληκτρολογίου εγκαταστάθηκε."

    success \
        "Giriş yöntemi yapılandırması kuruldu." \
        "Οι ρυθμίσεις της μεθόδου εισαγωγής εγκαταστάθηκαν."
}

main() {
    printf '\nPontic Greek — fcitx5 Installer\n'
    printf 'Εγκαταστάτης Pontic Greek για fcitx5\n\n'

    check_files
    check_m17n
    install_files

    printf '\n'

    success \
        "Kurulum tamamlandı." \
        "Η εγκατάσταση ολοκληρώθηκε."

    printf '\n'
    printf 'Sonraki adımlar: / Επόμενα βήματα:\n'
    printf '  1. fcitx5 -r\n'
    printf '  2. fcitx5-configtool\n'
    printf '  3. Input Method → Add → Pontic Greek\n'
    printf '\n'
}

main "$@"
```
