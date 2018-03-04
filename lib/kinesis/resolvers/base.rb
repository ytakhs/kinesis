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
        @parent      = crumbs.inject(root) { |tree, crumb| tree[crumb] }
      end

      private

      def trace(keys, object)
        keys.inject(object) do |tree, key|
          if tree.is_a?(Array)
            tree[key.to_i]
          else
            tree.fetch(key) { |key| tree[key.to_sym] }
          end
        end
      end
    end
  end
end
