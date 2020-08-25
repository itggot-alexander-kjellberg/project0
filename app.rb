require 'json'
require_relative 'models/dbhandler'
require_relative 'models/students'
require_relative 'models/traits'
require_relative 'models/courses'
require 'tmpdir'

class Site < Sinatra::Base

    before do
        @db = Dbhandler.get
    end

    get '/' do
        @personer = Student.get(:all, @db)
        @classes = Course.get(:all, @db)
        slim :index 
    end

    post '/search_name/:name' do
        
        students = Student.search(params[:name], @db)
        return Student.json_creator(students)
    end

    # Bild-koden (i dess nuvarande stadie) måste köras innan allt annat, samt måste tas bort 
    post '/student/edit/:id' do

        Student.update(params, @db)
        redirect '/'
    end

    post '/student/remove' do
        idToRemove = params[:studentId]
        Student.destroy(idToRemove, @db)
        redirect back
    end

    post '/student/add' do

        if params[:file] != nil
            tmpdir = params["file"]["tempfile"]
            redirect_folder = "public/img/students"
            file_type = params["file"]["type"]
    
            params.delete(:file)
        end
        
        
        char = []
        
        params.each do |key, value|
            if key != 'action' && key != 'class'
                char << value
            end
        end
    
        traits = char.drop(1)
    
        student = Student.new(nil, params[:name], traits, params[:class])
        id = student.create(@db)
    
        if tmpdir != nil
            FileUtils.cp(tmpdir, "#{redirect_folder}/#{id}.jpg")
        end
    
        redirect back
    end

    post '/search_trait/:trait' do

        return Trait.search(params[:trait], @db)
    end

    post '/student_trait_generator/:id' do

        return Trait.get(params[:id], @db)
    end

    post '/class_change/:class' do
        students = Student.student_class(params[:class], @db)
        return Student.json_creator(students)
    end

    post '/course/new' do
        course = Course.new(params[:classname])
        course.create

        redirect back
    end

    post '/userimg/:id' do
        answer = Student.checkUserImg(params[:id])
        return answer.to_json
    end
    
    post '/course/destroy' do
        Course.destroy(params[:class], @db)
        redirect back
    end
end