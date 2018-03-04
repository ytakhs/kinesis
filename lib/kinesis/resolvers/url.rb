require "uri"
require "net/http"
require "json"

module Kinesis
  module Resolvers
    class Url
      attr_reader :root, :crumbs, :ref

      def initialize(root:, crumbs:, ref:)
        @root = root
        @crumbs = crumbs
        @ref = ref
      end

      def resolve
        path, local_ref = ref.split("#")
        url = URI.parse(path)
        remote_root = JSON.parse(Net::HTTP.get(url))
        ref_keys = local_ref.split(/\//)
        ref_keys.shift
        ref_value = ref_keys.inject(remote_root) do |tree, ref_key|
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
