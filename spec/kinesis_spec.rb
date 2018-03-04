require "spec_helper"

RSpec.describe Kinesis do
  describe ".resolve" do
    let(:index_yaml) { YAML.load_file(File.expand_path("../schema/index.yml", __FILE__)) }
    let(:post_yaml) { YAML.load_file(File.expand_path("../schema/post.yml", __FILE__)) }

    subject { Kinesis.resolve(index_yaml, File.expand_path("../schema", __FILE__)) }

    describe "local refenrece" do
      it { expect(subject.dig("paths", "/users", "get")).to eq index_yaml.dig("get") }
    end

    describe "remote reference" do
      it { expect(subject.dig("paths", "/users", "post")).to eq post_yaml }
    end
  end
end
