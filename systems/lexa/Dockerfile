FROM nixos/nix

WORKDIR /WorkDir

RUN curl -o lexa-oopsla25.tar.gz -sL https://github.com/lexa-lang/lexa/archive/refs/tags/OOPSLA25.tar.gz
RUN tar xvf lexa-oopsla25.tar.gz
WORKDIR ./lexa-OOPSLA25

RUN nix --extra-experimental-features "nix-command flakes" build --accept-flake-config --no-link .#clang_18_preserve_none
RUN nix --extra-experimental-features "nix-command flakes" develop
RUN nix-env -iA nixpkgs.util-linux nixpkgs.time

RUN echo -e '#!/usr/bin/env bash\n\
nix --extra-experimental-features "nix-command flakes" --accept-flake-config develop' > /entrypoint.sh
RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]