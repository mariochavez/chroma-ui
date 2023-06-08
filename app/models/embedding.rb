# frozen_string_literal: true

class Embedding < ApplicationModel
  attr_accessor :collection_id, :embeddings, :documents, :metadatas, :ids

  validates :collection_id, :documents, :ids, :embeddings, presence: true
  validate :valid_json

  def to_chroma
    valid_json

    return [] if errors.any?

    @data.dig(:documents).map.with_index do |document, index|
      id = @data.dig(:ids, index)
      metadata = @data.dig(:metadatas, index) || {}
      embedding = @data.dig(:embeddings, index)

      Chroma::Resources::Embedding.new(document:, id:, metadata:, embedding:)
    end
  end

  private

  def valid_json
    @data = {}

    [:documents, :ids, :metadatas, :embeddings].each do |attribute|
      value = send(attribute)
      parsed_value = parse_value(attribute, value)

      if !parsed_value.nil? && parsed_value.is_a?(Array)
        @data[attribute] = parsed_value
        errors.add(attribute, :blank) if [:documents, :ids, :embeddings].include?(attribute) && parsed_value.empty?
      elsif parsed_value.nil?
        # Nothing to do
      else
        errors.add(attribute, :invalid)
      end
    end
  end

  def parse_value(attribute, value)
    value.present? ? JSON.parse(value) : nil
  rescue
    errors.add(attribute, :invalid)
    nil
  end
end
