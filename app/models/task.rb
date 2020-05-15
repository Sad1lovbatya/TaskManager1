class Task < ApplicationRecord
    belongs_to :author, class_name: 'User'
    belongs_to :assignee, class_name: 'User', optional: true
    validates :name, presence: true
    validates :description, presence: true
    validates :author, presence: true
    validates :description, length: { maximum: 500 }
  
    state_machine initial: :new_task do
      state :new_task
      state :in_qa
      state :in_code_review
      state :in_development
      state :ready_for_release
      state :released
      state :archived
  
      event :begin_develop do
        transition [:in_qa, :new_task, :in_code_review] => :in_development
      end
      event :begin_qa do
        transition in_development: :in_qa
      end
      event :finish_qa do
        transition in_qa: :in_code_review
      end
      event :finish_review do
        transition in_code_review: :ready_for_release
      end
      event :finish_release do
        transition ready_for_release: :released
      end
      event :archive do
        transition [:new_task, :released] => :archived
      end
    end
  end