require_relative 'dbhandler'

class Student < Dbhandler
    attr_reader :id, :name, :char

    def initialize(id, name, char)
        @id = id
        @name = name
        @db = Dbhandler.new
        @char = char
    end

    def self.get(id, db)
        if id == :all
            arr = db.execute('SELECT * FROM personer')
        else
            arr = db.execute('SELECT * FROM personer WHERE id = ?', id)
        end

        return Dbhandler.orienter(:students, arr)
    end
    
    def self.search(name, db)
        arr = db.execute('SELECT * FROM personer WHERE name LIKE ?', "%#{name}%")

        return Dbhandler.orienter(:students, arr)
    end

    def self.json_creator(x)
        student = Hash.new
        student[:name] = x.name
        student[:id] = x.id
        student[:char] = x.char

        return student
    end
end