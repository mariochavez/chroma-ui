# frozen_string_literal: true

module Collections
  class ShowHeader < ApplicationComponent
    include Phlex::Rails::Helpers::TurboFrameTag
    include Phlex::Rails::Helpers::ButtonTo
    include Phlex::Rails::Helpers::LinkTo
    include Phlex::Rails::Helpers::NumberToHuman

    def initialize(collection:, embeddings_count:)
      @collection = collection
      @embeddings_count = embeddings_count
    end

    def template
      turbo_frame_tag(:collection_header) do
        div(class: "lg:flex lg:items-center lg:justify-between") do
          div(class: "min-w-0 flex-1") do
            h2(
              class:
                "mt-2 text-2xl font-bold leading-7 text-skin-base sm:truncate sm:text-3xl sm:tracking-tight"
            ) { @collection.name }
            div(
              class:
                "mt-1 flex flex-col sm:mt-0 sm:flex-row sm:flex-wrap sm:space-x-6"
            ) do
              div(class: "mt-2 flex items-center text-sm text-skin-dimmed") do
                svg(
                  xmlns: "http://www.w3.org/2000/svg",
                  fill: "none",
                  viewbox: "0 0 24 24",
                  stroke_width: "1.5",
                  stroke: "currentColor",
                  class: "mr-1.5 h-5 w-5 flex-shrink-0 text-skin-dimmed"
                ) do |s|
                  s.path(
                    stroke_linecap: "round",
                    stroke_linejoin: "round",
                    d:
                      "M21 7.5l-9-5.25L3 7.5m18 0l-9 5.25m9-5.25v9l-9 5.25M3 7.5l9 5.25M3 7.5v9l9 5.25m0-9v9"
                  )
                end
                span(class: "pr-2") { t("collections.show.embeddings_count") }
                span(class: "text-skin-muted") { number_to_human @embeddings_count }
              end
              div(class: "mt-2 flex items-center text-sm text-skin-dimmed") do
                svg(
                  class: "mr-1.5 h-5 w-5 flex-shrink-0 text-skin-dimmed",
                  viewbox: "0 0 24 24",
                  stroke_width: "1.5",
                  stroke: "currentColor",
                  fill: "none",
                  xmlns: "http://www.w3.org/2000/svg"
                ) do |s|
                  s.path(
                    d:
                      "M3 12c0-3.857 1.286-9 3.857-9 3.857 0 6.429 18 10.286 18C19.714 21 21 15.857 21 12M3 12h2M19 12h2M15.5 12h1M7.5 12h1",
                    stroke_linecap: "round",
                    stroke_linejoin: "round"
                  )
                end
                span(class: "pr-2") { t("collections.show.distance_method") }
                span(class: "text-skin-muted") { embedding_distance_method(@collection.metadata) }
              end
            end
          end
          div(class: "mt-5 flex lg:ml-4 lg:mt-0") do
            span(class: "sm:ml-3") do
              button_to collection_path(
                CGI.escape(@collection.name.tr(".", " "))
              ),
                method: :delete,
                class: "inline-flex items-center button",
                data: {
                  turbo_frame: :_top,
                  turbo_confirm:
                    t(
                      "confirmation.delete_collection",
                      name: @collection.name
                    )
                } do
                svg(
                  xmlns: "http://www.w3.org/2000/svg",
                  fill: "none",
                  viewbox: "0 0 24 24",
                  stroke_width: "1.5",
                  stroke: "currentColor",
                  class: "-ml-0.5 mr-1.5 h-5 w-5 text-skin-dimmed"
                ) do |s|
                  s.path(
                    stroke_linecap: "round",
                    stroke_linejoin: "round",
                    d:
                      "M14.74 9l-.346 9m-4.788 0L9.26 9m9.968-3.21c.342.052.682.107 1.022.166m-1.022-.165L18.16 19.673a2.25 2.25 0 01-2.244 2.077H8.084a2.25 2.25 0 01-2.244-2.077L4.772 5.79m14.456 0a48.108 48.108 0 00-3.478-.397m-12 .562c.34-.059.68-.114 1.022-.165m0 0a48.11 48.11 0 013.478-.397m7.5 0v-.916c0-1.18-.91-2.164-2.09-2.201a51.964 51.964 0 00-3.32 0c-1.18.037-2.09 1.022-2.09 2.201v.916m7.5 0a48.667 48.667 0 00-7.5 0"
                  )
                end
                plain t("collections.show.actions.delete")
              end
            end
            span(class: "ml-3") do
              link_to edit_collection_path(escape_name(@collection.name)), class: "inline-flex items-center button button-accented" do
                svg(
                  xmlns: "http://www.w3.org/2000/svg",
                  fill: "none",
                  viewbox: "0 0 24 24",
                  stroke_width: "1.5",
                  stroke: "currentColor",
                  class: "-ml-0.5 mr-1.5 h-5 w-5"
                ) do |s|
                  s.path(
                    stroke_linecap: "round",
                    stroke_linejoin: "round",
                    d:
                      "M16.862 4.487l1.687-1.688a1.875 1.875 0 112.652 2.652L6.832 19.82a4.5 4.5 0 01-1.897 1.13l-2.685.8.8-2.685a4.5 4.5 0 011.13-1.897L16.863 4.487zm0 0L19.5 7.125"
                  )
                end

                plain t("collections.show.actions.modify")
              end
            end
          end
        end

        div(class: "border-b border-gray-200 pb-5 mt-10") do
          h3(class: "text-base font-semibold leading-6 text-skin-muted") do
            t("collections.show.metadata")
          end
          div(class: "mt-2 max-w-4xl text-sm text-skin-dimmed grid gap-4 grid-cols-2 sm:grid-cols-4") do
            format_metadata(@collection.metadata, count: :all)
          end
        end
      end
    end
  end
end
