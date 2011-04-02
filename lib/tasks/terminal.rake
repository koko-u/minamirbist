# -*- coding: utf-8 -*-
namespace :terminal do 

  desc "rails s thin in rxvt"
  task :server do
    sh %(rxvt +vb -sr -sl 1000 -title "rails s" -e rails s thin &)
  end

  desc "rake watchr in rxvt"
  task :watchr do
    sh %(rxvt +vb -sr -sl 1000 -title "watchr" -e rake watchr &)
  end

  desc "spork in rxvt"
  task :spork do
    sh %(rxvt +vb -sr -sl 1000 -title "spork" -e bundle exec spork &)
  end
end

desc "setup rxvt terminal"
task :terminal => ['terminal:server', 'terminal:watchr', 'terminal:spork']
