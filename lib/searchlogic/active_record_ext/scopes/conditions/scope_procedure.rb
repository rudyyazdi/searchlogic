module Searchlogic
  module ActiveRecordExt
    module Scopes
      module Conditions
        class NamedScopes < Condition

          def scope
            if applicable?
              klass.send(new_method, value).map{|returned_obj| returned_obj.send(klass_symbol)}.flatten
            end
          end

          def value
            args.first
          end

          def applicable?             
            return false unless Searchlogic::ScopeReflection.joined_named_scopes
            /^(#{Searchlogic::ScopeReflection.joined_named_scopes})/ =~ method_name
          end

          def self.matcher
            nil
          end
        end
      end
    end
  end
end