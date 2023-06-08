# frozen_string_literal: true

module QueryEmbeddings
  class List < ApplicationComponent
    include Phlex::Rails::Helpers::TurboFrameTag
    include Phlex::Rails::Helpers::SimpleFormat
    include Phlex::Rails::Helpers::ButtonTo

    def initialize(embeddings:, additional:, collection_id:, collection_name:)
      @embeddings = embeddings
      @additional = additional
      @collection_id = collection_id
      @collection_name = collection_name

      @embeddings.sort! { |a, b| b.distance <=> a.distance }
    end

    def template
      turbo_frame_tag(:query_list_embeddings) do
        h3(class: "mt-4 text-2xl leading-7 text-skin-muted") { t("query_embeddings.list.description", size: @embeddings.size) }
        ul(role: "list", class: "divide-y divide-gray-200") do
          @embeddings.each { |embedding| item(embedding) }
        end
      end
    end

    def item(embedding)
      li(class: "flex flex-wrap justify-between gap-x-6 gap-y-4 py-5 sm:flex-nowrap place-items-start", id: embedding.id) do
        div(class: "w-full") do
          if display_section?(:documents)
            div(class: "mt-3") do
              h3(class: "text-base font-semibold leading-6 text-skin-muted") do
                p(class: "text-skin-dimmed") { t("embedding_results.distance", distance: embedding.distance) }
                p { t("embedding_results.document", id: embedding.id) }
              end
              div(class: "mt-1 text-base leading-6 text-gray-500 border w-full p-4 rounded-md overflow-y-scroll h-52") { simple_format(embedding.document) }
            end
          end

          if display_section?(:embeddings)
            div(class: "mt-3") do
              h3(class: "text-base font-semibold leading-6 text-skin-muted") { t("embedding_results.embeddings") }
              div(class: "mt-3 text-base leading-6 text-gray-500 border w-full p-4 rounded-md overflow-y-scroll h-52") { embedding.embedding&.to_s }
            end
          end

          if display_section?(:metadatas)
            div(class: "mt-3") do
              h3(class: "text-base font-semibold leading-6 text-skin-muted") { t("embedding_results.metadata") }
            end
            div(class: "mt-2 max-w-4xl text-sm text-skin-dimmed grid gap-4 grid-cols-2 sm:grid-cols-4") do
              if embedding.metadata.blank?
                plain "none"
              else
                format_metadata(embedding.metadata, count: :all)
              end
            end
          end
        end
        # dl(class: "flex w-full flex-none justify-between gap-x-8 sm:w-auto m-2 sm:mt-10") do
        #   div(class: "flex -space-x-0.5") do
        #     # button_to "Delete", embedding_path(CGI.escape(embedding.id), collection_id: @collection_id, collection_name: escape_name(@collection_name)), class: "button", method: :delete, data: {turbo_confirm: t("confirmation.delete_embedding", name: embedding.id)}
        #   end
        # end
      end
    end

    private

    def display_section?(section)
      @formated_additional ||= @additional.split(",")&.map(&:strip)

      @formated_additional.include?(section.to_s)
    end
  end
end
