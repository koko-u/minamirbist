def run_spec(file)
  unless File.exist?(file)
    puts "#{file} does not exist"
    return
  end

  puts "Running #{file}"
  system "bundle exec rspec #{file}"
  puts
end

watch("spec/.*/*_spec\.rb") do |match|
  run_spec match[0]
end

watch("app/(.*/.*)\.rb") do |match|
  run_spec %{spec/#{match[1]}_spec.rb}
end

watch("app/(.*/.*\.erb)") do |match|
  run_spec %{spec/#{match[1]}_spec.rb}
end

watch("doc/.*/*\.dot") do |match|
  system "rake dot"
end

# spec/views/events/edit.html.erb_spec.rb
#  app/views/events/edit.html.erb
