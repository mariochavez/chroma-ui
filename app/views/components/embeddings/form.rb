# frozen_string_literal: true

module Embeddings
  class Form < ApplicationComponent
    include Phlex::Rails::Helpers::FormWith
    include Phlex::Rails::Helpers::TurboFrameTag
    include Phlex::Rails::Helpers::TokenList

    REQUIRED = [:documents, :ids, :embeddings]

    def initialize(embedding:, collection_name:)
      @embedding = embedding
      @collection_name = collection_name
    end

    def template
      turbo_frame_tag(:add_embeddings) do
        h3(class: "text-base leading-6 text-skin-muted") { t("embeddings.form.description") }
        form_with model: @embedding, url: embeddings_path(collection_id: @embedding.collection_id, collection_name: escape_name(@collection_name)), class: "mt-4 grid gap-6 grid-cols-1 md:grid-cols-2", data: {panel_target: :form} do |form|
          form.hidden_field :collection_id
          [:documents, :ids, :metadatas, :embeddings].each { |attribute| build_input(form, attribute) }
        end
      end
    end

    private

    def attribute_error(attribute)
      @embedding.errors[attribute].first
    end

    def build_input(form, attribute)
      div do
        attribute_error = attribute_error(attribute)
        plain form.label(attribute, class: token_list("label text-left inline-block", "input-error": attribute_error.present?))
        span(class: "ml-3 uppercase text-sm text-skin-alternate") { t("embeddings.form.required") } if REQUIRED.include?(attribute)
        div(class: "mt-2") do
          form.text_area(attribute, class: token_list("input w-full h-72 resize-none", "input-error": attribute_error.present?), placeholder: t("embeddings.form.placeholders.#{attribute}"))
          p(class: "help") { t("embeddings.form.help.#{attribute}") }
          p(class: "help help-error") { attribute_error } if attribute_error.present?
        end
      end
    end
  end
end
