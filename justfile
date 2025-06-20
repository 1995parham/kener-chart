default:
    @just --list

# set up the dev environment with kind
dev cmd *flags:
    #!/usr/bin/env bash
    echo '{{ BOLD + YELLOW }}Development environment based on kind{{ NORMAL }}'
    set -eu
    set -o pipefail
    if [ {{ cmd }} = 'down' ]; then
      kind delete cluster -n kener
    elif [ {{ cmd }} = 'up' ]; then
      kind create cluster --config cluster.yaml
    else
      kind {{ cmd }} {{ flags }}
    fi

# deploy kener
[working-directory("charts/kener")]
kener:
    helm dep update
    helm upgrade --install kener .
