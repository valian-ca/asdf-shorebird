# asdf-shorebird

[![Build](https://github.com/valian-ca/asdf-shorebird/actions/workflows/build.yml/badge.svg)](https://github.com/valian-ca/asdf-shorebird/actions/workflows/build.yml)
[![Lint](https://github.com/valian-ca/asdf-shorebird/actions/workflows/lint.yml/badge.svg)](https://github.com/valian-ca/asdf-shorebird/actions/workflows/lint.yml)

[shorebird](https://docs.shorebird.dev/) plugin for the [asdf version manager](https://asdf-vm.com).

## Contents

- [Dependencies](#dependencies)
- [Install](#install)
- [Contributing](#contributing)
- [License](#license)

## Dependencies

- `bash`, `curl`, `tar`, and [POSIX utilities](https://pubs.opengroup.org/onlinepubs/9699919799/idx/utilities.html).

## Install

Plugin:

```shell
asdf plugin add shorebird
# or
asdf plugin add shorebird https://github.com/johnmartel/asdf-shorebird.git
```

shorebird:

```shell
# Show all installable versions
asdf list-all shorebird

# Install specific version
asdf install shorebird latest

# Set a version globally (on your ~/.tool-versions file)
asdf global shorebird latest

# Now shorebird commands are available
shorebird --version
```

Check [asdf](https://github.com/asdf-vm/asdf) readme for more instructions on how to
install & manage versions.

## Contributing

Contributions of any kind welcome! See the [contributing guide](CONTRIBUTING.md).

[Thanks goes to these contributors](https://github.com/valian-ca/asdf-shorebird/graphs/contributors)!

## License

See [LICENSE](LICENSE) © [VALIAN](https://github.com/valian-ca/)
