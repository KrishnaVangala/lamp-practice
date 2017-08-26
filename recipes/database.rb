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
passwords = data_bag_item('passwords','mysql')

# Configure the MYSQL client.
mysql_client 'default' do
    action :create
end

# Configure The MySql service.
mysql_service 'default' do
    initial_root_password passwords['root_password']
    action [:create, :start]
end