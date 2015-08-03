class RoomsController < ApplicationController

	require "opentok"

	def join_room
    
    config = YAML.load_file("#{Rails.root.to_s}/config/tokbox.yml")[Rails.env]
	  opentok = OpenTok::OpenTok.new(config['TOKBOX_API_KEY'], config['TOKBOX_SECRET_KEY'])
	  location = '1.2.3.4' ##your server ip

		##following code creates a session that uses the OpenTok Media Router:

		#p2p.preference => disabled more than 2 participants can join the same room 
		session = opentok.create_session( {:media_mode => :routed, :location => location, 'p2p.preference' => "disabled"} )

		##generate token for each user
		user = {full_name: 'lalit haryani'}
		@room = opentok.generate_token(session.session_id, {:expire_time => Date.today.to_i+(1 * 24 * 60 * 60), :data => user.full_name})

	end


end