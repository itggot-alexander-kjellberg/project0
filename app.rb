require 'json'
require_relative 'models/dbhandler'
require_relative 'models/students'
class Site < Sinatra::Base

    before do
        @db = Dbhandler.get
    end

    get '/' do
        @personer = Student.get(:all, @db)
        slim :index 
    end

    post '/search_name/:name' do
        names = Student.search(params[:name], @db)
        return names.to_json
    end
end

