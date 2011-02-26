desc "make png files from dot files"
task :dot do
  Dir.glob(Rails.root.to_s + "/doc/**/*.dot") do |in_file|
    sh %(dot -Tpng -o #{in_file.sub(/\.dot$/, ".png")} #{in_file})
  end
end
