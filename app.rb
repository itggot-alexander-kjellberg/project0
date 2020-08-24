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

    # Bild-koden (i dess nuvarande stadie) måste köras innan allt annat, samt måste tas bort 
    post '/student/:action' do
        p "####################", params[:name]
        p params[:file]
        
        if params[:file] != nil
            tmpdir = params["file"]["tempfile"]
            redirect_folder = "public/img/students"
            file_type = params["file"]["type"]
    
            params.delete(:file)
        end
        
        
        char = []
        
        params.each do |key, value|
            char << value
        end
        
        traits = char.drop(1)
        student = Student.new(nil, params[:name], traits)
        id = student.create(@db)

        if tmpdir != nil
            FileUtils.cp(tmpdir, "#{redirect_folder}/#{id}.jpg")
        end

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

        return answer.to_json
    end

    post '/student_trait_generator/:id' do
        answer = Trait.get(params[:id], @db)
        return answer.to_json
    end
end