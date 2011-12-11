class Solution
  TestCase = Struct.new :test, :expectation do
    def result(environment)
      result = environment.instance_eval &test
      expectation[result] ? :Pass : :Fail
    end
  end
  
  attr_accessor :name, :solution, :comment
  
  def initialize(name, solution, comment=nil)
    self.name     = name
    self.solution = solution.strip
    self.comment  = comment
  end
  
  def test_cases
    @test_cases ||= []
  end
  
  def test(&block)
    test_case = TestCase.new
    test_case.test = block
    test_cases << test_case
    self
  end
  
  def expect(&block)
    test_cases.last.expectation = block
    self
  end
  
  def to_s
    "#{name}: #{size} characters\n" <<
    "  #{solution}\n"               <<
    "  #{test_description}\n"       <<
    formatted_comment               <<
    "\n"
  end
  
  def formatted_comment
    return '' unless comment
    "\n  #{comment.strip}\n"
  end
  
  def test_description
    "#{test_cases.size} tests: #{test_results.join ', '}"
  end
  
  def test_results
    test_cases.map { |test_case| test_case.result fresh_environment }
  end
  
  def fresh_environment
    environment = Object.new
    environment.singleton_class.class_eval solution
    environment
  end
  
  def size
    solution.size
  end
end
