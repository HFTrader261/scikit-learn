#!/bin/bash

set -e

"${SHELL}" <(curl -Ls micro.mamba.pm/install.sh) < /dev/null
eval "$(${HOME}/.local/bin/micromamba shell hook --shell bash)"

micromamba env create -f build_tools/circle/doc_environment.yml -n sklearn-dev --yes
micromamba install pre-commit ipykernel -n sklearn-dev --yes

micromamba run -n sklearn-dev pre-commit install

# Install sklearn from current directory
micromamba run -n sklearn-dev pip install --no-build-isolation .

# Setup for interactive shells
echo 'eval "$(${HOME}/.local/bin/micromamba shell hook --shell bash)"' >> $HOME/.bashrc
echo "micromamba activate sklearn-dev" >> $HOME/.bashrc
