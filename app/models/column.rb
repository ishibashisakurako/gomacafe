class Column < ApplicationRecord

  belongs_to :user
  has_rich_text :body

  enum status: { draft: 0, publish: 1, secret: 2 }

  scope :draft_columns, -> { where(status: 'draft') }
  scope :publish_columns, -> { where(status: 'publish') }
  scope :secret_columns, -> { where(status: 'secret') }

end
