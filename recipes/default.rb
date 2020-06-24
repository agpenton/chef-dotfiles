#
# Cookbook:: dotfiles
# Recipe:: default
#
# The MIT License (MIT)
#
# Copyright:: 2020, Asdrubal Gonzalez Penton
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
# THE SOFTWARE.
userhome = node['dotfiles']['homeuser']
account = default['dotfiles']['account']
plug = %w(aws.plugin.zsh django.plugin.zsh vagrant-prompt.plugin.zsh virtualenv.plugin.zsh ansible.plugin.zsh)
libs = %w(git.zsh theme-and-appearance.zsh)


directory "#{userhome}/.zsh" do
  owner "#{account}"
  group 'staff'
  action :create
end
directory "#{userhome}/.zsh/plugins" do
  owner "#{account}"
  group 'staff'
  action :create
end
directory "#{userhome}/.zsh/libs" do
  owner "#{account}"
  group 'staff'
  action :create
end

cookbook_file "#{userhome}/.aliases" do
  source 'aliases'
  owner "#{account}"
  group 'staff'
  mode '0755'
  action :create
end

path = ''
plug.each |p|
  path += "#{homeuser}/.zsh/plugins/#{p}"
  cookbook_file File.join(path) do
    source p
    owner "#{account}"
    group 'staff'
    mode '0755'
    action :create
  end
libs.each |l|
  path += "#{homeuser}/.zsh/libs/#{l}"
  cookbook_file File.join(path) do
    source l
    owner "#{account}"
    group 'staff'
    mode '0755'
    action :create
  end
# %w(git.zsh theme-and-appearance.zsh).each do |l|
#   cookbook_file "#{userhome}/.zsh/libs/"l do
#     source l
#     owner "#{account}"
#     group 'staff'
#     mode '0755'
#     action :create
#   end
# end


template "#{userhome}/.zshrc" do
  source 'zshrc.erb'
  mode '0440'
  owner "#{account}"
  group 'staff'
  variables(
    plugins: node['dotfiles']['plugins'],
    homeuser: node['dotfiles']['homeuser']
  )
end

execute 'source ~/.zshrc'
