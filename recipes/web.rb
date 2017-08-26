#
# Cookbook:: lamp
# Recipe:: web
#
# Copyright:: 2017,  Krishna Vangala
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.

# We Create a document root directory
# Create the document root directory.
directory node['lamp']['web']['document_root'] do
    recursive true
  end
  
# Add the site configuration.
httpd_config 'default' do
    source 'default.conf.erb'
end
  
  # Install Apache and start the service.
httpd_service 'default' do
    mpm 'prefork'
    action [:create, :start]
    subscribes :restart, 'httpd_config[default]'
end