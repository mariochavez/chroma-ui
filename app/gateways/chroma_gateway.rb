# frozen_string_literal: true

class ChromaGateway
  def self.configure(host)
    Chroma.connect_host = host
    Chroma.log_level = Rails.env.development? ? Chroma::LEVEL_DEBUG : Chrome::LEVEL_INFO
    Chroma.logger = Rails.logger

    self
  end

  def self.heartbeat
    heartbeat = Chroma::Resources::Database.heartbeat

    [heartbeat, nil]
  rescue => exception
    [nil, exception]
  end

  def self.version
    version = Chroma::Resources::Database.version

    [version, nil]
  rescue => exception
    [nil, exception]
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

  def self.add_embeddings(collection_id, embeddings)
    collection = Chroma::Resources::Collection.new(id: collection_id, name: "temp collection")
    collection.add(embeddings)

    [true, nil]
  rescue => exception
    [false, exception]
  end

  def self.get_embeddings(additional:, collection_id:, ids: nil, limit: 10, metadata_filter: {}, document_filter: {})
    collection = Chroma::Resources::Collection.new(id: collection_id, name: "temp collection")
    embeddings = collection.get(ids:, limit:, where: metadata_filter, where_document: document_filter, include: additional)

    [embeddings, nil]
  rescue => exception
    [[], exception]
  end

  def self.delete_embedding(id:, collection_id:)
    collection = Chroma::Resources::Collection.new(id: collection_id, name: "temp collection")
    collection.delete(ids: Array(id))

    [true, nil]
  rescue => exception
    puts exception
    [false, exception]
  end

  def self.query_embeddings(additional:, collection_id:, embeddings: [], limit: 3, metadata_filter: {}, document_filter: {})
    collection = Chroma::Resources::Collection.new(id: collection_id, name: "temp collection")
    embeddings = collection.query(query_embeddings: embeddings, results: limit, where: metadata_filter, where_document: document_filter, include: additional)

    [embeddings, nil]
  rescue => exception
    [[], exception]
  end
end
