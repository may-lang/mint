module Mint
  class Ast
    class Use < Node
      getter data, provider, condition

      def initialize(@condition : Expression | Nil,
                     @provider : String,
                     @data : Record,
                     @input : Data,
                     @from : Int32,
                     @to : Int32)
      end
    end
  end
end
