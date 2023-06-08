# frozen_string_literal: true

module Collections
  class Operations < ApplicationComponent
    include Phlex::Rails::Helpers::LinkTo
    include Phlex::Rails::Helpers::TurboFrameTag

    def initialize(collection:)
      @collection = collection
    end

    def template
      header(class: "pb-4 pt-6 sm:pb-6", data: {controller: "tabs", tabs_panels_outlet: ".panels", tabs_active_class: "text-base text-skin-accented", tabs_inactive_class: "text-base text-skin-dimmed hover:text-skin-muted"}) do
        div(
          class:
            "mx-auto flex flex-wrap items-center gap-6 sm:flex-nowrap"
        ) do
          h1(class: "text-lg font-semibold leading-7 text-skin-base") do
            "Operations"
          end
          div(
            class:
              "order-last flex w-full gap-x-8 text-sm font-semibold leading-6 sm:order-none sm:w-auto sm:border-l sm:border-gray-200 sm:pl-6 sm:leading-7"
          ) do
            link_to(t("collections.show.operations.peek"), "#", class: "text-base text-skin-accented", data: {tabs_target: :tab, action: "tabs#activate"})
            link_to(t("collections.show.operations.query"), "#", class: "text-base text-skin-dimmed hover:text-skin-muted", data: {tabs_target: :tab, action: "tabs#activate"})
            link_to(t("collections.show.operations.add"), "#", class: "text-base text-skin-dimmed hover:text-skin-muted", data: {tabs_target: :tab, action: "tabs#activate"})
          end
          link_to("#", class: "ml-auto flex items-center gap-x-2 button button-accented execute", data: {controller: "execution", action: "execution#execute", execution_panels_outlet: ".panels"}) do
            svg(
              xmlns: "http://www.w3.org/2000/svg",
              fill: "none",
              viewbox: "0 0 24 24",
              stroke_width: "1.5",
              stroke: "currentColor",
              class: "-ml-1.5 h-5 w-5"
            ) do |s|
              s.path(
                stroke_linecap: "round",
                stroke_linejoin: "round",
                d:
                  "M16.023 9.348h4.992v-.001M2.985 19.644v-4.992m0 0h4.992m-4.993 0l3.181 3.183a8.25 8.25 0 0013.803-3.7M4.031 9.865a8.25 8.25 0 0113.803-3.7l3.181 3.182m0-4.991v4.99"
              )
            end
            plain t("collections.show.actions.execute")
          end
        end
      end

      div(data: {controller: "panels", panels_execution_outlet: ".execute"}, class: "panels") do
        div(class: "", data: {panels_target: :panel}) do
          turbo_frame_tag(:peek_embeddings, src: new_peek_embedding_path(collection_id: @collection.id, collection_name: escape_name(@collection.name)))

          div(class: "border-b border-gray-200 pb-5 mt-10")

          turbo_frame_tag(:peek_list_embeddings)
        end
        div(class: "hidden", data: {panels_target: :panel}) do
          turbo_frame_tag(:query_embeddings, loading: :lazy, src: new_query_embedding_path(collection_id: @collection.id, collection_name: escape_name(@collection.name)))

          div(class: "border-b border-gray-200 pb-5 mt-10")

          turbo_frame_tag(:query_list_embeddings)
        end
        div(class: "hidden", data: {panels_target: :panel}) do
          turbo_frame_tag(:add_embeddings, loading: :lazy, src: new_embedding_path(collection_id: @collection.id, collection_name: escape_name(@collection.name)))
        end
      end
    end
  end
end
