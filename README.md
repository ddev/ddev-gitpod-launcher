# ddev-gitpod-launcher (archived)

**Gitpod Classic has been deprecated and will be removed in April, 2025, so this repository and launcher will no longer be maintained**

Launch and develop any web project in gitpod using ddev.

1. Get the https URL of the repository you want to work with.
2. (Optional) Provide database and user-generated files dumps in a (probably private) repository named `<repo>-artifacts`. For example. if you have a repository named `https://github.com/ddev/d10simple` the private artifacts git repository will be at `https://github.com/ddev/d10simple-artifacts`.
   * In that repository, check in `db.sql.gz` and `files.tgz` and push it. This only needs to be updated when you need to update it.
   * For future use, you may want to implement a `ddev pull` integration, for example for Acquia or Pantheon or Platform.sh or any other of the example [providers](https://github.com/ddev/ddev/tree/master/pkg/ddevapp/dotddev_assets/providers) (see [docs](https://ddev.readthedocs.io/en/latest/users/providers/provider-introduction/)). The git technique is used here because you may not have any other initial way to get database and files into gitpod until you set something up.

Go to [DDEV gitpod launcher](https://ddev.github.io/ddev-gitpod-launcher/) to launch any website project and edit and develop it in gitpod.

* If the project has a composer.json, the launcher will do a `ddev composer install`
* If the project has a .ddev/config.yaml, it will be respected, otherwise a default will be auto-generated.

## Development

While developing this repo, the following tips may be helpful.

### Test a branch of this repo

1. Visit <https://ddev.github.io/ddev-gitpod-launcher/>.
2. Enter target repo.
3. Copy the "Link used by "Open in Gitpod" button:" URL
4. Replace `https://github.com/ddev/ddev-gitpod-launcher/` with the branch path Eg. `https://github.com/tyler36/ddev-gitpod-launcher/tree/wip-branch`

### Gitpod Validation

This technique involves spawning debug workspaces.

1. Visit <https://ddev.github.io/ddev-gitpod-launcher/>
2. Enter target repo.
3. Click "open in repo".
4. Make required changes.
5. In the terminal, type `gp validate`.

This will spawn a new Gitpod workspace based on the current workspace.

* All pre-builds, `init`, and `commands` are run in the new workspace as if were freshly created..
* Debugging output is shown in the original workspace.

To end the session, press <kbd>Ctrl</kbd>+<kbd>c</kbd>, or <kbd>Command</kbd>+<kbd>c</kbd>, in the original window. This will terminate the debug workspace and while maintaining the original workspace.
