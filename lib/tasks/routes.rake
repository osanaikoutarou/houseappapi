# http://kzy52.com/entry/2014/11/07/084023

# api.rb内のroutesを表示するためのタスク
# rake api:routes

namespace :api do
  desc 'API Routes'
  task routes: :environment do
    API.routes.each do |api|
      method = api.route_method.ljust(10)
      path = api.route_path.gsub(':version', api.route_version)
      puts "     #{method} #{path}"
    end
  end
end