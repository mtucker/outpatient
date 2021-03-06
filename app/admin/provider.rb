ActiveAdmin.register Provider do
  permit_params(
    :name, 
    :email, 
    :password, 
    :password_confirmation, 
    :specialty_id, 
    :is_active, 
    :phone, 
    :zip_code
  )

  filter :name
  filter :email
  filter :specialty
  filter :is_active
  filter :zip_code
  filter :phone
  filter :sign_in_count
  filter :last_sign_in_at

  index do
    selectable_column
    column :id
    column :name
    column :email
    column :specialty
    column :is_active
    column :zip_code
    column :phone
    column :sign_in_count
    column :last_sign_in_at
    actions
  end

  form do |f|
    f.inputs do
      f.input :name
      f.input :email
      if f.object.new_record?
        f.input :password
        f.input :password_confirmation
      end
      f.input :specialty
      f.input :is_active
      f.input :phone
      f.input :zip_code
    end
    f.actions
  end

  show do |_p|
    attributes_table do
      row :name
      row :email
      row :specialty
      row :is_active
      row :phone
      row :zip_code
    end
    active_admin_comments
  end
end
