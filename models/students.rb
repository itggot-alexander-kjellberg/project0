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
        db.execute('INSERT INTO students (name) VALUES(?)', @name)
        id = db.execute('SELECT last_insert_rowid() FROM students;').first['last_insert_rowid()']

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
    end

    def self.student_class(id, db)
        students = db.execute('SELECT * FROM students WHERE class = ?', id)
        return Dbhandler.orienter(:students, students)
    end
end
