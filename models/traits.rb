require_relative 'dbhandler'

class Trait < Dbhandler

    attr_reader :name, :id

    def initialize(name, id)
        @name = name
        @db = Dbhandler.get
        @id = id
    end

    def self.get(student_id, db)
        answer = db.execute('SELECT traits.* FROM students INNER JOIN traits ON traits.student_id = students.id WHERE students.id = ?;', student_id)
        return answer.to_json
    end

    def self.search(trait_name, db)
        answer = db.execute('SELECT * FROM students INNER JOIN traits ON traits.id = students.id WHERE traits.name LIKE ?', "%#{trait_name}%")
        return answer.to_json
    end
end