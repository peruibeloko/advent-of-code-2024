# Tooling

## Crypto

This file is responsible for encrypting and decrypting the puzzle inputs commited in binary form. This is nice for keeping the puzzle inputs along with the solutions in a safe way (not plain text). It uses AES-256-GCM cryptography with a SHA-256 PBKDF2 key derived from a password.

Usage: `deno run --allow-read --allow-write crypto.ts <encrypt | decrypt> <password>`

## Setup

This is responsible for structuring the 25 different folders. For each folder it creates:

- Two source files (`Part1.hs` and `Part2.hs`)
- Two input files (`test.txt` and `input.txt`)

The source files are created using the following template:

```hs
module Day${day}.Part${part} where

solution :: String -> String
solution input =
  input
```

where `day` and `part` are injected during runtime.

Usage: `deno run --allow-write setup.ts`