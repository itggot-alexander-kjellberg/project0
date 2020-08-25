require_relative 'dbhandler'

class Student < Dbhandler
    attr_reader :id, :name, :char, :stud_class

    def initialize(id, name, char, stud_class)
        @id = id
        @name = name
        @db = Dbhandler.new
        @char = char
        @stud_class = stud_class
    end

    def self.get(id, db)
        if id == :all
            arr = db.execute('SELECT * FROM students')
        else
            arr = db.execute('SELECT * FROM students WHERE id = ?', id)
        end

        return Dbhandler.orienter(:students, arr)
    end
    
    def self.search(name, db)
        arr = db.execute('SELECT * FROM students WHERE name LIKE ?', "%#{name}%")

        return Dbhandler.orienter(:students, arr)
    end

    def self.json_creator(arr)
        answer = []

        arr.each do |x|
            student = Hash.new
            student[:name] = x.name
            student[:id] = x.id
            student[:char] = x.char
            student[:stud_class] = x.stud_class

            answer << student
        end

        return answer.to_json
    end

    def create(db)
        class_id = db.execute('SELECT id FROM classes WHERE name = ?', @stud_class).first['id']

        db.execute('INSERT INTO students (name,stud_class) VALUES(?,?)', @name, class_id)
        id = db.execute('SELECT last_insert_rowid() FROM students;').first['last_insert_rowid()']

        @char.each do |x|
            db.execute('INSERT INTO traits (name, student_id) VALUES(?,?)', x, id)
        end

        return id
    end

    def edit

    end

    def self.student_class(id, db)
        if id != 'all'
            students = db.execute('SELECT students.* FROM students INNER JOIN classes ON classes.id = students.stud_class WHERE classes.name = ?', id)
        else
            students = db.execute('SELECT * FROM students')
        end
        return Dbhandler.orienter(:students, students)
    end

    def self.classes(db)
        return db.execute('SELECT DISTINCT stud_class FROM students;')
    end

    def self.checkUserImg(id)
        return File.exist?("public/img/students/#{id}.jpg")
    end

    def self.update(params, db)
        id = params[:id]
        name = params[:name]
        char = []
        
        params.each do |key, value|
            if key != 'action' && key != 'class'
                char << value
            end
        end
    
        traits = char.drop(1)
        traits.pop()

        db.execute('DELETE FROM traits WHERE student_id = ?', id)

        traits.each do |x|
            db.execute('INSERT INTO traits (name, student_id) VALUES(?,?)', x, id)
        end 
    end

    def self.destroy(id, db)
        db.execute('DELETE FROM students WHERE id = ?', id)
        db.execute('DELETE FROM traits WHERE student_id = ?', id)
    end
end
