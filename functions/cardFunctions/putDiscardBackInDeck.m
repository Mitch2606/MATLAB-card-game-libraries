function [deck] = putDiscardBackInDeck(deck)
% Header:
%   [deck] = putDiscardBackInDeck(deck)
%
% Use:
%   Puts the discarded cards back in the (deck)
%
% Parameters:
%   deck = [4 X 1] cell array. [{avaliable cards}; {drawing order};...
%      {out of play cards}; {discarded cards}];
%
% Optional Parms:
%   N/A   
%
% Written by,
%   Mitchell Wilson; email = mitchell.wilson2606@live.com

% Get the discarded cards from the deck variable
discardCards = deck{4}{1};

% Find the number of suits and how many cards are in each suit
numSuits = size(discardCards, 1);
numCardsInSuit = size(discardCards, 2);

% Replace the cards into the deck
for suit = 1: numSuits
    deck{1}{1}{2, suit}{1} = discardCards(suit, :);
    deck{4}{1}(suit, :) = zeros(1, numCardsInSuit);
end

end

