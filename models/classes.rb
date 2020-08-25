require_relative 'dbhandler'

class Classes < Dbhandler
    def initialize

    end

    def self.get(name, db)
        if name == :all
            return db.execute('SELECT * FROM classes')
        else
            return db.execute('SELECT * FROM classes WHERE name = ?', name)
        end
    end

    def self.destroy(name,db)
        class_id = db.execute('SELECT id FROM classes WHERE name = ?', name).first['id']
        db.execute('DELETE FROM students WHERE stud_class = ?', class_id)
        db.execute('DELETE FROM classes WHERE id = ?', class_id)
    end
end