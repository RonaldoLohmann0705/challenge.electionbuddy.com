# frozen_string_literal: true

class Election < ApplicationRecord
  include AuditConcern
  has_many :questions
  has_many :election_audits
  has_many :audits, class_name: "ElectionAudit", foreign_key: "election_id"
  has_many :election_audits, as: :auditable
  belongs_to :user

  serialize :settings, Hash

  after_update_commit :audit_changes

  def visibility
    settings[:visibility]
  end

  def visibility=(value)
    settings[:visibility] = value
  end

  def audit_changes
    self.create_audit(previous_changes, self.id)
  end
end
