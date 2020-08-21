class Trait < Dbhandler

    attr_reader :name, :id

    def initialize(name, id)
        @name = name
        @db = Dbhandler.get
        @id = id
    end

    def self.search(trait_name)
        @db.execute('SELECT *  FROM traits INNER JOIN (SELECT * FROM students INNER JOIN student_trait_connection ON student_trait_connection.student_id = students.id) ON trait_id = traits.id WHERE traits.name = ?', trait_name)
    end

end