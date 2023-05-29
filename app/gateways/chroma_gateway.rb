# frozen_string_literal: true

class ChromaGateway
  def self.configure(host)
    Chroma.connect_host = host
    Chroma.log_level = case Rails.logger.level
    when 0 then Chroma::LEVEL_DEBUG
    when 1 then Chroma::LEVEL_INFO
    else Chroma::LEVEL_ERROR
    end

    Chroma.logger = Rails.logger

    self
  end

  def self.version
    Chroma::Resources::Database.version
  end
end
