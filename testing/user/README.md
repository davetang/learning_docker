# README

The [USER](https://docs.docker.com/engine/reference/builder/#user) instruction
sets the user name or (UID) and optionally the user group (or GID) to use as
the default user and group for the remainder of the current stage. The
specified user is used for `RUN` instructions and at runtime, runs the relevant
`ENTRYPOINT` and `CMD` commands.
