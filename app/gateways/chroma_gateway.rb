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

  def self.collections
    collections = Chroma::Resources::Collection.list

    [collections, nil]
  rescue => exception
    [[], exception]
  end

  def self.add_collection(name:, metadata:)
    count = collections.size
    collection = Chroma::Resources::Collection.create(name, metadata)

    [collection, count, nil]
  rescue => exception
    [nil, 0, exception]
  end

  def self.get_collection(name, include_count: true)
    collection = Chroma::Resources::Collection.get(name)

    embeddings_count = 0
    embeddings_count = collection.count if include_count

    [collection, embeddings_count, nil]
  rescue => exception
    [nil, 0, exception]
  end

  def self.delete_collection(name)
    Chroma::Resources::Collection.delete(name)

    [true, nil]
  rescue => exception
    [false, exception]
  end

  def self.modify_collection(collection, name, metadata)
    collection.modify(name, new_metadata: metadata)

    [collection, nil]
  rescue => exception
    [collection, exception]
  end
end
