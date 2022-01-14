function [playerHand, deck] = discardCards(playerHand, numCards, deck)
% Header:
%   [playerHand, deck] = discardCards(playerHand, numCards, deck)
%
% Use:
%   Puts the discarded cards back in the (deck)
%
% Parameters:
%   playerHand = [1 X numSuits] cell array of [0-numCardsInSuit] int arrays
%
%   numCards = total number of cards being discarded
%
%   deck = [4 X 1] cell array. [{avaliable cards}; {drawing order};...
%      {out of play cards}; {discarded cards}];
%
% Optional Parms:
%   N/A   
%
% Written by,
%   Mitchell Wilson; email = mitchell.wilson2606@live.com

% Names of suits
suits = deck{1}{1}(1,:);

iterator = 1;
displayHand(playerHand, suits)
while(iterator ~= numCards)
    % Get which card they want to discard
    suitName = input("Input Suit Name: ", 's');
    cardNum  = input("Input Card Number: ");
    
    % Get which suit the suit name corresponds to
    suitNum = getSuitNum(suitName, suits);
    
    % If the card doesn't exist in the players hand, then tell them
    if(sum(playerHand{suitNum}(playerHand{suitNum} == cardNum)) == 0)
        disp(cardNum + " of " + suits{suitNum} + " not in hand!")
        continue
    end
    
    % If it is, then get rid of it
    playerHand{suitNum}(playerHand{suitNum} == cardNum) = 0;
    playerHand{suitNum} = removeZeros(playerHand{suitNum});
    
    % Add the card to the discard pile
    deck{4}{1}(suitNum, cardNum) = cardNum; 
        
    iterator = iterator + 1;
%     clc
    
    displayHand(playerHand, suits)
end
