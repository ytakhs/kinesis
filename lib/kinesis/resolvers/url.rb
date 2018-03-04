require "uri"
require "net/http"
require "json"

module Kinesis
  module Resolvers
    class Url < Base
      def resolve
        path, local_ref = ref.split("#")
        url = URI.parse(path)
        remote_root = JSON.parse(Net::HTTP.get(url))
        ref_keys = local_ref.split(/\//)
        ref_keys.shift
        ref_value = trace(ref_keys, root)

        parent[current_key] = ref_value
      end
    end
  end
end
