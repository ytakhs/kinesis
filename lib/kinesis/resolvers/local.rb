module Kinesis
  module Resolvers
    class Local < Base
      def resolve
        ref_keys = ref.gsub(/^#\//, "").split(/\//)
        ref_value = trace(ref_keys, root)

        parent[current_key] = ref_value
      end
    end
  end
end
