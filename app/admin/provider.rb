ActiveAdmin.register Provider do

  permit_params :name, :email, :password, :password_confirmation, :specialty_id, :phone, :zip_code

  index do
    selectable_column
    column :id
    column :name
    column :specialty 
    column :email
    column :zip_code
    column :phone
    column :last_sign_in_at
    column :sign_in_count
    actions
  end

  form do |f|
    f.inputs do
      f.input :name
      f.input :email
      f.input :password
      f.input :password_confirmation
      f.input :specialty
      f.input :phone
      f.input :zip_code
    end
    f.actions
  end


end
