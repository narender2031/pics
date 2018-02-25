ActiveAdmin.register User do
    
      controller do
        def permitted_params
          params.permit :utf8,  :authenticity_token, :commit,
                    user: [:first_name, :last_name, :email, :phone, :password, :user_name, :id, :allow_destroy ]
        end
      end
        form do |u|
             u.semantic_errors *u.object.errors.keys
                u.input :first_name
                u.input :last_name
                u.input :email
                u.input :phone
                u.input :password
                u.input :user_name
                u.actions
        end
    end
    