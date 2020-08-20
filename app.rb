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
        students = Student.search(params[:name], @db)
        arr = []

        for student in students do
            arr << Student.json_creator(student)
        end

        return arr.to_json
    end
end

