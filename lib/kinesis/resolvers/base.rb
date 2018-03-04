module Kinesis
  module Resolvers
    class Base
      attr_reader(
        :root,
        :crumbs,
        :ref,
        :current_key,
        :parent
      )

      def initialize(root:, crumbs:, ref:)
        @root        = root
        @crumbs      = crumbs
        @ref         = ref
        @current_key = crumbs.pop
        @parent      = crumbs.inject(root) { |crumb, ref_key| tree[crumb] }
      end

      private

      def trace(keys, object)
        keys.inject(object) do |tree, key|
          tree[key]
        end
      end
    end
  end
end
