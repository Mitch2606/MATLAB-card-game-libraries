function [playerHand] = addCardsToHand(currentHand, newCards, numSuits)
% Header:
%   [playerHand] = addCardsToHand(currentHand, newCards, numSuits)
%
% Use:
%   After getting (newCards), this function add them to (currentHand). 
%
% Parameters:
%   currentHand = [1 X numSuits] cell array containing [0-numCardsInSuit]
%              size arrays
%
%   newCards = [1 X numCards] cell array containing [suit, cardNum]
%
%   numSuits = int number of suits in the deck
%
% Optional Parms:
%   N/A
%
% Written by,
%   Mitchell Wilson; email = mitchell.wilson2606@live.com

% Initialize a hand if there isn't one. This means numSuits is
% semi-optional
if(isempty(currentHand))
    playerHand = cell(1, numSuits);
else
    playerHand = currentHand;
end

% Loop through all the cards in newcards 
for entry = 1: length(newCards)
    temp = newCards{entry};
    % Catch Errors or, if newCards is empty
    if(isempty(temp))
        break;
    end

    % make 'later-on' calculations easier:
    playerHand{temp(1)} = sort([playerHand{temp(1)}, temp(2)]); 
end


end

