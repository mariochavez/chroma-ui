# frozen_string_literal: true

class Query < ApplicationModel
  attr_accessor :limit, :ids, :additional, :metadata_filter, :document_filter, :collection_id, :embeddings

  validate :valid_json

  def to_get
    {limit: limit, collection_id: collection_id, additional: additional.split(", ")}.merge(@data)
  end

  def to_query
    {limit: limit, collection_id: collection_id, additional: additional.split(", ")}.merge(@data)
  end

  private

  def valid_json
    @data = {}

    [:metadata_filter, :document_filter, :ids, :embeddings].each do |attribute|
      value = send(attribute)
      parsed_value = parse_value(attribute, value)

      if !parsed_value.nil? && parsed_value.is_a?(Hash)
        @data[attribute] = parsed_value
        errors.add(attribute, :invalid) if attribute == :ids
      elsif !parsed_value.nil? && parsed_value.is_a?(Array)
        @data[attribute] = parsed_value
        errors.add(attribute, :invalid) if attribute == :metadata_filter || attribute == :document_filter
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
