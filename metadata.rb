maintainer       "Opscode, Inc."
maintainer_email "cookbooks@opscode.com"
license          "Apache 2.0"
description      "Installs libboost"
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          "0.2"
name             "boost"
provides         "boost"
recipe           "boost", "Installs libboost-dev"

recommends       "build-essential"

supports "ubuntu"
supports "debian"
supports "centos"
supports "amazon"
supports "scientific"
supports "fedora"
