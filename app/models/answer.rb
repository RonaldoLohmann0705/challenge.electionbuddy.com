# frozen_string_literal: true

class Answer < ApplicationRecord
  include AuditConcern
  belongs_to :question
  has_many :election_audits, as: :auditable
  after_update_commit :audit_changes
  
  def audit_changes
    self.create_audit(previous_changes, self.question.election.id)
  end
end
