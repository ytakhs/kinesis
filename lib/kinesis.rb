require "kinesis/resolver"
require "kinesis/resolvers/base"
require "kinesis/resolvers/local"
require "kinesis/resolvers/remote"
require "kinesis/resolvers/url"
require "kinesis/version"

module Kinesis
  def self.resolve(root, base_dir = File.expand_path("."))
    resolver(root, base_dir).resolve
  end

  def self.resolver(root, base_dir = File.expand_path("."))
    Kinesis::Resolver.new(root, base_dir)
  end
end
