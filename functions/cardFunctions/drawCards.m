function [newCards, deck] = drawCards(deck, numCards, varargin)
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
%   numCards = total number of cards being draw in this instance
%
% Optional Parms:
%   allowDeckRest = boolean that determines if when the deck is empty, 
%       the discard pile is shuffled back into the deck 
%
% Written by,
%   Mitchell Wilson; email = mitchell.wilson2606@live.com

% Assign optional parmss
allowDeckReset = 0;
for entry = 1:2: length(varargin)
    parm = lower(varargin{entry});
    value = varargin{entry + 1};
    switch(parm)
        case("allowdeckreset")
            allowDeckReset = value;
        otherwise
            disp("Error->drawCards->ParmNotFound: " + parm);
    end
end

% Constants:
numCardsInSuit = length(deck{1}{1}{2, 1}{1});
numSuits = size(deck{1}{1}, 2);

% Begin Drawing cards:
newCards = cell(1, numCards);
for cardIndex = 1: numCards
    if((isempty(deck{2, 1}{1})) && (~allowDeckReset))
        numEmpty = 0;
        for suit = 1: numSuits
            numEmpty = numEmpty + isempty(newCards{suit});
        end
        
        if(numEmpty == numSuits)
            newCards = [];
        end
        
        return;
    elseif(allowDeckReset)
        deck = putDiscardBackInDeck(deck);
        deck = shuffleDecks(deck);
    end
    
    % Get the card number:
    cardNumber = deck{2, 1}{1}(1);

    % Update the deck order:
    % I read from the front of the list but this can be reversed
    deck{2, 1}{1} = deck{2, 1}{1}(2:end);
    
    suitNum = 1;
    while(cardNumber > numCardsInSuit)
        cardNumber = cardNumber - numCardsInSuit;
        suitNum = suitNum + 1;
    end

    card = deck{1,1}{1}{2, suitNum}{1}(cardNumber);
    deck{1,1}{1}{2, suitNum}{1}(cardNumber) = 0;

    newCards(cardIndex) = {[suitNum, card]};
end

end

