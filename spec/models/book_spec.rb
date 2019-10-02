# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Book, type: :model do
  it { should validate_presence_of(:name) }

  describe '#author' do
    context 'when books belonging to different authors exist' do
      let(:author) { create(:author) }
      let(:other_author) { create(:author) }
      let(:books) { create_list(:book, 3, author: author) }
      let(:other_books) { create_list(:book, 3, author: other_author) }

      it 'returns books by author' do
        expect(Book.authored_by(author.id)).to eq books
      end
    end
  end
end
