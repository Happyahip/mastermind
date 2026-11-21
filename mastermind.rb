# frozen_string_literal: true

require 'terminal-table'
require 'colorize'

coler_one_to_six = { '1': '1'.red, '2': '2'.yellow, '3': '3'.blue, '4': '4'.green, '5': '5'.white, '6': '6'.black }
one_to_six = [1, 2, 3, 4, 5, 6]
str_one_to_six = %w[1 2 3 4 5 6]
@true_Ans = one_to_six.shuffle.slice(0..3) # rubocop:disable Naming/VariableName,Style/Sample
@play = true
@num = 0
@lose = false
@win = false
@err = false
rows = []
table = Terminal::Table.new headings: %w[猜顏色區 提示區], title: 'mastermind', rows: rows
puts '歡贏來到master mind'
while @play == true
  userans_to_coler = []
  @right_coler = 0
  @correct = 0
  @final_correct = []
  @final_right = []
  puts '請輸入四個數字記得空格（ex:1 2 3 4）'
  user_ans_str = gets.chomp
  user_ans = user_ans_str.split
  user_ans.each do |num|
    if str_one_to_six.include?(num) == false
      @err = true
      @play = false
    end
    next unless user_ans.length != 4

    @err = true
    @play = false
  end
  user_num_ans = []
  user_ans.each do |arr|
    user_num_ans << arr.to_i
  end
  if user_num_ans == @true_Ans
    puts '你猜對了！'.yellow
    puts "你用了#{@num} 局".green
    puts "答案是：#{@true_Ans}".yellow
    puts '遊戲結束'
    @play = false
  else
    @num += 1
    if @num == 10
      @lose = true
      @play = false
    end
    user_ans.uniq.each do |num|
      if @true_Ans.include?(num.to_i) == true # rubocop:disable Style/IfUnlessModifier
        @right_coler += 1
      end
    end
    user_ans.each_with_index do |e, i|
      @correct += 1 if e.to_i == @true_Ans[i]
    end
    right = @right_coler - @correct
    @correct.times do
      @final_correct << 'c '.green
    end
    right.times do
      @final_right << 'r '.red
    end
    user_ans.each do |a|
      userans_to_coler << coler_one_to_six[a.to_sym]
    end
    table.add_row [userans_to_coler.join(' '), [@final_correct, @final_right].join]
    table.add_separator
    puts table
    puts ''
    puts '繼續猜'
    puts "你還有 #{10 - @num} 次機會".blue
    puts '提醒：你只剩下一次機會'.red if @num == 9
    puts '# 錯誤，請輸入正確格式與數字，遊戲中斷 #'.red if @err == true
    if @lose == true
      puts '你輸了'.red
      puts "答案是 #{@true_Ans}".red
      puts '遊戲結束'
    end
  end
end

