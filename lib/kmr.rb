# encoding: utf-8
module Kmr

  class << self

    def calculate_dbf(text)
      poz, dbf, v = [], [], []
      l, n, pot = 1, text.size, 1

      n.times do |i|
        poz[i], dbf[i] = i, []
        dbf[0][i] = text[i].bytes.first
      end

      while(pot < n)
        0.upto(n-pot-1) { |i| v[i] = [ dbf[l-1][i], dbf[l-1][i+pot] ] }
        (n-pot).upto(n-1) { |i| v[i] = [dbf[l-1][i], 10000] }

        poz.sort! do |a, b|
          v[a].first == v[b].first ? v[a].last <=> v[b].last : v[a].first <=> v[b].first
        end

        akt = 1

        n.times do |i|
          dbf[l][poz[i]] = akt;
          tmp = poz[i+1] || 0
          akt += 1 if v[poz[i]] != v[tmp]
        end

        l += 1
        pot *= 2
      end

      dbf.reject! { |e| e == [] }
      dbf
    end

    def longest_repeated_substring(text)
      dbf = calculate_dbf(text)
      n = text.size
      results, last_occurance, row, base_row = [], {}, [], nil
      max_length, words, columns = -1, [], []

      dbf.each_with_index do |dbf_row, i|
        next if i == 0
        (2**i).upto([2**(i+1)-1, n].min) do |j|
          if j == 2**i
            row = dbf_row
            base_row = dbf_row.dup
          else
            v, tmp, poz = [], [], []
            tmp[j] = 0

            n.times do |c|
              poz[c], v[c] = c, []
              comp = 2**i

              v[c] << [ base_row[c], base_row[c+j-comp] ]
            end

            poz.sort! do |a, b|
              v[a].first == v[b].first ? v[a].last <=> v[b].last : v[a].first <=> v[b].first
            end

            akt = 1
            n.times do |k|
              row[poz[k]] = akt;
              tmp = poz[k+1] || 0
              akt += 1 if v[poz[k]] != v[tmp]
            end
          end

          results[j], last_occurance, columns, new_words = {}, {}, [], []

          row.each_with_index do |e, k|
            if !last_occurance[e] || last_occurance[e] + j - 1 < k
              if results[j][e]
                results[j][e][0] += 1
              else
                results[j][e] = [1, k]
              end
              last_occurance[e] = k
            end
          end

          results[j].each do |id, quantity|
            if quantity.first >= 2 && j > max_length
              max_length = j
              columns = [[id, quantity]]
              words = []
            elsif quantity.first >= 2 && j == max_length
              columns << [id, quantity]
            end
          end

          next unless columns.size > 0

          words = columns.map { |c| text[c.last.last, max_length] }
        end
      end

      words.uniq
    end
  end
end
