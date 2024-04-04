mkdir -p result
export ISO_PATH=$(nix --extra-experimental-features 'nix-command' --extra-experimental-features 'flakes' build .\#install-isoConfigurations.gunther --no-link --print-out-paths -L)
export ISO_NAME=$(nix --extra-experimental-features 'nix-command' --extra-experimental-features 'flakes' eval .\#install-isoConfigurations.gunther.isoName --raw)

cp -rv "$ISO_PATH/iso/$ISO_NAME" "result/$ISO_NAME"

