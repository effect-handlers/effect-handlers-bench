FROM nixos/nix

WORKDIR /WorkDir

RUN curl -o lexa-oopsla25.tar.gz -sL https://github.com/lexa-lang/lexa/archive/refs/tags/OOPSLA25.tar.gz
RUN tar xvf lexa-oopsla25.tar.gz
WORKDIR ./lexa-OOPSLA25

RUN nix --extra-experimental-features "nix-command flakes" --accept-flake-config develop .#userShell

RUN echo -e '#!/usr/bin/env bash\n\
set -e\n\
\n\
# Always run within the nix development environment\n\
if [ $# -eq 0 ]; then\n\
    # If no arguments provided, start interactive shell\n\
    nix --extra-experimental-features "nix-command flakes" --accept-flake-config develop .#userShell\n\
else\n\
    # Run the command within the nix development environment\n\
    nix --extra-experimental-features "nix-command flakes" --accept-flake-config develop .#userShell --command "$@"\n\
fi' > /entrypoint.sh
RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]