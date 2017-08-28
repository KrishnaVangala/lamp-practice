#
# Cookbook:: lamp
# Recipe:: database
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

# Load MySQL password from the Data bags
passwords = data_bag_item('passwords', 'mysql')

# Configure the MYSQL client.
mysql_client 'default' do
    action :create
end

# Configure The MySql service.
mysql_service 'default' do
    initial_root_password passwords['root_password']
    action [:create, :start]
end

# Install the Mysql2 Ruby gem
mysql2_chef_gem 'default' do
    action :install
end

# Connection to SQL

mysql_connection_info = {
    host: '127.0.0.1',
    username: 'root',
    password: passwords['root_password']
}

# create the database instance

mysql_database node['lamp']['database']['dbname'] do
    connection mysql_connection_info
    action :create
end

# add a DB user
mysql_database_user node['lamp']['database']['admin_username'] do
    connection mysql_connection_info
    password passwords['admin_password']
    database_name node['lamp']['database']['dbname']
    host '127.0.0.1'
    action [:create, :grant]
end
