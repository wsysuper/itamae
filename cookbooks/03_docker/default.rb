# validate the config file
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

# add dependant packages
node.docker.dependencies.each do |p|
  package p
end

# add docker-ce repo
execute "yum-config-manager --add-repo #{node.docker.repo}" do
  not_if "yum repolist | grep docker-ce"
end

# add docker-ce package
package "docker-ce"

# enable/start docker service
service "docker" do
  action [:enable, :start]
end

# install docker-compose
execute "install docker-compose" do
  command "curl -sL #{node.docker.compose.url}#{node.docker.compose.version}/docker-compose-`uname -s`-`uname -m` -o #{node.docker.compose.path}>/dev/null"
  not_if "#{node.docker.compose.path} -v | grep #{node.docker.compose.version}"
end

# make docker-compose executable
file node.docker.compose.path do
  action :nothing
  mode "755"
  subscribes :create, "execute[install docker-compose]"
end
