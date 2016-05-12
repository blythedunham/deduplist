
class DedupListController < ApplicationController

  include Deduper

	def index
	end


	def create

    @results = find_uniques params[:text].split(/[\r\n]+/)

		respond_to do |format|
			format.js 
		end
	end

  # protected


  # def add_unique(set, line)

  #   #decorate
  #   token = decorate line

  #   # add to the results if it is not already a member
  #   return false if set.member?(token)
  #   set << dtoken
  #   true
  # end


  # def find_uniques(lines)
  #   results   = []
  #   set       = Set.new

  #   lines.each do |line|
  #     results << line if add_unique(set, line)
  #   end
  #   results
  # end

  #   def find_uniques_in_file(src, options={})
  #     dest_name   = options[:dest_name]||"outfile.txt"
  #     set         = Set.new
  #     outfile     = nil

  #     File.readlines(src) do |line| 
  #       if add_unique(set, line)
  #         outfile ||= File.open(dest_name, "rw+") 
  #         outfile << line
  #       end
  #     end

  #     outfile
  #   ensure
  #     outfile.close if outfile
  #   end


  # # Return a list of unique items in the order they appear
  # def find_uniques_original
  #   # could use a hash map but set uses less space 
  #   set     = Set.new 
  #   results = []

  #   lines.each do |line|

  #     #decorate
  #     token = line.strip.downcase

  #     # add to the results if it is not already a member
  #     unless set.member?(dtoken)
  #       set       << token
  #       results   << line  # note that blank lines are allowed
  #     end

  #   end
  #   results
  #end


end
