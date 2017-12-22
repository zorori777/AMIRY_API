module APIComponents
  module Entities
    class User < Grape::Entity
      expose :id,                   documentation: { required: true, type: 'Integer', desc: 'The primary id.' }
      expose :university_name,      documentation: { required: true, type: 'String',  desc: 'The name of the university that the user belongs to.' }
      expose :first_name,           documentation: { required: true, type: 'String',  desc: 'The first name of the user.' }
      expose :last_name,            documentation: { required: true, type: 'String',  desc: 'The last name of the user.' }
      expose :display_name,         documentation: { required: true, type: 'String',  desc: 'The display name of the user.' }
      expose :email,                documentation: { required: true, type: 'String',  desc: 'The user\'s email.' }
      expose :avatar_link,          documentation: { required: true, type: 'String',  desc: 'The link of the avatar.' }
      expose :catch_copy,           documentation: { required: true, type: 'String',  desc: 'The user\'s catchcopy.' }
      expose :self_introduction,    documentation: { required: true, type: 'String',  desc: 'The user\'s self-introduction.' }
      expose :bands_count,          documentation: { required: true, type: 'Integer', desc: 'The number of bands that the user belongs to.' }
      expose :received_likes_count, documentation: { required: true, type: 'Integer', desc: 'The number of likes that the user has received.' }
      expose :sendable_likes_count, documentation: { required: true, type: 'Integer', desc: 'The number of likes that the user can send.' }
      expose :matchings_count,      documentation: { required: true, type: 'Integer', desc: 'The number of matchings that the user has.' }
      expose :account_status,       documentation: { required: true, type: 'Integer', desc: 'Whether the user account is active or not.' }
      expose :created_at,           documentation: { required: true, type: 'Integer', desc: 'When the user got created.' }
    end
  end
end
