['kansuji', 'version'].each do |name|
  require File.expand_path "../kansuji/#{name}", __FILE__
end
