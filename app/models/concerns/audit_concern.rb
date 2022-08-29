module AuditConcern
    extend ActiveSupport::Concern

    def create_audit(changes, election_id)
        changes.each do |change|
            if change.first != "updated_at" && change.first != "updated_by"
                self.election_audits.create(election_id: election_id, updated_field: change.first, before_value: change.second.first, after_value: change.second.second, user_id: self.updated_by) 
            end
        end
    end
end