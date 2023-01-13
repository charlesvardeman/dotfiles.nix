# dotfiles.nix

Experiments with nix for reproducible machine learning environments starting with "dotfiles" and [nix community home manager](https://github.com/nix-community/home-manager) to create usable workspaces.

Inspired by [fast.ai minimal dotfiles](https://github.com/fastai/dotfiles) that uses a [Bare Git Repository](https://www.atlassian.com/git/tutorials/dotfiles) to manage dotfiles in a root repository.

David Przybilla has written good blog post that motivates using nix for "[Reproducibility with Nix](https://blog.devgenius.io/reproducibility-with-nix-991ad466c92e)" that makes a case for using Nix in AI/Data Science/Data Engineering.

## Setup

Some minimal installation is necessary at the OS level to bootstrap Nix and home-manager. After this initial config, the nix homemanager configuration contained in this repository should be transparent.

### Install instructions for macOS.

Let's [install nix](https://nixos.org/manual/nix/stable/installation/installing-binary.html#macos-installation) (at the time of writing this is version 2.12.0

```bash
curl -L https://nixos.org/nix/install | sh
```

Create config directory

```bash
mkdir -p ~/.config/nix
```

Enable nix-command and flakes to bootstrap

```
cat <<EOF > ~/.config/nix/nix.conf
experimental-features = nix-command flakes
EOF
```

Install [home manager](https://github.com/nix-community/home-manager) from [standalone instructions](https://nix-community.github.io/home-manager/index.html#sec-install-standalone).

```bash
nix-channel --add https://github.com/nix-community/home-manager/archive/release-22.11.tar.gz home-manager
nix-channel --update
```

Not sure if updating the nix path is necessary on macOS, but followed instructions.

```bash
export NIX_PATH=$HOME/.nix-defexpr/channels:/nix/var/nix/profiles/per-user/root/channels${NIX_PATH:+:$NIX_PATH}
```

And finally the home manager install.

```bash
nix-shell '<home-manager>' -A install
```

### Install instructions for Linux (non-NixOS)

### Install instructions for Windows Subsystem for Linux (WSL)

## Home Manager Configuration

Clone this Github repository based off of [James Dotfiles](https://github.com/Omegaice/dotfiles) that is based off [Nix Home Manager](https://nix-community.github.io/home-manager/index.html). [MyNixOS](https://mynixos.com) provides more concise documentation for [programs available](https://mynixos.com/home-manager/options/programs) in home manager and [configuration options](https://mynixos.com/home-manager/options).

```bash
mkdir ~/.config/nixpkgs
git clone https://github.com/charlesvardeman/dotfiles.nix ~/.config/nixpkgs
~/.config/nixpkgs/update.sh
```

## Nix and Python

- [NixOS Python Wiki](https://nixos.wiki/wiki/Python)

## References

### Nix Resources

- [The Nix ecosystem DevOps Toolkit](https://nix.dev)
- [Setting up Nix on macOS from scratch (incl. dotfiles via home-manager and Nix flakes](https://youtu.be/1dzgVkgQ5mE)
  - [Sample dotfiles from this video](https://github.com/schickling/dotfiles)
- [Discourse Thread on macOS config](https://discourse.nixos.org/t/simple-workable-config-for-m1-macbook-pro-monterey-12-0-1-with-nix-flakes-nix-darwin-and-home-manager/16834)
- [Gist with example instructions](https://gist.github.com/jmatsushita/5c50ef14b4b96cb24ae5268dab613050)
- [Nix Configurations for macOS and Linux based on Flakes](https://github.com/malob/nixpkgs)
- [Declarative macOS Configuration Using nix-darwin and home-manager](https://xyno.space/post/nix-darwin-introduction)
- [nix-darwin](https://github.com/LnL7/nix-darwin)

### Motivation

- [Comparing Nix and Conda](https://discourse.nixos.org/t/comparing-nix-and-conda/11366/37)
- [A sack full of angry snakes: Taming your python dependencies with Nix](https://youtu.be/8ng4v1g5q7s)
- [Using Nix for Repeatable Python Environments | SciPy 2019 | Daniel Wheeler](https://youtu.be/USDbjmxEZ_I)
- [Beyond Python packagin with Nix](https://youtu.be/Vnq6ngcqJAg)
  - [Slides](https://datakurre.github.io/pyconpl19/slides.pdf)
