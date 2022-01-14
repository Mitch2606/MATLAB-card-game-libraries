function [decks] = shuffleDecks(decks,varargin)
% Header:
%   [decks] = shuffleDecks(decks,varargin)
%
% Use:
%   shuffles 1 or more (decks)
%
% Parameters:
%   decks = [4 X numDecks] cell array of decks 
%
% Optional Parms:
%   deckIndices/deckIndex = Which deck(s) in decks need to be shuffled
%
% Written by,
%   Mitchell Wilson; email = mitchell.wilson2606@live.com

% Set defaults for optional parms
deckIndices = [1:size(decks, 2)];

% Assign optional parmss
for entry = 1:2: length(varargin)
    parm = lower(varargin{entry});
    value = varargin{entry + 1};
    
    switch(parm)
        case("deckindices")
            deckIndices = value;
        case("deckindex")
            deckIndices = value;
        otherwise
            disp("Error->shuffleDecks->ParmNotFound: " + parm);
    end
end

% Do the shuffle
for entry = 1: length(deckIndices)
    availableCards = [];
    numCardsInSuit = length(decks{1, deckIndices(entry)}{1}{2,1}{1});
    numSuits = length(decks{1, deckIndices(entry)}{1});

    for suit = 1: numSuits
        temp = decks{1, deckIndices(entry)}{1}{2,suit}{1}(decks{1, deckIndices(entry)}{1}{2,suit}{1} ~= 0);
        availableCards = [availableCards, temp + (numCardsInSuit * (suit - 1))];
    end

    decks{2, deckIndices(entry)}{1} = availableCards(randperm(length(availableCards)));
end


end

