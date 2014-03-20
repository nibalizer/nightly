class base {

  if $::osfamily == "RedHat" {

    package { "vim-minimal":
      ensure => latest,
    }

    package { "tree":
      ensure => latest,
    }

  }

  if $::osfamily == "Debian" {

    package { "vim":
      ensure => latest,
    }

  } 


}





