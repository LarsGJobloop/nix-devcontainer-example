# Nix

Nix is functional language used for describing a graph, which gets consumed by other tooling to derive results.

Most commonly it's used to describe filesystems (development environments or operating systems) through `flake.nix`

## Files and Folders

- [/flake.nix](/flake.nix): The primary user facing configuration
- [/flake.lock](/flake.lock): A lockfile, which binds the `flake.nix` inputs to specific commit SHAs.
  This is what decide the concrete, exact, version of the various programs to use
- [/.direnv](/.direnv): A temporary folder storing