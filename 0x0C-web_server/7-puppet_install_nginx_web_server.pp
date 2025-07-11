#!/usr/bin/env puppet

# Puppet manifest to install and configure nginx web server with 301 redirect

# Update package list
exec { 'apt-get update':
  command => '/usr/bin/apt-get update',
  path    => '/usr/bin:/usr/sbin:/bin:/sbin',
}

# Install nginx package
package { 'nginx':
  ensure => installed,
}

service { 'nginx':
  ensure     => running,
  enable     => true,
  hasrestart => true,
  hasstatus  => true,
}

file { '/var/www/html/index.html':
  ensure  => file,
  content => "Hello World!\n",
  require => Package['nginx'],
}

file { '/etc/nginx/sites-available/default':
  ensure  => file,
  content => template('nginx/default.erb'),
  require => Package['nginx'],
  notify  => Service['nginx'],
}

# Template content for /etc/nginx/sites-available/default
# (You will need to create a template file if running this in a real Puppet setup)
# For ALX, we can inline the config with a file resource if templates are not supported.

file { '/etc/nginx/sites-available/default':
  ensure  => file,
  content => @(END),
server {
    listen 80 default_server;
    listen [::]:80 default_server;

    root /var/www/html;
    index index.html index.htm;

    server_name _;

    location / {
        try_files $uri $uri/ =404;
    }

    location /redirect_me {
        return 301 https://www.youtube.com/watch?v=QH2-TGUlwu4;
    }
}
END
  require => Package['nginx'],
  notify  => Service['nginx'],
} 