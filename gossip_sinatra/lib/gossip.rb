require 'csv'

class Gossip
attr_accessor :author , :content

	def initialize(author, content)
		@author = author
		@content = content
	end

	def save
		CSV.open("./db/gossip.csv", "ab") do |csv|
			csv << [@author, @content]
		end
	end

	def self.all 
		all_gossips = []
		CSV.read("./db/gossip.csv").each do |csv_line|
			all_gossips << Gossip.new(csv_line[0], csv_line[1])
		end
		return all_gossips
	end

	def self.find(id)
		CSV.read("./db/gossip.csv")[id]
	end

	def self.update(gossip_id, updated_author, uptaded_content)
		CSV.open("./db/gossip2.csv", "a+") do |csv|
		CSV.foreach("./db/gossip.csv", "a+").with_index do |csv_row,i|
			if gossip_id.to_i == i
				csv << [updated_author, uptaded_content]
			else
				csv << csv_row
			end
		end	
		end
		File.delete('./db/gossip.csv')
		system('mv ./db/gossip2.csv ./db/gossip.csv')
	end

	def self.new_comment(id, comment)
		CSV.open("./db/comments.csv", "ab") do |csv|
			csv << [id, comment]
		end
	end

	def self.all_comments(id)
		all_comments = []
		CSV.read("./db/comments.csv").each do |csv_line|
			if csv_line[0].to_i == id.to_i
				all_comments << csv_line[1]
			end
		end
		return all_comments
	end
end
