require 'json'
require_relative 'models/dbhandler'
require_relative 'models/students'
require_relative 'models/traits'
require 'tmpdir'

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

        #lite för bilden?
        # bildFil = params[:studentImage]
        # p bildFil

        # temp_route = params["file"]["tempfile"]
        # to_folder = "public/filesystem/#{Time.new.year}/#{Time.new.month}/#{Time.new.day}/"
        # FileUtils.mkdir_p(to_folder)
        # FileUtils.cp(temp_route, "#{to_folder}/#{params['file']['filename']}")

        redirect back
    end

    post '/student_remove' do
        idToRemove = params[:studentId]
        Dbhandler.removeStudent(idToRemove)
        redirect back
    end

    post '/search_trait/:trait' do

        trait = params[:trait]
        
        answer = Trait.search(trait, @db)

        p answer
        return answer.to_json
    end

    post '/student_trait_generator/:id' do
        answer = Trait.get(params[:id], @db)
        return answer.to_json
    end
end