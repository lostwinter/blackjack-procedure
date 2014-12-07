# Command line blackjack game

def calculate_total(cards)
  arr = cards.map {|e| e[1] }
  total = 0
  arr.each do |value|
      if value == 'A'
          total += 11
      elsif value.to_i == 0
          total += 10
      else 
          total += value.to_i
      end
  end
# Correct for aces
  arr.select{|e| e == "A"}.count.times do 
      total -= 10 if total > 21
  end
  total
end
# End of methods
########################################################

# Procedure

puts "Welcome to Blackjack, Sucka!"

suits = ['H', 'D', 'S', 'C']
cards = ['2', '3', '4', '5', '6', '7', '8', '9', '10', 'J', 'Q', 'K', 'A']

# This is how to do it without the product() method:
# deck = []
# suits.each do |suit|
#     cards.each do |card|
#         deck << [suit, card]
#     end
# end

deck = suits.product(cards)
deck.shuffle!

# Deal cards
player_hand = []
dealer_hand = []

player_hand << deck.pop
dealer_hand << deck.pop
player_hand << deck.pop
dealer_hand << deck.pop

dealer_total = calculate_total(dealer_hand)
player_total = calculate_total(player_hand)




# Show cards
puts "Dealer has a #{dealer_hand[0]}, and a #{dealer_hand[1]} for a total of #{dealer_total}."
puts "You have a #{player_hand[0]}, and a #{player_hand[1]} for a total of #{player_total}."

if player_total == 21
  puts "A natural 21. You win!!!" 
  exit
end

while player_total < 21
  puts "Do you want to hit or stay?"
  hit_or_stay = gets.chomp.downcase
  if !['hit', 'stay'].include?(hit_or_stay)
      puts "Error. Enter 'hit' or 'stay.'"
      next
  end

  if hit_or_stay == "stay"
      puts "You picked 'stay.'"
      break
  end
# Hit for more cards
      new_card = deck.pop
      puts "You drew a #{new_card}"
      player_hand << new_card
      player_total = calculate_total(player_hand)
      puts "Your new total is #{player_total}."

      if player_total == 21
          puts "Congrats, homie. You win!"
          exit
      elsif player_total > 21
          puts "You busted, fool. Try again!"
          exit
      end
  end

  # Dealer's turn
  if dealer_total == 21
    puts "Dealer hit blackjack. You lose."
  end
  while dealer_total < 17
    dealer_hand << deck.pop
    dealer_total = calculate_total(dealer_hand)
    puts "Dealer has #{dealer_total}."
  end

  if dealer_total > 21
    puts "Dealer busts. You win!"
    exit
  else puts "Dealer has #{dealer_total}. Dealer stays."
  end

# Compare totals
  puts "Okay, the dealer has #{dealer_total} and you have #{player_total}"
  if dealer_total == player_total
    puts "You and the dealer are tied. Push the bet!"
    exit
  elsif dealer_total > player_total
    "Dealer wins!"
  else "You win!"
  end
  puts "Thanks for playing Blackjack."


