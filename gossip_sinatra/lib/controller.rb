require 'gossip'

class ApplicationController < Sinatra::Base
	get'/' do
		erb :index, locals: {gossips: Gossip.all}
	end

	get '/gossips/new/' do
		erb :new_gossip
	end

	post '/gossips/new/' do
		Gossip.new(params["gossip_author"], params["gossip_content"]).save
		redirect '/'
	end

	get '/gossips/:id/' do
		erb :show, locals: {id: params["id"], gossip: Gossip.find(params["id"].to_i), all_comments: Gossip.all_comments(params["id"])}
		#Gossip.find(params["id"].to_i)
	end


	get '/gossips/:id/edit/' do
		erb :edit, locals: {id: params["id"]}
	end

	post '/gossips/:id/edit/' do
		Gossip.update(params["id"], params["gossip_author"], params["gossip_content"])
		redirect '/'
	end

	post '/gossips/:id/' do
		Gossip.new_comment(params["id"].to_i, params["comment"])
		redirect '/'
	end

	#get '/gossips/:id/comment' do
	#	erb :show, locals: {id: params["id"], gossip: Gossip.find(params["id"].to_i), all_comments: Gossip.all_comments(params["id"].to_i)}
	#end

end