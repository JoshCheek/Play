File.open('insertion-time-complexity.txt','w') do |insertion_file|
  File.open('merge-time-complexity.txt','w') do |merge_file|
    File.open('raw').each do |line|
      n , insertion , merge , ratio = line.split("|").map(&:strip)
      insertion_file .puts "#{n} #{insertion}"
      merge_file     .puts "#{n} #{merge}"
    end
  end
end