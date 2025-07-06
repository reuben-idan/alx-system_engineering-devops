#!/usr/bin/env puppet

# Puppet manifest to install and configure nginx web server with 301 redirect

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

# Create the nginx site configuration
file { '/etc/nginx/sites-available/default':
  ensure  => 'present',
  content => 'server {
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
}',
  require => Package['nginx'],
  notify  => Service['nginx'],
}

# Enable the default site
file { '/etc/nginx/sites-enabled/default':
  ensure => 'link',
  target => '/etc/nginx/sites-available/default',
  require => File['/etc/nginx/sites-available/default'],
  notify  => Service['nginx'],
}

# Create the index.html file with "Hello World!"
file { '/var/www/html/index.html':
  ensure  => 'present',
  content => 'Hello World!',
  require => Package['nginx'],
  notify  => Service['nginx'],
}

# Ensure nginx service is running
service { 'nginx':
  ensure  => 'running',
  enable  => true,
  require => [Package['nginx'], File['/etc/nginx/sites-enabled/default']],
} 