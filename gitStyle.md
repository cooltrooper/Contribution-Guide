# Git Style

Our recommended practices for using git

## Contributing to plugins

### As an external user

Please fork the repo, make your changes using the [guidelines for internal user](gitStyle.md#as-an-internal-user) in and apply for a pull request.

### As an internal user

Please follow the styles outlined below:

- [Github Flow](https://guides.github.com/introduction/flow/)
- [Conventional Commits](https://www.conventionalcommits.org/en/v1.0.0/)
- [Semantic Versioning](https://semver.org/)

To make managing tags and releases easier use of [Change](https://github.com/adamtabrams/change) is recommended.

## Workflow Details

Before beginning ensure that your local git is up to date by pulling from the remote, and merging as required.

For significant changes or features please fork and develop along side the main branch, see Github Flow for details. This allows bugfixes to be implemented on the main branch without disrupting future versions.

Break your changes into small parts, each with their own commits. This allows for easy following of code changes and building an accompanying changelog. For example one commit to fix a typo, another to change the behaviour of a button.

After each change make a conventional commit, using the VSCode plugin will help with this.

>It is recommended you push your changes to the remote regularly.

When the changes are tested use the `change` tool to create a changelog. Review the file and add any required amendments. This stage will also show you the appropriate version number based on semantic versioning.

!> Update your plugin file version number with the one `change` generates.

Commit the plugin file with updated version number and changelog.

Push the commit to the remote and run `change tag`. This will tag the latest commit with the correct version number, and sync the tag to the remote, in the case of github this will also create a release.
