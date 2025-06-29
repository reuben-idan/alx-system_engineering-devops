#!/usr/bin/env puppet

# Puppet manifest to configure SSH client configuration
# This manifest configures SSH to use private key authentication and disable password auth

# Ensure the SSH config directory exists
file { '/etc/ssh/ssh_config':
  ensure => present,
  owner  => 'root',
  group  => 'root',
  mode   => '0644',
}

# Configure SSH to use the private key ~/.ssh/school
file_line { 'Declare identity file':
  ensure => present,
  path   => '/etc/ssh/ssh_config',
  line   => '    IdentityFile ~/.ssh/school',
  match  => '^#?    IdentityFile',
}

# Configure SSH to refuse password authentication
file_line { 'Turn off passwd auth':
  ensure => present,
  path   => '/etc/ssh/ssh_config',
  line   => '    PasswordAuthentication no',
  match  => '^#?    PasswordAuthentication',
} 