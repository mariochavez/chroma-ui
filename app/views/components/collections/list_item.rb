# frozen_string_literal: true

module Collections
  class ListItem < ApplicationComponent
    include Phlex::Rails::Helpers::LinkTo

    def initialize(collection:)
      @collection = collection
    end

    def template
      li(class: "col-span-1 rounded-lg border bg-white shadow-md") do
        div(
          class: "flex w-full items-center justify-between space-x-6 p-6"
        ) do
          div(class: "flex-1 truncate") do
            div(class: "flex items-center space-x-3") do
              h3(
                class: "truncate text-base font-medium text-skin-base"
              ) do
                link_to @collection.name, collection_path(escape_name(@collection.name)), class: "text-skin-accented hover:text-skin-accented-hover", data: {"turbo-frame": :_top}
              end
              span(
                class:
                  "inline-flex flex-shrink-0 items-center rounded-full bg-gray-50 px-1.5 py-0.5 text-xs font-medium text-skin-muted ring-1 ring-inset ring-gray-600/20"
              ) { embedding_distance_method(@collection.metadata) }
            end
            p(class: "mt-1 text-sm text-skin-dimmed break-all gap-x-2") do
              format_metadata(@collection.metadata)
            end
          end
        end
      end
    end
  end
end
