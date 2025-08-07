# GitOps

In essence ensuring that all aspects of the project are codified and version controlled.

The contrasting solution is you navigating through 10s of different UIs, tweaking and setting values as you go along to get the project off the ground. That is imperative, error prone as well as increadibly hard to onboard new developer into.

## Golden Dream

Projects that can be reacreated, end-to-end, and deterministically using the following flow:

```sh
git clone <repo-url>
git chekout <commit-sha>

# Some single command for applying the config
make apply || npm run apply || tofu apply
```

No (very few) projects are here today, but it's whats being worked towards.
