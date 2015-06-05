require 'spec_helper'
require 'coverage_parser'
require 'imei_page_visitor'

describe CoverageParser do

  context 'technical support status of devise is Active' do

    before :all do
      visitor = ImeiPageVisitor.new('013977000323877')
      visitor.get_coverage_page
      @parser = CoverageParser.new(visitor.content)
    end

    describe '#status' do

      it 'is equal to True (Active)' do
        expect(@parser.status).to be_truthy
      end

    end

    describe '#date' do

      it 'is valid Date' do
        expect(@parser.date).to be_kind_of(Date)
      end

    end

  end

  context 'technical support of devise is expired' do

    before :all do
      visitor = ImeiPageVisitor.new('013896000639712')
      visitor.get_coverage_page
      @parser = CoverageParser.new(visitor.content)
    end

    describe '#status' do

      it 'is equal to False (Expired)' do
        expect(@parser.status).to be_falsey
      end

    end

    describe '#date' do

      it 'is nil' do
        expect(@parser.date).to be_nil
      end

    end

  end

end
