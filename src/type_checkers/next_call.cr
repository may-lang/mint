module Mint
  class TypeChecker
    type_error NextCallInvalidInvokation
    type_error NextCallStateTypeMismatch
    type_error NextCallStateNotFound

    def check(node : Ast::NextCall) : Checkable
      entity = stateful?

      raise NextCallInvalidInvokation, {
        "node" => node,
      } unless entity

      node.data.fields.each do |item|
        state =
          entity
            .states
            .find(&.name.value.==(item.key.value))

        raise NextCallStateNotFound, {
          "name"  => item.key.value,
          "node" => node,
        } unless state

        type =
          resolve item.value

        state_type =
          resolve state.type

        raise NextCallStateTypeMismatch, {
          "name"     => item.key.value,
          "expected" => state_type,
          "node"     => item,
          "got"      => type,
        } unless Comparer.compare(state_type, type)
      end

      VOID
    end
  end
end
