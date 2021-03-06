# frozen_string_literal: true

require 'rails_helper'

describe ManifestoSectionBuilder do
  context 'when given a markdown document' do
    let(:markdown_text) { File.read('spec/fixtures/manifesto_text.md') }
    let(:markdown_document) { Kramdown::Document.new(markdown_text) }
    let(:manifesto_section) { create(:manifesto_section) }

    subject do
      ManifestoSectionBuilder.new(
        document: markdown_document,
        manifesto_section: manifesto_section
      )
    end

    it 'creates the required ManifestoItems inside the section' do
      subject.build

      expect(ManifestoItem.count).to eq(58)
      expect(ManifestoSection.first.version).to eq(2)

      expect(ParagraphManifestoItem.count).to eq(49)
      expect(ParagraphManifestoItem.first.version).to eq(2)

      expect(OrderedListManifestoItem.count).to eq(1)
      expect(OrderedListManifestoItem.first.list_items.count).to eq(5)
    end

    it 'reuses old ManifestoItems when updating the text of the section' do
      subject.build
      subject.build

      expect(ManifestoItem.count).to eq(58)
      expect(ManifestoSection.first.version).to eq(3)

      expect(ParagraphManifestoItem.count).to eq(49)
      expect(ParagraphManifestoItem.first.version).to eq(3)

      expect(OrderedListManifestoItem.count).to eq(1)
      expect(OrderedListManifestoItem.first.list_items.count).to eq(5)
      expect(OrderedListManifestoItem.first.list_items.last.version).to eq(3)
    end
  end
end
