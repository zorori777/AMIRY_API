module APIComponents
  module Entities
    class Live < Grape::Entity
      expose :id,                  documentation: { required: true, type: 'Integer', desc: 'The primary id of the circle.' }
      expose :circle_name,         documentation: { required: true, type: 'String',  desc: 'The name of the circle where a live is to be held.' }
      expose :description,         documentation: { required: true, type: 'String',  desc: 'The description of the live.' }
      expose :max_capacity,        documentation: { required: true, type: 'Integer', desc: 'The capacity of the live.' }
      expose :reservations_count,  documentation: { required: true, type: 'Integer', desc: 'The reservations count for the live.' }
      expose :hold_at,             documentation: { required: true, type: 'String',  desc: 'When the live is to be held at.' }
      expose :available_seats_num, documentation: { required: true, type: 'Integer', desc: 'The number of available seats.' }
      expose :image_urls,          documentation: { required: true, type: 'String',  desc: 'The urls of the images for the live.', is_array: true }
    end
  end
end
