# Language Support

| Language | LSPs | Formatters | Linters |
|---|---|---|---|
| Bash | Bash Language Server | shfmt | ShellCheck via Bash Language Server (LSP) |
| Java | JDT LS | — | JDT LS (LSP) |
| Markdown | Marksman, Rumdl | Rumdl | Marksman (LSP), Rumdl (LSP) |
| Nix | nixd | nix-fmt | Deadnix (nvim-lint), nixd (LSP), Statix (nvim-lint) |
| Python | Basedpyright | Ruff | Basedpyright (LSP), Ruff (nvim-lint) |

JDT LS runs on JDK 21. Java 8, 11, 17, 21, and 25 are configured as project
runtimes, with Java 17 as the default. Java completion, signature help, all
parameter-name inlay hints, Fernflower class content, and Eclipse source
downloads are enabled. Import wildcard thresholds are 9999. Project roots are
discovered only from `.git`; Maven and Gradle files do not define roots.
