# frozen_string_literal: true

module Collections
  class List < ApplicationComponent
    include Phlex::Rails::Helpers::LinkTo
    include Phlex::Rails::Helpers::TurboFrameTag

    def initialize(collections:)
      @collections = collections
    end

    def template
      div(class: "bg-white") do
        div(class: "px-6 py-16 sm:px-6 sm:py-16 lg:px-8") do
          headings_template

          ul(
            id: "collection_items",
            role: "list",
            class:
              "mx-auto grid grid-cols-1 gap-6 sm:grid-cols-2 lg:grid-cols-4 mt-8"
          ) do
            @collections.each { |collection| render Collections::ListItem.new(collection: collection) }
          end
        end
      end
    end

    private

    def headings_template
      div(class: "md:flex md:items-center md:justify-between") do
        div(class: "min-w-0 flex-1") do
          h2(
            class:
              "text-2xl font-bold leading-7 text-skin-base sm:truncate sm:text-3xl sm:tracking-tight"
          ) { t("collections.index.title") }
        end
        div(class: "mt-4 flex md:ml-4 md:mt-0") do
          a(href: "https://docs.trychroma.com/usage-guide#using-collections", target: "_blank", class: "button") do
            span { t("collections.index.actions.learn_more") }
            span(aria_hidden: "true") { "→" }
          end
          link_to t("collections.index.actions.add"), new_collection_path, class: "ml-3 inline-flex items-center button button-accented", data: {action: "modal#open", "submit-label": "Create collection"}
        end
      end
    end
  end
end
