# DEVARK

**Author**: Chanwoo Lee (@ChanWoo25)

> The name of this project is inspired by the words "development" and "Noah's Ark.".
>
> In this age of information overload, we gonna aims for picking out what really matters as a developer. Along the way, I hope to learn a ton of value from the process.
>
>  The goal of this system is to enable the creation of educational, consistent, and unified code.

## How to install

```shell
# linux
./initialize.sh

# Windows (supports powershell 7)
pwsh ./initialize.ps1
```

## UV Guide

### lock and sync

- In default, locaking and syncing are *automatic* in uv.
- Before `uv run` (invoking the requested command) or `uv tree`.

#### How to control lock & sync

```shell
# to disable automatic locking, but raise an error if the lockfile is not up-to-date
uv run --locked ...
# to run without checkint up-to-date
uv run --frozen ...
# similary, without checking
uv run --no-sync ...
```

#### How to check the lockfile

- lockfile is outdated
  - 