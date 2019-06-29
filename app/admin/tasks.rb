ActiveAdmin.register Task do
  permit_params :title, :description, :done, :due_date, :user
end
