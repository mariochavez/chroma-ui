# frozen_string_literal: true

module Collections
  class Show < ApplicationComponent
    def initialize(collection:, embeddings_count:)
      @collection = collection
      @embeddings_count = embeddings_count
    end

    def template
      div(class: "bg-white") do
        div(class: "px-6 py-16 sm:px-6 sm:py-16 lg:px-8") do
          render Collections::ShowHeader.new(collection: @collection, embeddings_count: @embeddings_count)
          render Collections::Operations.new(collection: @collection)
        end
      end
    end
  end
end
