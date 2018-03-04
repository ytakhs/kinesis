module Kinesis
  module Resolvers
    class Local
      attr_reader :root, :crumbs, :ref

      def initialize(root:, crumbs:, ref:)
        @root = root
        @crumbs = crumbs
        @ref = ref
      end

      def resolve
        ref_keys = ref.gsub(/^#\//, "").split(/\//)
        ref_value = ref_keys.inject(root) do |tree, ref_key|
          if tree.is_a?(Array)
            ref_key = ref_key.to_i
          end
          tree[ref_key]
        end
        current_key = crumbs.pop
        target = crumbs.inject(root) { |crumb, ref_key| tree[crumb] }
        target[current_key] = ref_value
      end
    end
  end
end
