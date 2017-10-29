class Channel < ApplicationRecord
  belongs_to :user
  belongs_to :team
  has_many :messages, as: :messageable, :dependent => :destroy
  validates_presence_of :slug, :user, :team
  validates :slug, format: { with: /\A[a-zA-Z0-9]+(( |_)[a-zA-Z0-9]+)*\Z/ }
  validates_uniqueness_of :slug, :scope => :team_id
end
