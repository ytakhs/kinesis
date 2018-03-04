module Kinesis
  module Resolvers
    class Remote
      attr_reader :root, :crumbs, :ref, :base_dir

      def initialize(root:, crumbs:, ref:, base_dir:)
        @root = root
        @crumbs = crumbs
        @ref = ref
        @base_dir = base_dir
      end

      def resolve
        file_path, local_ref = ref.split("#")
        remote_root = YAML.load(File.read(File.join(base_dir, file_path)))
        ref_keys = local_ref.gsub(/^#\//, "").split(/\//)
        ref_keys.shift
        ref_value = ref_keys.inject(remote_root) do |tree, ref_key|
          return nil unless tree
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
