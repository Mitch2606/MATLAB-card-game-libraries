function displayHand(playerHand, suits)
% Header:
%   displayHand(playerHand, suits)
%
% Use:
%   displays the (suits) and the cards within each suit in the (playerHand)
%
% Parameters:
%   playerHand = [1 X numSuits] cell array of [0-numCardsInSuit] int arrays
%   
%   suits = [1 X numSuits] cell array of the suit names
%
% Optional Parms:
%   N/A
%
% Written by,
%   Mitchell Wilson; email = mitchell.wilson2606@live.com

% Loop through each suit and display each suit name and cards
for suit = 1: length(playerHand)
    if(~isempty(playerHand{suit}))
        disp(suits{suit}{1})
        disp(playerHand{suit})
    end
end

