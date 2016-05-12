
module Deduper

  # Concerns are bloated for this simple case
  #extend ActiveModel::Concern

  # Read in a +src+ file line by line and return a new file
  # containing the lines without duplicates in the same order the lines
  # first appear
  #
  # ==== Attributes
  # * +lines+ - an Array containing all the individual lines
  # ==== Returns
  # an Array containing the unique lines in the order they originally appeared
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
  def find_uniques(lines)
    results   = []
    set       = Set.new

    lines.each do |line|
      results << line if add_unique(set, line)
    end
    results
  end


  # Read in a +src+ file line by line (avoid slurping) and return a new file
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
  #   find_uniques_in_file("myFile.txt", dest_name:"dedupedFile.out")
  # Suppose +myFile.txt+ contains the following:
  #     a
  #     b
  #     b
  #     c
  #     a
  #
  # The resulting file +dedupedFile.out+ contains:
  #     a
  #     b
  #     c
  def find_uniques_in_file(src, options={})
    dest_name   = options[:dest_name] || "outfile.txt"
    set         = Set.new
    outfile     = nil

    # read line by line (avoid slurping)
    File.foreach(src) do |line| 
      if add_unique(set, line)
        outfile ||= File.open(dest_name, "w+") 
        outfile << line
      end
    end
    outfile

  ensure
    outfile.close if outfile
  end


  # Decorates the line for comparison
  # Just strip whitespace and downcase (to make comparison case insensitive)
  #
  # ==== Attributes
  # * +token+ - The original line of input text
  #
  # ==== Returns
  # the decorated/clean token
  def decorate_token(token)
    return "" if token.blank?
    token.downcase.strip
  end


  # Adds the line (case insensitive and stripped of white space)
  # to the set
  #
  # ==== Attributes
  # * +set+ - The set used to store unique members
  # * +line+ - The original line of input text
  #
  # ==== Returns
  # * true if the line has is unique (new) to the set
  # * false if the line is already in the set
  def add_unique(set, line)

    #decorate
    token = decorate_token line

    # add to the results if it is not already a member
    return false if set.member?(token)
    set << token
    true
  end
end


