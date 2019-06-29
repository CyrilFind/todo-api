ActiveAdmin.register User do
  permit_params :uid, :name, :nickname, :image, :email

  form do |f|
    f.inputs :uid
    f.inputs :name
    f.inputs :nickname
    f.inputs :image
    f.inputs :email
    f.actions
  end
end
