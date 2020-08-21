require_relative 'dbhandler'

class Trait < Dbhandler

    attr_reader :name, :id

    def initialize(name, id)
        @name = name
        @db = Dbhandler.get
        @id = id
    end

    def self.get(student_id, db)
        return db.execute('SELECT * FROM student_trait_connection INNER JOIN traits ON traits.id = student_trait_connection.trait_id WHERE student_id = ?', student_id)
    end

    def self.search(trait_name, db)
        answer = db.execute('SELECT *  FROM traits INNER JOIN (SELECT * FROM students INNER JOIN student_trait_connection ON student_trait_connection.student_id = students.id) ON trait_id = traits.id WHERE traits.name LIKE ?', "%#{trait_name}%")
        if answer == []
            return 'tyävrr'
        else
            return answer
        end
    end
end