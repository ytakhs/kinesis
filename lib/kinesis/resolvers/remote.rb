module Kinesis
  module Resolvers
    class Remote < Base
      attr_reader :base_dir

      def initialize(root:, crumbs:, ref:, base_dir:)
        super(root: root, crumbs: crumbs, ref: ref)
        @base_dir = base_dir
      end

      def resolve
        file_path, remote_ref = ref.split("#")
        remote_root = YAML.load(File.read(File.join(base_dir, file_path)))
        remote_ref_keys = remote_ref.gsub(/^#\//, "").split(/\//)
        remote_ref_value = trace(remote_ref_keys, remote_root)

        parent[current_key] = remote_ref_value
      end
    end
  end
end
