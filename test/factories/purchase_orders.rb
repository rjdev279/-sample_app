FactoryBot.define do
  factory :purchase_order do
    client_name { 'Kyle Jordan' }
    amount { 50 }
    tax { 10 }
    vendor { 'John Doe' }
    status { 'draft' }
  end
end
