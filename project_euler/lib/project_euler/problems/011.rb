require 'project_euler/primes'

module ProjectEuler
  class Problem11
    def initialize
      @input = [
        %w[08 02 22 97 38 15 00 40 00 75 04 05 07 78 52 12 50 77 91 08].map(&:to_i),
        %w[49 49 99 40 17 81 18 57 60 87 17 40 98 43 69 48 04 56 62 00].map(&:to_i),
        %w[81 49 31 73 55 79 14 29 93 71 40 67 53 88 30 03 49 13 36 65].map(&:to_i),
        %w[52 70 95 23 04 60 11 42 69 24 68 56 01 32 56 71 37 02 36 91].map(&:to_i),
        %w[22 31 16 71 51 67 63 89 41 92 36 54 22 40 40 28 66 33 13 80].map(&:to_i),
        %w[24 47 32 60 99 03 45 02 44 75 33 53 78 36 84 20 35 17 12 50].map(&:to_i),
        %w[32 98 81 28 64 23 67 10 26 38 40 67 59 54 70 66 18 38 64 70].map(&:to_i),
        %w[67 26 20 68 02 62 12 20 95 63 94 39 63 08 40 91 66 49 94 21].map(&:to_i),
        %w[24 55 58 05 66 73 99 26 97 17 78 78 96 83 14 88 34 89 63 72].map(&:to_i),
        %w[21 36 23 09 75 00 76 44 20 45 35 14 00 61 33 97 34 31 33 95].map(&:to_i),
        %w[78 17 53 28 22 75 31 67 15 94 03 80 04 62 16 14 09 53 56 92].map(&:to_i),
        %w[16 39 05 42 96 35 31 47 55 58 88 24 00 17 54 24 36 29 85 57].map(&:to_i),
        %w[86 56 00 48 35 71 89 07 05 44 44 37 44 60 21 58 51 54 17 58].map(&:to_i),
        %w[19 80 81 68 05 94 47 69 28 73 92 13 86 52 17 77 04 89 55 40].map(&:to_i),
        %w[04 52 08 83 97 35 99 16 07 97 57 32 16 26 26 79 33 27 98 66].map(&:to_i),
        %w[88 36 68 87 57 62 20 72 03 46 33 67 46 55 12 32 63 93 53 69].map(&:to_i),
        %w[04 42 16 73 38 25 39 11 24 94 72 18 08 46 29 32 40 62 76 36].map(&:to_i),
        %w[20 69 36 41 72 30 23 88 34 62 99 69 82 67 59 85 74 04 36 16].map(&:to_i),
        %w[20 73 35 29 78 31 90 01 74 31 49 71 48 86 81 16 23 57 05 54].map(&:to_i),
        %w[01 70 54 71 83 51 54 69 16 92 33 48 61 43 52 01 89 19 67 48].map(&:to_i),
      ]
    end
    
    def solution
      [grt_right, grt_down, grt_diag].max
    end
    
    def grt_right
      grt_for_rows @input
    end
    
    def grt_down
      grt_for_rows @input.transpose
    end
    
    def grt_diag
      grt_for_rows each_diagonal
    end
    
    def grt_for_rows(rows)
      max = 0
      rows.each do |row| 
        row.each_cons 4 do |a,b,c,d|
          crnt = a*b*c*d
          max = crnt if max < crnt
        end
      end
      max
    end
    
    def each_diagonal
      Enumerator.new do |yielder|
        @input[0..-4].each_index do |y|
          @input.first[0..-4].each_index do |x|
            a = @input[y+0][x+0]
            b = @input[y+1][x+1]
            c = @input[y+2][x+2]
            d = @input[y+3][x+3]
            yielder << [a, b, c, d]
            
            a = @input[y+3][x+0]
            b = @input[y+2][x+1]
            c = @input[y+1][x+2]
            d = @input[y+0][x+3]
            yielder << [a, b, c, d]
          end
        end
      end
    end
  end
end
