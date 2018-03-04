module Kinesis
  class Resolver
    attr_reader :root, :base_dir

    def initialize(root, base_dir)
      @root = root
      @base_dir = File.expand_path(".")
    end

    def resolve(current = root, crumbs = [])
      case current
      when Hash  then resolve_hash(current, crumbs)
      when Array then resolve_array(current, crumbs)
      else current
      end
    end

    private

    def resolve_hash(current, crumbs)
      if (ref = current.fetch("$ref", false))
        if ref.start_with?("#")
          resolve_local(current, crumbs, ref)
        elsif ref.start_with?("http")
          resolve_url(current, crumbs, ref)
        else
          resolve_remote(current, crumbs, ref)
        end
      else
        current.each do |key, value|
          resolve(value, crumbs + [key])
        end
      end
    end

    def resolve_array(current, crumbs)
      current.each_with_index do |item, index|
        resolve(item, crumbs + [index])
      end
    end

    def resolve_local(current, crumbs, ref)
      Resolvers::Local.new(root: root, crumbs: crumbs, ref: ref).resolve
    end

    def resolve_remote(current, crumbs, ref)
      Resolvers::Remote.new(root: root, crumbs: crumbs, ref: ref, base_dir: base_dir).resolve
    end

    def resolve_url(current, crumbs, ref)
      Resolvers::Url.new(root: root, crumbs: crumbs, ref: ref).resolve
    end
  end
end
