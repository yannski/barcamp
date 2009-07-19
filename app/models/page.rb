class Page < ActiveRecord::Base

  translatable_columns :title
  translatable_columns :body
  translatable_columns :slug

  def to_param
    slug
  end
end
