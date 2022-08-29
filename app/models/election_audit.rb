class ElectionAudit < ApplicationRecord
    belongs_to :user
    belongs_to :election
    belongs_to :auditable, polymorphic: true
end
