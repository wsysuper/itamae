node.validate! do
  {
    groups_to_add: optional(array_of(string)),
    users_to_delete: optional(array_of(string)),
    users_to_add: array_of({
      name: string,
      groups: optional(array_of(string)),
      authorized_keys: optional(array_of(string)),
    }),
    packages: array_of(string),
    docker: {
      repo: string,
      dependencies: array_of(string),
    },
  }
end

include_recipe "cookbooks/00_users"
include_recipe "cookbooks/01_packages"
include_recipe "cookbooks/02_misc"
include_recipe "cookbooks/03_docker"
include_recipe "cookbooks/04_python"
include_recipe "cookbooks/05_nginx"
