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

    def self.json_creator(x)
        student = Hash.new
        student[:name] = x.name
        student[:id] = x.id
        student[:char] = x.char
        student[:stud_class] = x.stud_class
        return student
    end

    def create(db)
        class_id = db.execute('SELECT id FROM classes WHERE name = ?', @stud_class).first['id']

        db.execute('INSERT INTO students (name,stud_class) VALUES(?,?)', @name, class_id)
        id = db.execute('SELECT last_insert_rowid() FROM students;').first['last_insert_rowid()']

        p "##############", @char

        @char.each do |x|
            exist = db.execute("SELECT * FROM traits WHERE name LIKE ?", x)
            
            if(exist == [])
                db.execute("INSERT INTO traits (name) VALUES(?)", x)
                char_id = db.execute("SELECT last_insert_rowid() FROM traits;").first['last_insert_rowid()']
                db.execute("INSERT INTO student_trait_connection (trait_id, student_id) VALUES(?,?)", char_id, id)
            else
                db.execute("INSERT INTO student_trait_connection (trait_id, student_id) VALUES(?,?)", exist.first['id'], id)
            end
        end

        return id
    end

    def edit

    end

    def self.student_class(id, db)
        students = db.execute('SELECT students.* FROM students INNER JOIN classes ON classes.id = students.stud_class WHERE classes.name = ?', id)
        return Dbhandler.orienter(:students, students)
    end

    def self.classes(db)
        return db.execute('SELECT DISTINCT stud_class FROM students;')
    end

    def self.checkUserImg(id)
        return File.exist?("public/img/students/#{id}.jpg")
    end
end
