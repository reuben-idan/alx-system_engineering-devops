#!/usr/bin/env puppet

# Puppet manifest to add custom X-Served-By HTTP header to nginx

# Update package list
exec { 'apt-get update':
  command => '/usr/bin/apt-get update',
  path    => '/usr/bin:/usr/sbin:/bin:/sbin',
}

# Install nginx package
package { 'nginx':
  ensure  => 'installed',
  require => Exec['apt-get update'],
}

# Add custom header to nginx configuration
file_line { 'add X-Served-By header':
  path    => '/etc/nginx/sites-available/default',
  line    => '    add_header X-Served-By $hostname;',
  after   => 'server_name _;',
  require => Package['nginx'],
  notify  => Service['nginx'],
}

# Ensure nginx service is running
service { 'nginx':
  ensure  => 'running',
  enable  => true,
  require => Package['nginx'],
} 