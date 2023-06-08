# frozen_string_literal: true

class ApplicationComponent < Phlex::HTML
  include Phlex::Rails::Helpers::T
  include Phlex::Rails::Helpers::Routes

  if Rails.env.development?
    def before_template
      comment { "Before #{self.class.name}" }
      super
    end
  end

  protected

  def escape_name(name)
    CGI.escape(name.tr(".", " "))
  end

  def embedding_distance_method(metadata)
    metadata ||= {}
    metadata.dig("hnsw:space") || "Cosine"
  end

  def format_metadata(metadata, count: 2)
    metadata ||= {}
    index = 1

    metadata.each_pair do |key, value|
      break if count != :all && index > count

      index += 1

      div do
        span(class: "font-semibold block") { key }
        span(class: "block") { value }
      end
    end
  end
end
