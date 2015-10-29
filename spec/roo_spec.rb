require 'rubygems'
require 'bundler/setup'
require 'roo'
require 'roo-xls'

describe 'Roo' do
  let(:filename) { 'spec/support/data/PDSC_minimal_metadata.xlsx' }

  context 'using default read, which has the incorrect encoding' do
    let(:text) { File.read(filename) }

    it 'can handle StringIO' do
      string_io = StringIO.new(text, 'r')
      pending 'gives an unintuitive error'
      Roo::Spreadsheet.open(string_io, extension: :xlsx)
    end

    context 'with roo-xls trying to read it first' do
      it 'can handle StringIO' do
        string_io = StringIO.new(text, 'r')
        # This will work, because `text` will get mutated to have the correct encoding
        begin
          Roo::Spreadsheet.open(string_io, extension: :xls)
        rescue Ole::Storage::FormatError
        end
        Roo::Spreadsheet.open(string_io, extension: :xlsx)
      end
    end
  end

  context 'using correct encoding of ASCII-8BIT by using binread' do
    let(:text) { File.binread(filename) }

    it 'can handle StringIO' do
      string_io = StringIO.new(text, 'r')
      Roo::Spreadsheet.open(string_io, extension: :xlsx)
    end
  end
end
