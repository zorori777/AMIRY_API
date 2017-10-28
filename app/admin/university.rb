ActiveAdmin.register University do

  permit_params :name

  index do
    column :id
    column :name
    column :circles_count do |item|
      item.circles.size || 0
    end
    column :students_count do |item|
      item.users.size || 0
    end
    column :created_at
    column :updated_at
    actions
  end
end
