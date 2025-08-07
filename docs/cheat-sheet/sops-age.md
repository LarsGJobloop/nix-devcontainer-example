# SOPS + Age

Two CLI tools used in tandem with each other.

## Age

Age is a modern, minimalistic, cryptographic tool. It's used for generating cryptographic keys, as well as for encryption and decryption.

## Generating new key-pairs

Used for creating asymetric cryptographic keys that is part of modern communication.

```sh
age-keygen > keys.txt
```

Example result:
```txt
# created: 2025-08-07T12:51:52+02:00
# public key: age1g53gta6qvz6ynw024s9p6f9nzl5ec75kk930kqcfyd3jfcg3ndxqyr5936
AGE-SECRET-KEY-165A2223YS2JTSPMGEG6GG4XKAX9TDANUDLELT8QY05FS6K2SSURQWPS8Y3
```

Store the private/secret part somewhere safe (where only you have access), and share the public part with anyone you want to send you safe messages.

## SOPS

SOPS is a higher level tool which is used to manage secrets in a repository.

**SOPS configuration file**:
Used to define which recipients to target when encrypting files, as well as which keys to use when decrypting
```yaml
creation_rules:
  # Infras secrets
  - path_regex: infrastructure/secrets.yaml
    key_groups:
      - age:
          - age1g53gta6qvz6ynw024s9p6f9nzl5ec75kk930kqcfyd3jfcg3ndxqyr5936
  # Developer secrets
  - path_regex: source/.env
    key_groups:
      - age:
          - age1ntf4h53ejzwuflm30gldt6lu7vw75y6mm7c897z4697l00fp03lq52vjnc
```

### Common commands

- Encrypt a file

  ```sh
  sops encrypt --in-place path/to/secret/.env
  ````

- Start a program with secrets loaded into the environment

  ```sh
  sops exec-env path/to/secret/.env "dotnet run"
  ```

- Edit a secret

  ```sh
  sops edit path/to/secret/.env
  ```

- Update who can decrypt the secret

  ```sh
  sops updatekeys path/to/secret/.env
  ```
