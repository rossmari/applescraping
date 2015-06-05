require 'spec_helper'
require 'imei_page_visitor'

describe ImeiPageVisitor do

  context 'imei is valid' do

    before :all do
      @visitor = ImeiPageVisitor.new('013977000323877')
    end

    it 'redirect session to information page' do
      expect(@visitor.session.current_url).to eq('https://selfsolve.apple.com/wcResults.do')
    end

    describe '#content' do

      it 'return html content' do
        expect(@visitor.content).to match(/<!DOCTYPE html>/)
      end

    end

  end

  context 'imei is invalid' do

    before :all do
      @visitor = ImeiPageVisitor.new('invalid imei')
    end

    it 'return error if imei invalid' do
      expect(@visitor.session).to have_content('Please enter a valid serial number.')
    end

    describe '#content' do

      it 'raise an exception' do
        expect{@visitor.content}.to raise_error(StandardError)
      end

    end

  end

end
