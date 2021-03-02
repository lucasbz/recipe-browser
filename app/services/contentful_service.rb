# frozen_string_literal: true

# A ContentfulService wrapper specific to retrieve recipe information
class ContentfulService
  def all_recipes
    client.entries(include: 2, content_type: 'recipe').map { |entry| map_recipe entry }
  end

  def find_recipe(id)
    map_recipe client.entry(id)
  end

  private

  def map_recipe(entry)
    OpenStruct.new(id: entry.id, title: entry.title, photo: map_photo(entry),
                   description: entry.description, chef: map_chef(entry), tags: map_tags(entry))
  end

  def map_photo(entry)
    OpenStruct.new(url: "http:#{entry.photo.url}")
  end

  def map_chef(entry)
    OpenStruct.new(name: entry.chef.name)
  rescue Contentful::EmptyFieldError
    nil
  end

  def map_tags(entry)
    entry.tags
  rescue Contentful::EmptyFieldError
    []
  end

  def client
    @client ||= Contentful::Client.new(
      access_token: Rails.application.credentials.contentful[:access_token],
      space: Rails.application.credentials.contentful[:space_id],
      environemnt: Rails.application.credentials.contentful[:environment_id],
      dynamic_entries: :auto,
      raise_errors: true
    )
  end
end
