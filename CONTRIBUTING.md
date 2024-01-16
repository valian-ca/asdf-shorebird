# Contributing

Contributions are welcome!

1. Install tools:

   ```shell
   asdf plugin add shellcheck
   asdf plugin add shfmt
   asdf install
   ```

2. Make changes
3. Test

   ```shell
   asdf plugin test shorebird https://github.com/valian-ca/asdf-shorebird.git "shorebird --version"
   ```

4. Lint & format:

   ```shell
   ./scripts/format.bash
   ./scripts/lint.bash
   ```

5. Open PR

Tests are automatically run in GitHub Actions on push and PR.
