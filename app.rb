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

    post '/student_add' do
        char = []
        
        params.each do |key, value|
            char << value
        end

        traits = char.drop(1)
        student = Student.new(nil, params[:name], traits)
        student.create(@db)

        redirect back
    end

    post '/student_remove' do
        p params[:studentId]
    end

    post '/search_trait/:trait' do
        trait = params[:trait]
        
        return Trait.search(trait)

    end
end