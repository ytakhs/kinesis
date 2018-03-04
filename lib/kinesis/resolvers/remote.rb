module Kinesis
  module Resolvers
    class Remote < Base
      def resolve
        file_path, local_ref = ref.split("#")
        remote_root = YAML.load(File.read(File.join(base_dir, file_path)))
        ref_keys = local_ref.gsub(/^#\//, "").split(/\//)
        ref_keys.shift
        ref_value = trace(ref_keys, root)

        parent[current_key] = ref_value
      end
    end
  end
end
