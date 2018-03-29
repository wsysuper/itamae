node.validate! do
  {
    docker: {
      repo: string,
      dependencies: array_of(string),
      compose: {
        url: string,
        version: string,
        path: string,
      },
    },
  }
end

node.docker.dependencies.each do |p|
  package p
end

execute "yum-config-manager --add-repo #{node.docker.repo}" do
  not_if "yum repolist | grep docker-ce"
end

package "docker-ce"

service "docker" do
  action [:enable, :start]
end

file node.docker.compose.path do
  action :nothing
  mode "755"
  subscribes :create, "execute[curl -sL #{node.docker.compose.url}#{node.docker.compose.version}/docker-compose-`uname -s`-`uname -m` -o #{node.docker.compose.path}]"
end

execute "curl -sL #{node.docker.compose.url}#{node.docker.compose.version}/docker-compose-`uname -s`-`uname -m` -o #{node.docker.compose.path}" do
  user "root"
  not_if "#{node.docker.compose.path} -v | grep #{node.docker.compose.version}"
end
