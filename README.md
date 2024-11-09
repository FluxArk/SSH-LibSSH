[![Actions Status](https://github.com/raku-community-modules/SSH-LibSSH/actions/workflows/linux.yml/badge.svg)](https://github.com/raku-community-modules/SSH-LibSSH/actions) [![Actions Status](https://github.com/raku-community-modules/SSH-LibSSH/actions/workflows/macos.yml/badge.svg)](https://github.com/raku-community-modules/SSH-LibSSH/actions)

NAME
====

SSH::LibSSH - Asynchronous binding for libssh; client-only and limited functionality

SYNOPSIS
========

```raku
use SSH::LibSSH;
```

DESCRIPTION
===========

An asynchronous Raku binding to LibSSH. It only supports client operations, and even then only some of those. It implements:

  * Connecting to SSH servers, performing server authentication and client authentication (by default, using a running key agent or the current user's private key; you can also provide a private key file or a password)

  * Executing commands, sending stdin, reading stdout/stderr, and getting the exit code

  * Port forwarding

  * Reverse port forwarding

  * Single file SCP in either direction

See the `examples` directory for a set of examples to illustrate usage of this module.

All operations are asynchronous, and the interface to the module is expressed in terms of the Raku `Promise` and `Supply` types.

On Linux, install libssh with your package manager to use this module. On Windows, the installation of this module will download a pre-built libssh.dll, so just install the module and you're good to go.

Pull requests to add missing features, or better documentation, are welcome. Please file bug reports or feature requests using GitHub Issues.

AUTHOR
======

Jonathan Worthington

COPYRIGHT AND LICENSE
=====================

Copyright 2017 - 2024 Jonathan Worthington

Copyright 2024 Raku Community

This library is free software; you can redistribute it and/or modify it under the Artistic License 2.0.

