
require 'rails_helper'

RSpec.describe Deduper, :type => :helper do

  describe "#decorate_token" do
    specify{ expect(helper.decorate_token("abc efg")).to eq("abc efg") }
    specify{ expect(helper.decorate_token(" abc efg ")).to eq("abc efg") }
    specify{ expect(helper.decorate_token(" ABC ")).to eq("abc") }
  end

  describe "#add_unique" do
    let(:set){ set = Set.new ["a","b"] }

    specify{ expect(helper.add_unique(set, "a")).to be_truthy }
    specify{ expect(helper.add_unique(set, "A")).to be_falsy }

    specify{ expect(helper.add_unique(set, "c")).to be_truthy }
    specify{ expect(helper.add_unique(set, "C")).to be_truthy }

    specify{ expect(set.length).to eq(2) }
    specify{ expect(set.member?("d")).to be_falsy }

    context "should add non new members" do
      before :each do
        helper.add_unique(set, "D")
      end

      specify{ expect(set.length).to eq(3)} 
      specify{ expect(set.member?("d")).to be_truthy }

    end

    context "should add non new members" do
      before :each do
        helper.add_unique(set, "A")
      end

      specify{ expect(set.length).to eq(2)} 
      specify{ expect(set.member?("a")).to be_truthy }

    end

  end

  describe "#find_uniques_in_file" do
    let(:infile){"/Users/blythedunham/projects/rails/chefsteps/deduplist/bb.txt"}
    let(:outfile){ infile.gsub("bb", "bb_out") }
    let(:expected_out){ "b\nd\na\ne\nc\n" }

    it "should make a file" do
      
      helper.find_uniques_in_file(infile, dest_name: outfile) 
      output = File.read outfile
      expect(output).to eq("b\nd\na\ne\nc\n")
    end

  end
end
