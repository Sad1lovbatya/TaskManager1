FactoryBot.define do
  factory :task do
    name
    description

    trait :have_author do
      author factory: :manager
    end
    trait :have_assignee do
      assignee factory: :developer
    end
  end
end
