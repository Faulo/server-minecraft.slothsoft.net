# AGENTS.md

Shared instructions for coding agents. Project-specific information is kept in [README.md](README.md), read it before non-trivial changes.

## Farah Module

This project is a farah module. Its assets lie in `assets`.

## PHP

### Environment and tools

Agents run directly on the host, not inside a Docker container. Commands,
paths, and tools therefore use the host environment unless explicitly run
through DDEV.

This is a DDEV project. The default DDEV `web` container defines the package's
development runtime. `PHP_VERSION` in `.env` is authoritative.

All package code must be syntactically valid on the PHP version declared by
`PHP_VERSION`, runnable in DDEV, and compatible with every PHP version
supported by CI. Do not rely on syntax, extensions, binaries, or platform
features available only on the host.

Host PHP may be used for ad hoc code execution and supporting work. Successful
host-side execution does not validate package compatibility; use DDEV for
validation that depends on the package runtime.

When executing ad hoc PHP code from the shell, do not use inline snippets such
as `php -r`, especially under PowerShell. Write code to a temporary `.php` file
and execute that file with `php`. Use project temp-file helpers inside PHP code;
remove shell-created probe files after use when appropriate.

Run all Composer commands through DDEV with `ddev composer ...`. Do not run
Composer directly on the host. Do not install persistent host dependencies.
Use `npx` for one-off Node.js tools; do not run `npm install` on the host.

### PHPUnit

The PHPUnit config is `phpunit.xml`. Run all PHPUnit invocations, including
filtered and targeted runs, in DDEV's default `web` container:

```bash
ddev exec vendor/bin/phpunit
```

Never run PHPUnit on the host. Start DDEV first when necessary. If an optional
extension or platform feature is unavailable in DDEV, report which validation
could not run and why. Treat skipped tests as intentional unless the task
concerns test skipping.

Use `@runInSeparateProcess` for tests of APIs with global or static process
state. When manually changing a test marked `@todo auto-generated`, remove the
marker so the generator no longer treats it as disposable. Files in
`test-files/` are canonical fixtures, not disposable output.

Tests may create temporary files through `temp_file`, `temp_dir`, or
`Slothsoft\Core\IO\FileInfoFactory::createTempFile`; manual cleanup is not
required for files managed by these helpers.

### MCP validation

When an IDE MCP server is available, use it after editing code to review
changes and retrieve inspections for touched files. Fix relevant in-scope
findings and report remaining ones. When a CI MCP server is available, use it
to validate the exact SHA of every pushed agent-authored
commit. An authorized push normally starts CI; do not trigger another build
unless needed for diagnosis. Investigate relevant failures and report the job,
commit SHA, and result. If changes are not pushed, report CI validation as
pending. Do not push or trigger jobs without authorization.

### Documentation and style

The PHPDoc config is `phpdoc.xml`. Generate documentation in DDEV with
`ddev exec vendor/bin/phpdoc`. `.editorconfig` is in effect.
