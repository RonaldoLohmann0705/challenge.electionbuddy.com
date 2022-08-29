# frozen_string_literal: true

class Voter < ApplicationRecord
  include AuditConcern
  belongs_to :election
  has_many :election_audits, as: :auditable
  after_update_commit :audit_changes

  def audit_changes
    self.create_audit(previous_changes, self.election.id)
  end
end
