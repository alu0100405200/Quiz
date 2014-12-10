class Question
    attr_reader :enun, :options

    def initialize (enun, options)
        @enun = enun
        @options = options
    end
    
    def to_s
        toRet = ""
        toRet << enun << "\n"
        n = 1
        toRet << "#{n}.- #{options[:right]}\n"
        n+=1
        options[:wrong].each do |op|
            toRet<<"#{n}.- #{op}\n"
            n+=1
        end
        toRet
    end
    
end



class Quiz
  attr_accessor :name, :questions

  def initialize(name, &block)
    self.name = name
    self.questions = []

    instance_eval &block 
  end
  
  def to_s
    output = name
    output << "\n#{'*' * name.size}\n\n"
    questions.each_with_index do |question, index|
      output << "#{index + 1}.) #{question}\n"
    end

    output
  end

  def question(text, options = {})
    question = Question.new(text,options)
    questions << question
  end
  
  def wrong (option)
    self.questions[-1].options[:wrong] << option
  end
  
end

quiz = Quiz.new("Cuestionario de LPP 05/12/2014") {
    question 'Cuantos argumentos de tipo bloque puede recibir un metodo?',
        :right => '1',
        :wrong => []
    wrong '2'
    wrong 'muchos'
    wrong 'los que defina el usuario'
        
    question 'En Ruby los bloque son objetos que continen codigo',
        :right=>'Falso',
        :wrong => []
    wrong 'Cierto'
    
    question 'Molas?',
        :right =>'Obvio',
        :wrong => []
    wrong 'No :-('
}

puts quiz.to_s
