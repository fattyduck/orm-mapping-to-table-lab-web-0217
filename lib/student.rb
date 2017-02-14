class Student

  # Remember, you can access your database connection anywhere in this class
  #  with DB[:conn]
  attr_accessor :name, :grade
  attr_reader :id

  def initialize(name, grade)
    @name = name
    @grade = grade
    @id = 1
  end

  def self.create_table
    sql = <<-SQL
    CREATE TABLE IF NOT EXISTS students(
      id INTEGER PRIMARY KEY,
      name TEXT,
      grade INTEGER
    );
    SQL
    DB[:conn].execute(sql)
  end

  def self.drop_table
    DB[:conn].execute("DROP TABLE IF EXISTS students")
  end

  def save
    sql = <<-SQL
      INSERT INTO students (id, name, grade)
      VALUES (?, ?, ?)
    SQL
    DB[:conn].execute(sql, @id, @name, @grade)
  end

  def self.create(name:, grade:)
    student = self.new(name, grade)
    student.save
    student
  end

end
