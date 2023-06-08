# frozen_string_literal: true

module PeekEmbeddings
  class Form < ApplicationComponent
    include Phlex::Rails::Helpers::FormWith
    include Phlex::Rails::Helpers::TurboFrameTag
    include Phlex::Rails::Helpers::TokenList
    include Phlex::Rails::Helpers::HiddenFieldTag

    LIMIT = [10, 25, 50]
    ADDITIONAL_PEEK = ["documents, metadatas", "embeddings, documents, metadatas"]

    def initialize(query:, collection_name:)
      @query = query.tap { |q|
        q.limit ||= LIMIT.first
        q.additional ||= additional.first
      }

      @collection_name = collection_name
    end

    def template
      turbo_frame_tag(:peek_embeddings) do
        h3(class: "text-base leading-6 text-skin-muted") { t("peek_embeddings.form.description") }
        form_with model: @query, url: peek_embeddings_path, class: "mt-4 grid gap-6 grid-cols-1 md:grid-cols-4", data: {panel_target: :form} do |form|
          form.hidden_field :collection_id
          hidden_field_tag :collection_name, @collection_name

          div do
            form.label(:limit, class: "label")
            div(class: "mt-2") do
              form.select(:limit, limit_values, {}, class: "select w-full")
            end
          end

          div do
            form.label(:additional, class: "label")
            div(class: "mt-2") do
              form.select(:additional, additional_values, {}, class: "select w-full")
            end
          end

          div(class: "md:col-span-2") do
            attribute_error = attribute_error(:ids)
            form.label(:ids, class: "label")
            div(class: "mt-2") do
              form.text_field(:ids, class: token_list("input w-full", "input-error": attribute_error.present?), placeholder: t("query_embeddings.form.placeholders.ids"), maxlength: 80)
              p(class: "help") { t("query_embeddings.form.help.ids") }
              p(class: "help help-error") { attribute_error } if attribute_error.present?
            end
          end

          div(class: "md:col-span-2") do
            attribute_error = attribute_error(:metadata_filter)
            form.label(:metadata_filter, class: "label")
            div(class: "mt-2") do
              form.text_area(:metadata_filter, class: token_list("input w-full h-52 resize-none", "input-error": attribute_error.present?), placeholder: t("query_embeddings.form.placeholders.metadata_filter"))
              p(class: "help") { t("query_embeddings.form.help.metadata_filter") }
              p(class: "help help-error") { attribute_error } if attribute_error.present?
            end
          end

          div(class: "md:col-span-2") do
            attribute_error = attribute_error(:document_filter)
            form.label(:document_filter, class: "label")
            div(class: "mt-2") do
              form.text_area(:document_filter, class: token_list("input w-full h-52 resize-none", "input-error": attribute_error.present?), placeholder: t("query_embeddings.form.placeholders.document_filter"))
              p(class: "help") { t("query_embeddings.form.help.document_filter") }
              p(class: "help help-error") { attribute_error } if attribute_error.present?
            end
          end
        end
      end
    end

    protected

    def limit_values
      LIMIT.map { |l| [l, l] }
    end

    def additional
      ADDITIONAL_PEEK
    end

    def additional_values
      additional.map { |a| [a, a] }
    end

    def attribute_error(attribute)
      @query.errors[attribute].first
    end
  end
end
