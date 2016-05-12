class DedupSet < Set

  # Return true if we have already seen this token
  # Otherwise  the token to the set and return false 
  #
  # ==== Attributes
  # * +token+ - The original line of input text 
  def add_unique(token)

    return true if member?(dtoken = decorate(token))
    add dtoken
    false

  end


  # Decorate a token (before comparing it to ones we have seen)
  # For now, just remove whitespace and downcase
  # Blank strings are allowed
  #
  # ==== Attributes
  # * +token+ - original line of input text 
  #
  # ==== Examples
  #
  #    set.decorate(" aBcD") ==> "abcd"
  def decorate(token)
    token.strip.downcase
  end

end

class DedupFile 

  class << self
    # Read in a +src+ file line by line and return a new file
    # containing the lines without duplicates in the same order the lines
    # first appear
    #
    # ==== Attributes
    # * +src+ - the input file with phrases/or tokens separated by line breaks
    # ==== Options
    # * +dest_name+ - the name of the destination file
    # ==== Returns
    # the output result file containing unique lines in the same order 
    # as the source file
    #
    # ==== Examples
    #   DedupFile.run("myFile.txt")
    # Suppose +myFile.txt+ contains the following:
    #     a
    #     b
    #     b
    #     c
    #     a
    #
    # Returns the following file as output
    #     a
    #     b
    #     c
    def run(src, options={})
      dest_name   = options[:dest_name]||"outfile.txt"
      set         = DedupSet.new
      outfile     = nil

      File.readlines(src) do |line| 
        unless set.seen? line
          outfile ||= File.open(dest_name, "rw+") 
          outfile << line
        end
      end

      outfile
    ensure
      outfile.close if outfile
    end
  end
end