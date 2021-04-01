class ManifestTagRelation < ApplicationRecord
  belongs_to :manifest
  belongs_to :tag
end
