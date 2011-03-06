# -*- coding: utf-8 -*-
namespace :gnome do 

  desc "rails s thin in gnome-terminal"
  task :server do
    sh %(gnome-terminal -t "rails s" -e "rails s thin" --window-with-profile="restarter" &)
  end

  desc "rake watchr in gnome-terminal"
  task :watchr do
    sh %(gnome-terminal -t "watchr" -e "rake watchr" --window-with-profile="restarter" &)
  end

  desc "spork in gnome-terminal"
  task :spork do
    sh %(gnome-terminal -t "spork" -e "spork" --window-with-profile="restarter" &)
  end
end

desc "setup gnome-terminal"
task :gnome => ['gnome:server', 'gnome:watchr', 'gnome:spork']
