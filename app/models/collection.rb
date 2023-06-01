# frozen_string_literal: true

class Collection < ApplicationModel
  DISTANCE_METHODS = ["l2", "ip", "cosine"]
  attr_accessor :id, :name, :distance_method
  attr_writer :metadata

  validates :name, presence: true, length: {maximum: 63, minimum: 3}
  validates :distance_method, presence: true, inclusion: {in: DISTANCE_METHODS}
  validate :valid_name_format
  validate :valid_json_metadata

  def initialize(*args)
    super
    self.distance_method ||= DISTANCE_METHODS.last
    # @invalid_metadata = false
  end

  def metadata
    @metadata ||= {"hnsw:space": distance_method}
  end

  def json_metadata
    metadata.is_a?(Hash) ? metadata.to_json : metadata
  end

  def json_metadata=(value)
    new_metadata = JSON.parse(value || "{}")
    new_metadata["hnsw:space"] = distance_method

    self.metadata = new_metadata
    @invalid_metadata = false
  rescue
    self.metadata = value
    @invalid_metadata = true
  end

  private

  def valid_json_metadata
    return if !@invalid_metadata

    errors.add(:json_metadata, :invalid)
  end

  def valid_name_format
    return if name.blank?

    # Restriction: The name must start and end with a lowercase letter or a digit, and it can contain dots, dashes, and underscores in between.
    # Restriction: The name must not contain two consecutive dots.
    # Restriction: The name must not be a valid IP address.

    # Regular expression pattern for the name validation
    pattern = /\A[a-z\d][\w.-]*[a-z\d]\z/i

    # Regular expression pattern for checking consecutive dots
    consecutive_dots_pattern = /\.{2}/

    # Check if the name matches the pattern and does not have consecutive dots
    if name.match(pattern) && !name.match(consecutive_dots_pattern)
      # Restriction: The name must not be a valid IP address.
      octets = name.split(".")
      return true if !(octets.size == 4 && octets.all? { |octet| octet.to_i.between?(0, 255) })
    end

    errors.add(:name, :invalid)
  end
end
