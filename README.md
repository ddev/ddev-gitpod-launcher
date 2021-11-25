# ddev-gitpod-launcher
Launch and develop any web project in gitpod using ddev.

1. Get the https URL of the repository you want to work with
2. Know the branch name
3. (Optional) Provide database and user-generated files dumps in another artifacts repository (most likely private)
   * In that repository, check in `db.sql.gz` and `files.tgz` and push it. This only needs to be updated when you need to update it. 
   * For future use, you may want to implement a `ddev pull` integration, for example for Acquia or Pantheon or Platform.sh or any other of the example [providers](https://github.com/drud/ddev/tree/master/pkg/ddevapp/dotddev_assets/providers) (see [docs](https://ddev.readthedocs.io/en/latest/users/providers/provider-introduction/)). The git technique is used here because you may not have any other initial way to get database and files into gitpod until you set something up.

Go to [DDEV gitpod launcher](https://drud.github.io/ddev-gitpod-launcher/) to launch any website project and edit and develop it in gitpod.
