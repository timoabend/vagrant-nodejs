Exec { path => '/usr/bin:/bin:/usr/sbin:/sbin' }

class update {
        schedule { 'maintenance':
                  range  => "2 - 4",
                  period => daily,
                  repeat => 1,
        }

        exec { "upgrade_packages":
                command => "apt-get upgrade -q=2 -y",
                group => "root",
                user => "root",
                schedule => 'maintenance',
                onlyif => ["apt-get update"]
        }
}

node default {
        include update
}

group { "puppet":
  ensure => "present",
}

File { owner => 0, group => 0, mode => 0644 }

file { '/etc/motd':
  content => "Virtual Machine for Node.js + MongoDB + Nginx\n---------------------------------------------\n"
}

# Ensure APT is up-to-date
exec { "apt-update":
    command => "/usr/bin/apt-get update"
}

exec { "apt-update_nodejs":
    command => "/usr/bin/apt-get update",
	require => Exec["add-apt-repository_nodejs"]
}

Exec["apt-update"] -> Package <| |>

# APT-Packages
package { "npm":
	ensure => purged
}

package { "python-software-properties":
	ensure => latest,
	before => Exec["add-apt-repository_nodejs"]
}

exec { "add-apt-repository_nodejs":
	command => "add-apt-repository -y ppa:chris-lea/node.js"
}

package { "nodejs":
	ensure => latest,
	require => Exec["apt-update_nodejs"]
}

package { "nginx":
	ensure => latest
}

package { "mongodb":
	ensure => latest
}

package { "git":
	ensure => latest
}

package { "nmap":
	ensure => latest
}

exec { "npm_nodemon":
	command => "npm install -g nodemon",
	require => Package["npm"]
}

exec { "npm_expressjs":
	command => "npm install -g express",
	require => Package["npm"]
}