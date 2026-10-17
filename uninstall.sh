```bash
#!/usr/bin/env bash
#
# Pontic Greek — fcitx5 input method uninstaller
# Removes the input method for the current user.
#

set -Eeuo pipefail

readonly M17N_DIR="${HOME}/.m17n.d"
readonly INPUT_METHOD_DIR="${XDG_DATA_HOME:-"${HOME}/.local/share"}/fcitx5/inputmethod"

readonly LAYOUT="${M17N_DIR}/pnt-greek.mim"
readonly CONFIG="${INPUT_METHOD_DIR}/m17n_pnt_greek.conf"

info() {
    printf '[INFO] %s\n       %s\n' "$1" "$2"
}

success() {
    printf '[ OK ] %s\n       %s\n' "$1" "$2"
}

warn() {
    printf '[WARN] %s\n       %s\n' "$1" "$2" >&2
}

remove_file() {
    local file="$1"
    local description_tr="$2"
    local description_el="$3"

    if [[ -f "$file" || -L "$file" ]]; then
        rm -- "$file"
        success "$description_tr" "$description_el"
    else
        info \
            "${description_tr} Zaten mevcut değil." \
            "${description_el} Δεν υπάρχει ήδη."
    fi
}

cleanup_directory() {
    local directory="$1"

    # Remove the directory only if it is empty.
    rmdir -- "$directory" 2>/dev/null || true
}

main() {
    printf '\nPontic Greek — fcitx5 Uninstaller\n'
    printf 'Απεγκατάσταση Pontic Greek για fcitx5\n\n'

    remove_file \
        "$LAYOUT" \
        "Klavye düzeni kaldırıldı." \
        "Η διάταξη πληκτρολογίου αφαιρέθηκε."

    remove_file \
        "$CONFIG" \
        "Giriş yöntemi yapılandırması kaldırıldı." \
        "Οι ρυθμίσεις της μεθόδου εισαγωγής αφαιρέθηκαν."

    cleanup_directory "$M17N_DIR"
    cleanup_directory "$INPUT_METHOD_DIR"

    printf '\n'

    success \
        "Kaldırma işlemi tamamlandı." \
        "Η απεγκατάσταση ολοκληρώθηκε."

    printf '\n'
    info \
        "Değişiklikleri uygulamak için fcitx5 -r komutunu çalıştırın." \
        "Για να εφαρμοστούν οι αλλαγές, εκτελέστε την εντολή fcitx5 -r."

    printf '\n'
}

main "$@"
```
